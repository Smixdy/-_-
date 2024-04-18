CREATE TRIGGER GenerateLoginOnInsert
ON �����������
AFTER INSERT
AS
BEGIN
    DECLARE @id INT;
    DECLARE @email NVARCHAR(100);
    DECLARE @login NVARCHAR(100);

    SELECT @id = ID_�����������, @email = �����
    FROM inserted;

    -- ���������� ����� �� ������ Email
    SET @login = SUBSTRING(@email, 1, CHARINDEX('@', @email) - 1) + '_' + CAST(@id AS NVARCHAR);

    -- ��������� ������������ ������
    WHILE EXISTS (SELECT 1 FROM ����������� WHERE ����� = @login)
    BEGIN
        SET @login = @login + '_'; 
    END;

    -- ��������� �����
    UPDATE �����������
    SET ����� = @login
    WHERE ID_����������� = @id;
END;