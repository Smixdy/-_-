CREATE PROCEDURE [dbo].[GetVisitReports]
    @ReportType int, -- 1 - Количество посещений, 2 - Список лиц на территории
    @GroupByDepartment bit = 0, -- 0 - без группировки, 1 - группировка по подразделениям
    @DateFrom date = NULL,
    @DateTo date = NULL
AS
BEGIN
    IF @ReportType = 1 -- Количество посещений
    BEGIN
        SELECT
            CASE WHEN @GroupByDepartment = 1 THEN p.Название_подразделения ELSE 'Все подразделения' END AS Подразделение,
            CONVERT(VARCHAR, z.Время_прихода, 104) AS Дата_посещения,
            COUNT(*) AS Количество_посещений
        FROM Заявка z
        LEFT JOIN Подразделение p ON z.Ответственное_подразделение = p.ID_Подразделения
        WHERE z.Время_прихода BETWEEN ISNULL(@DateFrom, '19000101') AND ISNULL(@DateTo, '99991231')
        GROUP BY 
            CASE WHEN @GroupByDepartment = 1 THEN p.Название_подразделения ELSE 'Все подразделения' END,
            CONVERT(VARCHAR, z.Время_прихода, 104);
    END
    ELSE IF @ReportType = 2 -- Список лиц на территории
    BEGIN
        SELECT
            v.Фамилия, 
            v.Имя,
            v.Отчество,
            v.Организация,
            p.Название_подразделения AS Подразделение
        FROM Заявка z
        LEFT JOIN Посетитель v ON z.ID_Постетителя = v.ID_Посетителя
        LEFT JOIN Подразделение p ON z.Ответственное_подразделение = p.ID_Подразделения
        WHERE z.ID_Состояние = 1 -- Состояние "Внутри"
        AND z.Время_прихода BETWEEN ISNULL(@DateFrom, '19000101') AND ISNULL(@DateTo, '99991231')
        GROUP BY
            v.Фамилия, v.Имя, v.Отчество, v.Организация, p.Название_подразделения;
    END
    ELSE
    BEGIN
        RAISERROR('Неверный тип отчета', 16, 1);
    END
END;