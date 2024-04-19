CREATE PROCEDURE [dbo].[GetVisitReports]
    @ReportType int, -- 1 - ���������� ���������, 2 - ������ ��� �� ����������
    @GroupByDepartment bit = 0, -- 0 - ��� �����������, 1 - ����������� �� ��������������
    @DateFrom date = NULL,
    @DateTo date = NULL
AS
BEGIN
    IF @ReportType = 1 -- ���������� ���������
    BEGIN
        SELECT
            CASE WHEN @GroupByDepartment = 1 THEN p.��������_������������� ELSE '��� �������������' END AS �������������,
            CONVERT(VARCHAR, z.�����_�������, 104) AS ����_���������,
            COUNT(*) AS ����������_���������
        FROM ������ z
        LEFT JOIN ������������� p ON z.�������������_������������� = p.ID_�������������
        WHERE z.�����_������� BETWEEN ISNULL(@DateFrom, '19000101') AND ISNULL(@DateTo, '99991231')
        GROUP BY 
            CASE WHEN @GroupByDepartment = 1 THEN p.��������_������������� ELSE '��� �������������' END,
            CONVERT(VARCHAR, z.�����_�������, 104);
    END
    ELSE IF @ReportType = 2 -- ������ ��� �� ����������
    BEGIN
        SELECT
            v.�������, 
            v.���,
            v.��������,
            v.�����������,
            p.��������_������������� AS �������������
        FROM ������ z
        LEFT JOIN ���������� v ON z.ID_����������� = v.ID_����������
        LEFT JOIN ������������� p ON z.�������������_������������� = p.ID_�������������
        WHERE z.ID_��������� = 1 -- ��������� "������"
        AND z.�����_������� BETWEEN ISNULL(@DateFrom, '19000101') AND ISNULL(@DateTo, '99991231')
        GROUP BY
            v.�������, v.���, v.��������, v.�����������, p.��������_�������������;
    END
    ELSE
    BEGIN
        RAISERROR('�������� ��� ������', 16, 1);
    END
END;