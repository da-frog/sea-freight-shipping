IF OBJECT_ID('dbo.ContainerModel', 'U') IS NOT NULL
    DELETE FROM ContainerModel;
GO
SET IDENTITY_INSERT ContainerModel ON;
INSERT INTO ContainerModel [Container Model Key], [ISO Size Code], [ISO Type Code], [Model Description], [Owner Code], [Serial Number Range Start], [Serial Number Range End], [Inside Length (mm)], [Inside Width (mm)], [Inside Height (mm)], [Inside Middle Height (mm)], [Inside Side Height (mm)], [Max stow Height], [Roof Opening Length (mm)], [Roof Opening Width (mm)], [Door Opening Width (mm)], [Door Opening Height (mm)], [Door Opening Width C (mm)], [Door Opening Width D (mm)], [Door Opening Width B (mm)], [Door Opening Height E (mm)], [Door Opening Height F (mm)], [Max Gross Weight (kg)], [Tare Weight (kg)], [Max Payload Weight (kg)], [Capacity (cbm)] VALUES
