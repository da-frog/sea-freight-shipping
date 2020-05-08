IF OBJECT_ID('dbo.Voyage', 'U') IS NOT NULL
    DELETE FROM Voyage;
GO
SET IDENTITY_INSERT Voyage ON;
INSERT INTO Voyage ([Voyage Key], [Leg Bridge Key], [Origin Port Key], [Destination Port Key]) VALUES
    (1,1,1685,1481),
    (2,2,2796,2199),
    (3,3,4216,670),
    (4,4,3155,670),
    (5,5,4184,672),
    (6,6,859,672),
    (7,7,1599,233),
    (8,8,2333,669),
    (9,9,2859,233),
    (10,10,2368,1482),
    (11,11,1164,233);
