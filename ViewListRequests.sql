CREATE VIEW ViewListRequests AS
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
    ���������� v ON z.ID_����������� = v.ID_����������;