IF OBJECT_ID('dbo.ContainerCompany', 'U') IS NOT NULL
    TRUNCATE TABLE ContainerCompany;
GO
INSERT INTO ContainerCompany VALUES
    ('HLAU', 'Hapag-Lloyd'),
    ('HLBU', 'Hapag-Lloyd'),
    ('HLXU', 'Hapag-Lloyd'),
    ('LNXU', 'Hapag-Lloyd'),
    ('CPSU', 'Hapag-Lloyd');
