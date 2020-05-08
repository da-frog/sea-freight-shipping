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
    (21,12,21),
    (22,12,22),
    (23,13,23),
    (24,13,24),
    (25,14,25),
    (26,14,26),
    (27,15,27),
    (28,15,28),
    (29,16,29),
    (30,16,30),
    (31,17,31),
    (32,17,32),
    (33,18,33),
    (34,18,34),
    (35,19,35),
    (36,19,36),
    (37,20,37),
    (38,20,38),
    (39,21,39),
    (40,21,40),
    (41,22,41),
    (42,22,42),
    (43,23,43),
    (44,23,44),
    (45,24,45),
    (46,24,46),
    (47,25,47),
    (48,25,48),
    (49,26,49),
    (50,26,50),
    (51,27,51),
    (52,27,52),
    (53,28,53),
    (54,28,54),
    (55,29,55),
    (56,29,56),
    (57,30,57),
    (58,30,58),
    (59,32,59),
    (60,32,60),
    (61,33,61),
    (62,33,62),
    (63,34,63),
    (64,34,64),
    (65,35,65),
    (66,35,66),
    (67,36,67),
    (68,36,68),
    (69,37,69),
    (70,37,70),
    (71,38,71),
    (72,38,72),
    (73,39,73),
    (74,39,74),
    (75,40,75),
    (76,40,76),
    (77,41,77),
    (78,41,78),
    (79,42,79),
    (80,42,80),
    (81,43,81),
    (82,43,82),
    (83,44,83),
    (84,44,84),
    (85,45,85),
    (86,45,86),
    (87,46,87),
    (88,46,88),
    (89,47,89),
    (90,47,90),
    (91,49,91),
    (92,49,92),
    (93,50,93),
    (94,50,94),
    (95,51,95),
    (96,51,96),
    (97,52,97),
    (98,52,98),
    (99,53,99),
    (100,53,100),
    (101,54,101),
    (102,54,102),
    (103,55,103),
    (104,55,104),
    (105,56,105),
    (106,56,106),
    (107,57,107),
    (108,57,108),
    (109,58,109),
    (110,58,110),
    (111,59,111),
    (112,59,112),
    (113,60,113),
    (114,60,114),
    (115,61,115),
    (116,61,116),
    (117,63,117),
    (118,63,118),
    (119,64,119),
    (120,64,120),
    (121,65,121),
    (122,65,122),
    (123,66,123),
    (124,66,124),
    (125,67,125),
    (126,67,126),
    (127,68,127),
    (128,68,128),
    (129,69,129),
    (130,69,130),
    (131,71,131),
    (132,71,132),
    (133,73,133),
    (134,73,134),
    (135,74,135),
    (136,74,136),
    (137,75,137),
    (138,75,138),
    (139,76,139),
    (140,76,140),
    (141,77,141),
    (142,77,142),
    (143,78,143),
    (144,78,144),
    (145,79,145),
    (146,79,146),
    (147,80,147),
    (148,80,148),
    (149,81,149),
    (150,81,150),
    (151,83,151),
    (152,83,152),
    (153,84,153),
    (154,84,154),
    (155,85,155),
    (156,85,156),
    (157,86,157),
    (158,86,158),
    (159,87,159),
    (160,87,160),
    (161,88,161),
    (162,88,162),
    (163,89,163),
    (164,89,164),
    (165,91,165),
    (166,91,166),
    (167,93,167),
    (168,93,168),
    (169,94,169),
    (170,94,170),
    (171,95,171),
    (172,95,172),
    (173,96,173),
    (174,96,174),
    (175,97,175),
    (176,97,176),
    (177,98,177),
    (178,98,178),
    (179,99,179),
    (180,99,180),
    (181,100,181),
    (182,100,182),
    (183,101,183),
    (184,101,184),
    (185,102,185),
    (186,102,186),
    (187,103,187),
    (188,103,188),
    (189,104,189),
    (190,104,190),
    (191,105,191),
    (192,105,192),
    (193,106,193),
    (194,106,194),
    (195,107,195),
    (196,107,196),
    (197,108,197),
    (198,108,198),
    (199,109,199),
    (200,109,200),
    (201,110,201),
    (202,110,202),
    (203,111,203),
    (204,111,204),
    (205,112,205),
    (206,112,206),
    (207,113,207),
    (208,113,208),
    (209,114,209),
    (210,114,210),
    (211,116,211),
    (212,116,212),
    (213,117,213),
    (214,117,214),
    (215,118,215),
    (216,118,216),
    (217,119,217),
    (218,119,218),
    (219,121,219),
    (220,121,220),
    (221,122,221),
    (222,122,222),
    (223,123,223),
    (224,123,224),
    (225,124,225),
    (226,124,226),
    (227,125,227),
    (228,125,228),
    (229,126,229),
    (230,126,230),
    (231,127,231),
    (232,127,232),
    (233,128,233),
    (234,128,234),
    (235,130,235),
    (236,130,236),
    (237,131,237),
    (238,131,238),
    (239,132,239),
    (240,132,240),
    (241,133,241),
    (242,133,242),
    (243,134,243),
    (244,134,244),
    (245,135,245),
    (246,135,246),
    (247,136,247),
    (248,136,248),
    (249,137,249),
    (250,137,250),
    (251,138,251),
    (252,138,252),
    (253,139,253),
    (254,139,254),
    (255,140,255),
    (256,140,256),
    (257,141,257),
    (258,141,258),
    (259,142,259),
    (260,142,260),
    (261,143,261),
    (262,143,262),
    (263,144,263),
    (264,144,264),
    (265,145,265),
    (266,145,266),
    (267,146,267),
    (268,146,268),
    (269,147,269),
    (270,147,270),
    (271,148,271),
    (272,148,272),
    (273,151,273),
    (274,151,274),
    (275,152,275),
    (276,152,276),
    (277,153,277),
    (278,153,278),
    (279,154,279),
    (280,154,280),
    (281,155,281),
    (282,155,282),
    (283,156,283),
    (284,156,284),
    (285,157,285),
    (286,157,286),
    (287,159,287),
    (288,159,288),
    (289,160,289),
    (290,160,290),
    (291,161,291),
    (292,161,292),
    (293,162,293),
    (294,162,294),
    (295,164,295),
    (296,164,296),
    (297,165,297),
    (298,165,298),
    (299,166,299),
    (300,166,300),
    (301,167,301),
    (302,167,302),
    (303,168,303),
    (304,168,304),
    (305,169,305),
    (306,169,306),
    (307,170,307),
    (308,170,308),
    (309,172,309),
    (310,172,310),
    (311,173,311),
    (312,173,312),
    (313,174,313),
    (314,174,314),
    (315,176,315),
    (316,176,316),
    (317,177,317),
    (318,177,318),
    (319,178,319),
    (320,178,320),
    (321,179,321),
    (322,179,322),
    (323,180,323),
    (324,180,324),
    (325,182,325),
    (326,182,326),
    (327,183,327),
    (328,183,328),
    (329,185,329),
    (330,185,330),
    (331,186,331),
    (332,186,332),
    (333,187,333),
    (334,187,334),
    (335,188,335),
    (336,188,336),
    (337,189,337),
    (338,189,338),
    (339,190,339),
    (340,190,340),
    (341,191,341),
    (342,191,342),
    (343,192,343),
    (344,192,344),
    (345,193,345),
    (346,193,346),
    (347,194,347),
    (348,194,348),
    (349,195,349),
    (350,195,350),
    (351,196,351),
    (352,196,352),
    (353,197,353),
    (354,197,354),
    (355,199,355),
    (356,199,356),
    (357,200,357),
    (358,200,358),
    (359,201,359),
    (360,201,360),
    (361,203,361),
    (362,203,362),
    (363,204,363),
    (364,204,364),
    (365,205,365),
    (366,205,366),
    (367,206,367),
    (368,206,368),
    (369,207,369),
    (370,207,370),
    (371,208,371),
    (372,208,372),
    (373,210,373),
    (374,210,374),
    (375,211,375),
    (376,211,376),
    (377,212,377),
    (378,212,378),
    (379,213,379),
    (380,213,380),
    (381,214,381),
    (382,214,382),
    (383,215,383),
    (384,215,384),
    (385,216,385),
    (386,216,386),
    (387,218,387),
    (388,218,388),
    (389,221,389),
    (390,221,390),
    (391,222,391),
    (392,222,392),
    (393,223,393),
    (394,223,394),
    (395,224,395),
    (396,224,396),
    (397,225,397),
    (398,225,398),
    (399,227,399),
    (400,227,400),
    (401,228,401),
    (402,228,402),
    (403,230,403),
    (404,230,404),
    (405,231,405),
    (406,231,406),
    (407,232,407),
    (408,232,408),
    (409,235,409),
    (410,235,410),
    (411,237,411),
    (412,237,412),
    (413,238,413),
    (414,238,414),
    (415,239,415),
    (416,239,416),
    (417,241,417),
    (418,241,418),
    (419,242,419),
    (420,242,420),
    (421,243,421),
    (422,243,422),
    (423,244,423),
    (424,244,424),
    (425,246,425),
    (426,246,426),
    (427,248,427),
    (428,248,428),
    (429,249,429),
    (430,249,430),
    (431,250,431),
    (432,250,432),
    (433,251,433),
    (434,251,434),
    (435,252,435),
    (436,252,436),
    (437,253,437),
    (438,253,438),
    (439,254,439),
    (440,254,440),
    (441,255,441),
    (442,255,442),
    (443,256,443),
    (444,256,444),
    (445,257,445),
    (446,257,446),
    (447,258,447),
    (448,258,448),
    (449,259,449),
    (450,259,450),
    (451,260,451),
    (452,260,452),
    (453,261,453),
    (454,261,454),
    (455,263,455),
    (456,263,456),
    (457,264,457),
    (458,264,458),
    (459,265,459),
    (460,265,460),
    (461,268,461),
    (462,268,462),
    (463,269,463),
    (464,269,464),
    (465,270,465),
    (466,270,466),
    (467,271,467),
    (468,271,468),
    (469,272,469),
    (470,272,470),
    (471,273,471),
    (472,273,472),
    (473,275,473),
    (474,275,474),
    (475,277,475),
    (476,277,476),
    (477,279,477),
    (478,279,478),
    (479,280,479),
    (480,280,480),
    (481,281,481),
    (482,281,482),
    (483,282,483),
    (484,282,484),
    (485,283,485),
    (486,283,486),
    (487,284,487),
    (488,284,488),
    (489,287,489),
    (490,287,490),
    (491,288,491),
    (492,288,492),
    (493,290,493),
    (494,290,494),
    (495,292,495),
    (496,292,496),
    (497,293,497),
    (498,293,498),
    (499,294,499),
    (500,294,500),
    (501,295,501),
    (502,295,502),
    (503,296,503),
    (504,296,504),
    (505,297,505),
    (506,297,506),
    (507,299,507),
    (508,299,508),
    (509,301,509),
    (510,301,510),
    (511,302,511),
    (512,302,512),
    (513,304,513),
    (514,304,514),
    (515,305,515),
    (516,305,516),
    (517,306,517),
    (518,306,518),
    (519,307,519),
    (520,307,520),
    (521,310,521),
    (522,310,522),
    (523,311,523),
    (524,311,524),
    (525,312,525),
    (526,312,526),
    (527,313,527),
    (528,313,528),
    (529,314,529),
    (530,314,530),
    (531,315,531),
    (532,315,532),
    (533,316,533),
    (534,316,534),
    (535,317,535),
    (536,317,536),
    (537,318,537),
    (538,318,538),
    (539,320,539),
    (540,320,540),
    (541,321,541),
    (542,321,542),
    (543,322,543),
    (544,322,544),
    (545,324,545),
    (546,324,546),
    (547,325,547),
    (548,325,548),
    (549,326,549),
    (550,326,550),
    (551,327,551),
    (552,327,552),
    (553,330,553),
    (554,330,554),
    (555,332,555),
    (556,332,556),
    (557,333,557),
    (558,333,558),
    (559,334,559),
    (560,334,560),
    (561,337,561),
    (562,337,562),
    (563,338,563),
    (564,338,564),
    (565,339,565),
    (566,339,566),
    (567,340,567),
    (568,340,568),
    (569,341,569),
    (570,341,570),
    (571,343,571),
    (572,343,572),
    (573,345,573),
    (574,345,574),
    (575,346,575),
    (576,346,576),
    (577,349,577),
    (578,349,578),
    (579,351,579),
    (580,351,580),
    (581,352,581),
    (582,352,582),
    (583,357,583),
    (584,357,584),
    (585,358,585),
    (586,358,586),
    (587,359,587),
    (588,359,588),
    (589,360,589),
    (590,360,590),
    (591,361,591),
    (592,361,592),
    (593,363,593),
    (594,363,594),
    (595,365,595),
    (596,365,596),
    (597,366,597),
    (598,366,598),
    (599,367,599),
    (600,367,600),
    (601,368,601),
    (602,368,602),
    (603,369,603),
    (604,369,604),
    (605,370,605),
    (606,370,606),
    (607,372,607),
    (608,372,608),
    (609,373,609),
    (610,373,610),
    (611,374,611),
    (612,374,612),
    (613,376,613),
    (614,376,614),
    (615,377,615),
    (616,377,616),
    (617,378,617),
    (618,378,618),
    (619,379,619),
    (620,379,620),
    (621,380,621),
    (622,380,622),
    (623,381,623),
    (624,381,624),
    (625,382,625),
    (626,382,626),
    (627,383,627),
    (628,383,628),
    (629,387,629),
    (630,387,630),
    (631,388,631),
    (632,388,632),
    (633,389,633),
    (634,389,634),
    (635,391,635),
    (636,391,636),
    (637,392,637),
    (638,392,638),
    (639,394,639),
    (640,394,640),
    (641,397,641),
    (642,397,642),
    (643,398,643),
    (644,398,644),
    (645,399,645),
    (646,399,646),
    (647,400,647),
    (648,400,648),
    (649,402,649),
    (650,402,650),
    (651,403,651),
    (652,403,652),
    (653,405,653),
    (654,405,654),
    (655,406,655),
    (656,406,656),
    (657,407,657),
    (658,407,658),
    (659,408,659),
    (660,408,660),
    (661,409,661),
    (662,409,662),
    (663,410,663),
    (664,410,664),
    (665,412,665),
    (666,412,666),
    (667,413,667),
    (668,413,668),
    (669,414,669),
    (670,414,670),
    (671,416,671),
    (672,416,672),
    (673,417,673),
    (674,417,674),
    (675,419,675),
    (676,419,676),
    (677,420,677),
    (678,420,678),
    (679,421,679),
    (680,421,680),
    (681,422,681),
    (682,422,682),
    (683,425,683),
    (684,425,684),
    (685,432,685),
    (686,432,686),
    (687,434,687),
    (688,434,688),
    (689,435,689),
    (690,435,690),
    (691,437,691),
    (692,437,692),
    (693,438,693),
    (694,438,694),
    (695,441,695),
    (696,441,696),
    (697,445,697),
    (698,445,698),
    (699,446,699),
    (700,446,700),
    (701,454,701),
    (702,454,702),
    (703,456,703),
    (704,456,704),
    (705,457,705),
    (706,457,706),
    (707,458,707),
    (708,458,708),
    (709,459,709),
    (710,459,710),
    (711,461,711),
    (712,461,712),
    (713,462,713),
    (714,462,714),
    (715,463,715),
    (716,463,716),
    (717,464,717),
    (718,464,718),
    (719,465,719),
    (720,465,720),
    (721,466,721),
    (722,466,722),
    (723,467,723),
    (724,467,724),
    (725,469,725),
    (726,469,726),
    (727,470,727),
    (728,470,728),
    (729,471,729),
    (730,471,730),
    (731,472,731),
    (732,472,732),
    (733,473,733),
    (734,473,734),
    (735,474,735),
    (736,474,736),
    (737,475,737),
    (738,475,738),
    (739,476,739),
    (740,476,740),
    (741,477,741),
    (742,477,742),
    (743,478,743),
    (744,478,744),
    (745,481,745),
    (746,481,746),
    (747,483,747),
    (748,483,748),
    (749,485,749),
    (750,485,750),
    (751,488,751),
    (752,488,752),
    (753,490,753),
    (754,490,754),
    (755,491,755),
    (756,491,756),
    (757,493,757),
    (758,493,758);
