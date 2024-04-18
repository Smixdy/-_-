CREATE TRIGGER GenerateLoginOnInsert
ON Авторизация
AFTER INSERT
AS
BEGIN
    DECLARE @id INT;
    DECLARE @email NVARCHAR(100);
    DECLARE @login NVARCHAR(100);

    SELECT @id = ID_Авторизации, @email = Почта
    FROM inserted;

    -- Генерируем логин на основе Email
    SET @login = SUBSTRING(@email, 1, CHARINDEX('@', @email) - 1) + '_' + CAST(@id AS NVARCHAR);

    -- Проверяем уникальность логина
    WHILE EXISTS (SELECT 1 FROM Авторизация WHERE Логин = @login)
    BEGIN
        SET @login = @login + '_'; 
    END;

    -- Обновляем логин
    UPDATE Авторизация
    SET Логин = @login
    WHERE ID_Авторизации = @id;
END;