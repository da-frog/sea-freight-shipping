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
    (9,6,9),
    (10,6,10),
    (11,7,11),
    (12,7,12),
    (13,8,13),
    (14,8,14),
    (15,9,15),
    (16,9,16),
    (17,10,17),
    (18,10,18),
    (19,11,19),
    (20,11,20),
    (21,13,21),
    (22,13,22),
    (23,14,23),
    (24,14,24),
    (25,15,25),
    (26,15,26),
    (27,16,27),
    (28,16,28),
    (29,17,29),
    (30,17,30),
    (31,18,31),
    (32,18,32),
    (33,19,33),
    (34,19,34),
    (35,20,35),
    (36,20,36),
    (37,21,37),
    (38,21,38),
    (39,22,39),
    (40,22,40),
    (41,23,41),
    (42,23,42),
    (43,24,43),
    (44,24,44),
    (45,26,45),
    (46,26,46),
    (47,28,47),
    (48,28,48),
    (49,30,49),
    (50,30,50),
    (51,31,51),
    (52,31,52),
    (53,32,53),
    (54,32,54),
    (55,33,55),
    (56,33,56),
    (57,34,57),
    (58,34,58),
    (59,35,59),
    (60,35,60),
    (61,36,61),
    (62,36,62),
    (63,37,63),
    (64,37,64),
    (65,38,65),
    (66,38,66),
    (67,39,67),
    (68,39,68),
    (69,40,69),
    (70,40,70),
    (71,41,71),
    (72,41,72),
    (73,42,73),
    (74,42,74),
    (75,43,75),
    (76,43,76),
    (77,44,77),
    (78,44,78),
    (79,45,79),
    (80,45,80),
    (81,46,81),
    (82,46,82),
    (83,47,83),
    (84,47,84),
    (85,49,85),
    (86,49,86),
    (87,51,87),
    (88,51,88),
    (89,52,89),
    (90,52,90),
    (91,53,91),
    (92,53,92),
    (93,55,93),
    (94,55,94),
    (95,56,95),
    (96,56,96),
    (97,57,97),
    (98,57,98),
    (99,58,99),
    (100,58,100),
    (101,59,101),
    (102,59,102),
    (103,60,103),
    (104,60,104),
    (105,61,105),
    (106,61,106),
    (107,62,107),
    (108,62,108),
    (109,63,109),
    (110,63,110),
    (111,64,111),
    (112,64,112),
    (113,65,113),
    (114,65,114),
    (115,66,115),
    (116,66,116),
    (117,67,117),
    (118,67,118),
    (119,68,119),
    (120,68,120),
    (121,69,121),
    (122,69,122),
    (123,70,123),
    (124,70,124),
    (125,71,125),
    (126,71,126),
    (127,72,127),
    (128,72,128),
    (129,73,129),
    (130,73,130),
    (131,74,131),
    (132,74,132),
    (133,75,133),
    (134,75,134),
    (135,76,135),
    (136,76,136),
    (137,78,137),
    (138,78,138),
    (139,79,139),
    (140,79,140),
    (141,80,141),
    (142,80,142),
    (143,81,143),
    (144,81,144),
    (145,83,145),
    (146,83,146),
    (147,84,147),
    (148,84,148),
    (149,85,149),
    (150,85,150),
    (151,86,151),
    (152,86,152),
    (153,87,153),
    (154,87,154),
    (155,88,155),
    (156,88,156);
