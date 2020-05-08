IF OBJECT_ID('dbo.VoyageSchedule', 'U') IS NOT NULL
    DELETE FROM VoyageSchedule;
GO
SET IDENTITY_INSERT VoyageSchedule ON;
INSERT INTO VoyageSchedule ([Voyage Schedule Key], [Voyage Key], [Leg Schedule Bridge Key]) VALUES
    (1,1,1),
    (2,1,2),
    (3,2,3),
    (4,2,4),
    (5,3,5),
    (6,3,6),
    (7,4,7),
    (8,4,8),
    (9,5,9),
    (10,5,10),
    (11,6,11),
    (12,6,12),
    (13,7,13),
    (14,7,14),
    (15,8,15),
    (16,8,16),
    (17,9,17),
    (18,9,18),
    (19,10,19),
    (20,10,20),
    (21,11,21),
    (22,11,22);
