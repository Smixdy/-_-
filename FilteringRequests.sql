CREATE PROCEDURE FilteringRequests
    @GroupApplication bit = NULL,
    @DepartmentId int = NULL,
    @StatusId int = NULL
AS
BEGIN
    SELECT 
        z.ID_Заявки,
        z.Дата_подачи,
        z.Желаемый_срок_начала_пропуска,
        z.Желаемый_срок_окончания_пропуска,
        p.Название_подразделения AS Подразделение,
        s.Название_статус AS Статус,
        v.Фамилия + ' ' + v.Имя + ' ' + v.Отчество AS ФИО_Посетителя,
        v.Организация,
        z.Коментарий
    FROM 
        Заявка z
    INNER JOIN 
        Подразделение p ON z.Ответственное_подразделение = p.ID_Подразделения
    INNER JOIN 
        Статус s ON z.Статус_заявки = s.ID_Статуса
    LEFT JOIN 
        Посетитель v ON z.ID_Постетителя = v.ID_Посетителя
    WHERE
        (@GroupApplication IS NULL OR z.Групповая_запись = @GroupApplication)
        AND (@DepartmentId IS NULL OR z.Ответственное_подразделение = @DepartmentId)
        AND (@StatusId IS NULL OR z.Статус_заявки = @StatusId);
END;