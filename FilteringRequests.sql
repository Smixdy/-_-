CREATE PROCEDURE FilteringRequests
    @GroupApplication bit = NULL,
    @DepartmentId int = NULL,
    @StatusId int = NULL
AS
BEGIN
    SELECT 
        z.ID_������,
        z.����_������,
        z.��������_����_������_��������,
        z.��������_����_���������_��������,
        p.��������_������������� AS �������������,
        s.��������_������ AS ������,
        v.������� + ' ' + v.��� + ' ' + v.�������� AS ���_����������,
        v.�����������,
        z.����������
    FROM 
        ������ z
    INNER JOIN 
        ������������� p ON z.�������������_������������� = p.ID_�������������
    INNER JOIN 
        ������ s ON z.������_������ = s.ID_�������
    LEFT JOIN 
        ���������� v ON z.ID_����������� = v.ID_����������
    WHERE
        (@GroupApplication IS NULL OR z.���������_������ = @GroupApplication)
        AND (@DepartmentId IS NULL OR z.�������������_������������� = @DepartmentId)
        AND (@StatusId IS NULL OR z.������_������ = @StatusId);
END;