IF OBJECT_ID('dbo.ContainerModel', 'U') IS NOT NULL
    DELETE FROM ContainerModel;
GO
SET IDENTITY_INSERT ContainerModel ON;
INSERT INTO ContainerModel ([Container Model Key], [ISO Size Code], [ISO Type Code], [Model Description], [Owner Code], [Serial Number Range Start], [Serial Number Range End], [Inside Length (mm)], [Inside Width (mm)], [Inside Height (mm)], [Inside Middle Height (mm)], [Inside Side Height (mm)], [Max stow Height], [Roof Opening Length (mm)], [Roof Opening Width (mm)], [Door Opening Width (mm)], [Door Opening Height (mm)], [Door Opening Width C (mm)], [Door Opening Width D (mm)], [Door Opening Width B (mm)], [Door Opening Height E (mm)], [Door Opening Height F (mm)], [Max Gross Weight (kg)], [Tare Weight (kg)], [Max Payload Weight (kg)], [Capacity (m^3)]) VALUES
    (31,N'45',N'G0',N'Wooden floor',N'HLBU',106300,109299,12032,2432,2700,NULL,NULL,NULL,NULL,NULL,2340,2597,NULL,NULL,NULL,NULL,NULL,32500,3850,28650,76.3),
    (19,N'42',N'G0',N'Wooden floor',N'HLBU',112100,114899,12032,2352,2395,NULL,NULL,NULL,NULL,NULL,2340,2292,NULL,NULL,NULL,NULL,NULL,32500,3750,28750,67.7),
    (26,N'42',N'G1',N'Wooden floor',N'HLBU',112100,114899,12032,2352,2395,NULL,NULL,NULL,NULL,NULL,2340,2292,NULL,NULL,NULL,NULL,NULL,32500,3750,28750,67.7),
    (32,N'45',N'G0',N'Wooden floor',N'HLBU',114900,116524,12032,2432,2700,NULL,NULL,NULL,NULL,NULL,2340,2597,NULL,NULL,NULL,NULL,NULL,32500,3850,28650,76.3),
    (2,N'22',N'G0',N'Wooden floor',N'HLXU',115000,132999,5900,2352,2395,NULL,NULL,NULL,NULL,NULL,2340,2292,NULL,NULL,NULL,NULL,NULL,32500,2350,30150,33.2),
    (10,N'22',N'G1',N'Wooden floor',N'HLXU',115000,132999,5900,2352,2395,NULL,NULL,NULL,NULL,NULL,2340,2292,NULL,NULL,NULL,NULL,NULL,32500,2350,30150,33.2),
    (17,N'42',N'G0',N'Wooden floor',N'HLBU',124400,127699,12032,2352,2395,NULL,NULL,NULL,NULL,NULL,2340,2292,NULL,NULL,NULL,NULL,NULL,32500,3700,28800,67.7),
    (24,N'42',N'G1',N'Wooden floor',N'HLBU',124400,127699,12032,2352,2395,NULL,NULL,NULL,NULL,NULL,2340,2292,NULL,NULL,NULL,NULL,NULL,32500,3700,28800,67.7),
    (39,N'45',N'G0',N'Steel floor',N'HLBU',127700,128699,12032,2342,2700,NULL,NULL,NULL,NULL,NULL,2340,2597,NULL,NULL,NULL,NULL,NULL,32500,3830,28670,76.3),
    (35,N'45',N'G0',N'Wooden floor',N'HLBU',128700,133499,12032,2342,2700,NULL,NULL,NULL,NULL,NULL,2340,2597,NULL,NULL,NULL,NULL,NULL,32500,3900,28600,76.3),
    (1,N'22',N'G0',N'Wooden floor',N'HLBU',136800,139299,5900,2352,2393,NULL,NULL,NULL,NULL,NULL,2340,2292,NULL,NULL,NULL,NULL,NULL,32500,2300,30200,33.2),
    (8,N'22',N'G0',N'Steel floor',N'HLBU',136800,139299,5900,2352,2395,NULL,NULL,NULL,NULL,NULL,2340,2292,NULL,NULL,NULL,NULL,NULL,32500,2300,30200,33.2),
    (9,N'22',N'G1',N'Wooden floor',N'HLBU',136800,139299,5900,2352,2393,NULL,NULL,NULL,NULL,NULL,2340,2292,NULL,NULL,NULL,NULL,NULL,32500,2300,30200,33.2),
    (16,N'22',N'G1',N'Steel floor',N'HLBU',136800,139299,5900,2352,2395,NULL,NULL,NULL,NULL,NULL,2340,2292,NULL,NULL,NULL,NULL,NULL,32500,2300,30200,33.2),
    (33,N'45',N'G0',N'Wooden floor',N'HLBU',141100,144399,12032,2352,2700,NULL,NULL,NULL,NULL,NULL,2340,2597,NULL,NULL,NULL,NULL,NULL,32500,3900,28600,76.3),
    (34,N'45',N'G0',N'Wooden floor',N'HLBU',147300,149799,12032,2352,2700,NULL,NULL,NULL,NULL,NULL,2340,2597,NULL,NULL,NULL,NULL,NULL,32500,3900,28600,76.3),
    (20,N'42',N'G0',N'Wooden floor',N'HLBU',151600,153899,12032,2352,2395,NULL,NULL,NULL,NULL,NULL,2340,2292,NULL,NULL,NULL,NULL,NULL,32500,3750,28750,67.7),
    (27,N'42',N'G1',N'Wooden floor',N'HLBU',151600,153899,12032,2352,2395,NULL,NULL,NULL,NULL,NULL,2340,2292,NULL,NULL,NULL,NULL,NULL,32500,3750,28750,67.7),
    (4,N'22',N'G0',N'Wooden floor',N'CPSU',170000,183199,5898,2352,2393,NULL,NULL,NULL,NULL,NULL,2340,2280,NULL,NULL,NULL,NULL,NULL,30480,2300,28180,33.0),
    (12,N'22',N'G1',N'Wooden floor',N'CPSU',170000,183199,5898,2352,2393,NULL,NULL,NULL,NULL,NULL,2340,2280,NULL,NULL,NULL,NULL,NULL,30480,2300,28180,33.0),
    (74,N'22',N'R1',N'Non-Foodstuff',N'HLXU',171150,171249,5535,2316,2331,NULL,NULL,2211,NULL,NULL,2316,2290,NULL,NULL,NULL,NULL,NULL,30480,3030,27450,29.9),
    (80,N'22',N'R9',N'Non-Foodstuff',N'HLXU',171150,171249,5535,2316,2331,NULL,NULL,2211,NULL,NULL,2316,2290,NULL,NULL,NULL,NULL,NULL,30480,3030,27450,29.9),
    (75,N'22',N'R1',N'Non-Foodstuff',N'HLXU',171250,171643,5535,2284,2270,NULL,NULL,2150,NULL,NULL,2290,2264,NULL,NULL,NULL,NULL,NULL,30480,2290,27580,28.7),
    (81,N'22',N'R9',N'Non-Foodstuff',N'HLXU',171250,171643,5535,2284,2270,NULL,NULL,2150,NULL,NULL,2290,2264,NULL,NULL,NULL,NULL,NULL,30480,2290,27580,28.7),
    (5,N'22',N'G0',N'Steel floor',N'HLBU',171950,173449,5900,2352,2393,NULL,NULL,NULL,NULL,NULL,2340,2292,NULL,NULL,NULL,NULL,NULL,32500,2250,30250,33.2),
    (13,N'22',N'G1',N'Steel floor',N'HLBU',171950,173449,5900,2352,2393,NULL,NULL,NULL,NULL,NULL,2340,2292,NULL,NULL,NULL,NULL,NULL,32500,2250,30250,33.2),
    (6,N'22',N'G0',N'Steel floor',N'HLBU',173450,174949,5900,2352,2393,NULL,NULL,NULL,NULL,NULL,2340,2292,NULL,NULL,NULL,NULL,NULL,32500,2250,30250,33.2),
    (14,N'22',N'G1',N'Steel floor',N'HLBU',173450,174949,5900,2352,2393,NULL,NULL,NULL,NULL,NULL,2340,2292,NULL,NULL,NULL,NULL,NULL,32500,2250,30250,33.2),
    (38,N'45',N'G0',N'Steel floor',N'HLBU',174950,175149,12032,2342,2700,NULL,NULL,NULL,NULL,NULL,2340,2597,NULL,NULL,NULL,NULL,NULL,32500,3950,28500,76.3),
    (63,N'22',N'P3',N'Flat/Platform',N'HLXU',268600,268799,NULL,NULL,2235,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,34000,2740,31260,NULL),
    (62,N'22',N'P3',N'Flat/Platform',N'HLXU',268800,269199,NULL,NULL,2219,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,34000,2740,31260,NULL),
    (3,N'22',N'G0',N'Wooden floor',N'HLXU',339700,346799,5900,2352,2395,NULL,NULL,NULL,NULL,NULL,2340,2292,NULL,NULL,NULL,NULL,NULL,32500,2350,30150,33.2),
    (11,N'22',N'G1',N'Wooden floor',N'HLXU',339700,346799,5900,2352,2395,NULL,NULL,NULL,NULL,NULL,2340,2292,NULL,NULL,NULL,NULL,NULL,32500,2350,30150,33.2),
    (7,N'22',N'G0',N'Steel floor',N'HLXU',340700,340799,5900,2352,2395,NULL,NULL,NULL,NULL,NULL,2340,2292,NULL,NULL,NULL,NULL,NULL,32500,2570,29930,33.2),
    (15,N'22',N'G1',N'Steel floor',N'HLXU',340700,340799,5900,2352,2395,NULL,NULL,NULL,NULL,NULL,2340,2292,NULL,NULL,NULL,NULL,NULL,32500,2570,29930,33.2),
    (54,N'22',N'U1',N'Wooden floor',N'HLXU',360000,361999,5895,2350,NULL,2376,2346,NULL,5338,2230,NULL,NULL,2338,1900,2232,2280,2230,32500,2500,30000,32.7),
    (52,N'22',N'U1',N'Wooden floor',N'HLXU',362000,362999,5895,2350,NULL,2380,2340,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,32500,2450,30050,32.5),
    (53,N'22',N'U1',N'Wooden floor',N'HLXU',362500,362999,5895,2350,NULL,2380,2340,NULL,5338,2230,NULL,NULL,2338,1900,2230,2280,2231,32500,2450,30050,32.5),
    (45,N'22',N'U6',N'Wooden floor',N'HLXU',365000,365949,5886,2342,NULL,2388,2313,NULL,5590,2208,NULL,NULL,2336,1896,2208,2276,2220,30480,2700,27780,33.0),
    (46,N'22',N'U6',N'Wooden floor',N'HLXU',365450,365649,5886,2342,NULL,2388,2313,NULL,5590,2208,NULL,NULL,2336,1896,2208,2276,2220,30480,2700,27780,33.0),
    (44,N'22',N'U6',N'Wooden floor',N'HLXU',365650,365949,5895,2350,NULL,2384,2309,NULL,5596,2208,NULL,NULL,2340,1850,2208,2277,2220,32500,2850,29650,32.1),
    (64,N'22',N'P3',N'Flat/Platform',N'HLXU',368000,368699,NULL,NULL,2233,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,40000,2940,37060,NULL),
    (65,N'22',N'P3',N'Flat/Platform',N'HLXU',368700,369199,NULL,NULL,2233,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,45000,2900,42100,NULL),
    (70,N'22',N'R1',NULL,N'HLXU',371450,371949,5450,2284,2267,NULL,NULL,2154,NULL,NULL,2290,2264,NULL,NULL,NULL,NULL,NULL,30480,2905,27575,28.2),
    (76,N'22',N'R9',NULL,N'HLXU',371450,371949,5450,2284,2267,NULL,NULL,2154,NULL,NULL,2290,2264,NULL,NULL,NULL,NULL,NULL,30480,2905,27575,28.2),
    (72,N'22',N'R1',NULL,N'HLXU',372800,373799,5446,2293,2255,NULL,NULL,2155,NULL,NULL,2290,2264,NULL,NULL,NULL,NULL,NULL,30480,2920,27560,28.2),
    (78,N'22',N'R9',NULL,N'HLXU',372800,373799,5446,2293,2255,NULL,NULL,2155,NULL,NULL,2290,2264,NULL,NULL,NULL,NULL,NULL,30480,2920,27560,28.2),
    (71,N'22',N'R1',NULL,N'HLXU',374050,375049,5450,2280,2259,NULL,NULL,2159,NULL,NULL,2290,2264,NULL,NULL,NULL,NULL,NULL,32000,2860,29140,28.1),
    (77,N'22',N'R9',NULL,N'HLXU',374050,375049,5450,2280,2259,NULL,NULL,2159,NULL,NULL,2290,2264,NULL,NULL,NULL,NULL,NULL,32000,2860,29140,28.1),
    (73,N'22',N'R1',NULL,N'HLXU',375350,375849,5454,2290,2263,NULL,NULL,2163,NULL,NULL,2290,2252,NULL,NULL,NULL,NULL,NULL,31400,2770,28630,28.2),
    (79,N'22',N'R9',NULL,N'HLXU',375350,375849,5454,2290,2263,NULL,NULL,2163,NULL,NULL,2290,2252,NULL,NULL,NULL,NULL,NULL,31400,2770,28630,28.2),
    (21,N'42',N'G0',N'Wooden floor',N'HLXU',439700,447168,12029,2350,2392,NULL,NULL,NULL,NULL,NULL,2340,2292,NULL,NULL,NULL,NULL,NULL,30480,3780,26700,67.7),
    (28,N'42',N'G1',N'Wooden floor',N'HLXU',439700,447168,12029,2350,2392,NULL,NULL,NULL,NULL,NULL,2340,2292,NULL,NULL,NULL,NULL,NULL,30480,3780,26700,67.7),
    (22,N'42',N'G0',N'Wooden floor',N'HLXU',448000,449999,12029,2350,2392,NULL,NULL,NULL,NULL,NULL,2340,2292,NULL,NULL,NULL,NULL,NULL,30480,3780,26700,67.7),
    (29,N'42',N'G1',N'Wooden floor',N'HLXU',448000,449999,12029,2350,2392,NULL,NULL,NULL,NULL,NULL,2340,2292,NULL,NULL,NULL,NULL,NULL,30480,3780,26700,67.7),
    (57,N'42',N'U1',N'Wooden floor',N'HLXU',461670,461819,12030,2350,NULL,2377,2347,NULL,11573,2210,NULL,NULL,2338,1902,2232,2280,2131,30480,3850,26630,66.4),
    (47,N'42',N'U6',N'Wooden floor',N'HLXU',465000,465649,12020,2342,NULL,2388,2313,NULL,11727,2208,NULL,NULL,2336,1896,2208,2276,2220,30480,4700,25780,67.2),
    (48,N'42',N'U6',N'Wooden floor',N'HLXU',467950,467999,12020,2345,NULL,2380,2300,NULL,11727,2208,NULL,NULL,2334,1882,2208,2290,2125,30480,4700,25780,65.3),
    (23,N'42',N'G0',N'Wooden floor',N'HLXU',502000,507749,12029,2350,2392,NULL,NULL,NULL,NULL,NULL,2340,2292,NULL,NULL,NULL,NULL,NULL,30480,3780,26700,67.7),
    (30,N'42',N'G1',N'Wooden floor',N'HLXU',502000,507749,12029,2350,2392,NULL,NULL,NULL,NULL,NULL,2340,2292,NULL,NULL,NULL,NULL,NULL,30480,3780,26700,67.7),
    (18,N'42',N'G0',N'Wooden floor',N'HLXU',536500,541499,12032,2352,2395,NULL,NULL,NULL,NULL,NULL,2340,2292,NULL,NULL,NULL,NULL,NULL,32500,3700,28800,67.7),
    (25,N'42',N'G1',N'Wooden floor',N'HLXU',536500,541499,12032,2352,2395,NULL,NULL,NULL,NULL,NULL,2340,2292,NULL,NULL,NULL,NULL,NULL,32500,3700,28800,67.7),
    (58,N'42',N'U1',N'Wooden floor',N'HLXU',560300,566699,12029,2350,NULL,2380,2346,NULL,11552,2230,NULL,NULL,2340,1900,2192,2683,2649,32500,4050,28450,66.5),
    (37,N'45',N'G0',N'Steel floor',N'HLXU',655900,655999,12032,2352,2700,NULL,NULL,NULL,NULL,NULL,2340,2597,NULL,NULL,NULL,NULL,NULL,32500,4300,28200,76.4),
    (50,N'45',N'U6',N'Wooden floor',N'HLXU',665000,666049,12020,2342,NULL,2693,2618,NULL,11724,2208,NULL,NULL,2336,1896,2208,2597,2525,30480,4900,25580,75.8),
    (49,N'45',N'U6',N'Wooden floor',N'HLXU',666050,666349,12032,2352,NULL,2698,2620,NULL,11724,2212,NULL,NULL,2340,1808,2212,2581,2523,32500,5200,27300,76.3),
    (66,N'45',N'P3',N'Flat/Platform',N'HLXU',669800,669899,NULL,NULL,2248,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,50000,5950,44050,NULL),
    (82,N'45',N'R1',NULL,N'HLXU',676100,676599,11578,2280,2525,NULL,NULL,2425,NULL,NULL,2276,2535,NULL,NULL,NULL,NULL,NULL,34000,4300,29700,66.7),
    (89,N'45',N'R9',NULL,N'HLXU',676100,676599,11578,2280,2525,NULL,NULL,2425,NULL,NULL,2276,2535,NULL,NULL,NULL,NULL,NULL,34000,4300,29700,66.7),
    (87,N'45',N'R1',N'Non-Foodstuff',N'HLXU',777000,777484,11580,2290,2543,NULL,NULL,2294,NULL,NULL,2294,2550,NULL,NULL,NULL,NULL,NULL,34000,4550,29450,67.4),
    (94,N'45',N'R9',N'Non-Foodstuff',N'HLXU',777000,777484,11580,2290,2543,NULL,NULL,2294,NULL,NULL,2294,2550,NULL,NULL,NULL,NULL,NULL,34000,4550,29450,67.4),
    (88,N'45',N'R1',N'Non-Foodstuff',N'HLXU',777500,777699,11590,2294,2594,NULL,NULL,2290,NULL,NULL,2290,2569,NULL,NULL,NULL,NULL,NULL,34000,4660,29340,67.9),
    (95,N'45',N'R9',N'Non-Foodstuff',N'HLXU',777500,777699,11590,2294,2594,NULL,NULL,2290,NULL,NULL,2290,2569,NULL,NULL,NULL,NULL,NULL,34000,4660,29340,67.9),
    (59,N'42',N'U1',N'Steel floor',N'HLBU',800000,800999,12029,2350,NULL,2380,2344,NULL,11552,2232,NULL,NULL,2352,1902,2232,2280,2131,32500,4000,28500,66.3),
    (55,N'22',N'U1',N'Steel floor',N'HLBU',801000,801599,5895,2352,NULL,2378,2344,NULL,5418,2232,NULL,NULL,2340,1900,2210,2292,2131,32500,2300,30200,32.5),
    (60,N'42',N'U1',N'Steel floor',N'HLBU',801600,802099,12029,2350,NULL,2380,2344,NULL,11552,2232,NULL,NULL,2352,1902,2232,2280,2131,32500,4000,28500,66.3),
    (61,N'45',N'U1',N'Steel floor',N'HLBU',802100,802599,12029,2352,NULL,2683,2649,NULL,11552,2192,NULL,NULL,2352,1900,2192,2683,2649,32500,4250,28250,74.9),
    (69,N'45',N'P3',N'Flat/Platform',N'HLBU',802700,802999,NULL,NULL,2264,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,60000,5800,54200,NULL),
    (51,N'45',N'U6',N'Steel floor',N'HLBU',803000,803299,12029,2350,NULL,2693,2612,NULL,11730,2214,NULL,NULL,2340,1850,2214,2680,2582,32500,5000,27500,73.9),
    (56,N'22',N'U1',N'Steel floor',N'HLBU',803300,803619,5895,2352,NULL,2378,2344,NULL,5418,2232,NULL,NULL,2340,1900,2230,2282,2163,32500,2300,30200,32.5),
    (36,N'45',N'G0',N'Wooden floor',N'HLXU',823850,824749,12032,2342,2700,NULL,NULL,NULL,NULL,NULL,2340,2597,NULL,NULL,NULL,NULL,NULL,32500,3900,28600,76.3),
    (68,N'45',N'P3',N'Flat/Platform',N'HLXU',868000,868499,NULL,NULL,2258,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,55000,5850,49150,NULL),
    (67,N'45',N'P3',N'Flat/Platform',N'HLXU',869000,869599,NULL,NULL,2264,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,55000,5900,49100,NULL),
    (84,N'45',N'R1',NULL,N'HLXU',870000,872099,11580,2290,2540,NULL,NULL,2420,NULL,NULL,2290,2569,NULL,NULL,NULL,NULL,NULL,34000,4450,29550,67.3),
    (91,N'45',N'R9',NULL,N'HLXU',870000,872099,11580,2290,2540,NULL,NULL,2420,NULL,NULL,2290,2569,NULL,NULL,NULL,NULL,NULL,34000,4450,29550,67.3),
    (83,N'45',N'R1',NULL,N'HLXU',877530,880529,11599,2290,2545,NULL,NULL,2425,NULL,NULL,2290,2557,NULL,NULL,NULL,NULL,NULL,34000,4420,29580,67.6),
    (90,N'45',N'R9',NULL,N'HLXU',877530,880529,11599,2290,2545,NULL,NULL,2425,NULL,NULL,2290,2557,NULL,NULL,NULL,NULL,NULL,34000,4420,29580,67.6),
    (41,N'L5',N'G0',N'Wooden floor',N'HLXU',900000,900199,13556,2352,2700,NULL,NULL,NULL,NULL,NULL,2340,2597,NULL,NULL,NULL,NULL,NULL,32500,5050,27450,86.0),
    (43,N'L5',N'G1',N'Wooden floor',N'HLXU',900000,900199,13556,2352,2700,NULL,NULL,NULL,NULL,NULL,2340,2597,NULL,NULL,NULL,NULL,NULL,32500,5050,27450,86.0),
    (40,N'L5',N'G0',N'Wooden floor',N'HLXU',901100,901599,13556,2352,2700,NULL,NULL,NULL,NULL,NULL,2340,2597,NULL,NULL,NULL,NULL,NULL,32500,4700,27800,86.0),
    (42,N'L5',N'G1',N'Wooden floor',N'HLXU',901100,901599,13556,2352,2700,NULL,NULL,NULL,NULL,NULL,2340,2597,NULL,NULL,NULL,NULL,NULL,32500,4700,27800,86.0),
    (85,N'45',N'R1',NULL,N'HLBU',904000,904999,11590,2290,2540,NULL,NULL,2420,NULL,NULL,2290,2569,NULL,NULL,NULL,NULL,NULL,34000,4570,29430,67.4),
    (92,N'45',N'R9',NULL,N'HLBU',904000,904999,11590,2290,2540,NULL,NULL,2420,NULL,NULL,2290,2569,NULL,NULL,NULL,NULL,NULL,34000,4570,29430,67.4),
    (86,N'45',N'R1',NULL,N'LNXU',965000,965999,11590,2290,2540,NULL,NULL,2420,NULL,NULL,2290,2569,NULL,NULL,NULL,NULL,NULL,34000,4800,29200,67.4),
    (93,N'45',N'R9',NULL,N'LNXU',965000,965999,11590,2290,2540,NULL,NULL,2420,NULL,NULL,2290,2569,NULL,NULL,NULL,NULL,NULL,34000,4800,29200,67.4);
