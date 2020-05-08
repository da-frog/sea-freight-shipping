IF OBJECT_ID('dbo.ISOTypeCode', 'U') IS NOT NULL
    TRUNCATE TABLE ISOTypeCode;
GO
INSERT INTO ISOTypeCode VALUES
    (N'G',N'GP',N'G0',N'General purpose container wihout ventilation',NULL,N'Opening(s) at one end or both ends',NULL,NULL,NULL),
    (N'G',N'GP',N'G1',N'General purpose container wihout ventilation',NULL,N'Passive vents at upper part of cargo space',NULL,NULL,NULL),
    (N'G',N'GP',N'G2',N'General purpose container wihout ventilation',NULL,N'Opening(s) at one or both ends plus “full” opening(s) on one or both sides',NULL,NULL,NULL),
    (N'G',N'GP',N'G3',N'General purpose container wihout ventilation',NULL,N'Opening(s) at one or both ends plus “partial” opening(s) on one or both sides',NULL,NULL,NULL),
    (N'G',N'GP',N'G4',N'General purpose container wihout ventilation',NULL,N'(Unassigned)',NULL,NULL,NULL),
    (N'G',N'GP',N'G5',N'General purpose container wihout ventilation',NULL,N'(Unassigned)',NULL,NULL,NULL),
    (N'G',N'GP',N'G6',N'General purpose container wihout ventilation',NULL,N'(Unassigned)',NULL,NULL,NULL),
    (N'G',N'GP',N'G7',N'General purpose container wihout ventilation',NULL,N'(Unassigned)',NULL,NULL,NULL),
    (N'G',N'GP',N'G8',N'General purpose container wihout ventilation',NULL,N'(Unassigned)',NULL,NULL,NULL),
    (N'G',N'GP',N'G9',N'General purpose container wihout ventilation',NULL,N'(Unassigned)',NULL,NULL,NULL),
    (N'V',N'VH',N'V0',N'General purpose container with ventilation',NULL,N'Nonmechanical system, vents at lower and upper parts of cargo space',NULL,NULL,NULL),
    (N'V',N'VH',N'V1',N'General purpose container with ventilation',NULL,N'(Unassigned)',NULL,NULL,NULL),
    (N'V',N'VH',N'V2',N'General purpose container with ventilation',NULL,N'Mechanical ventilation system, located internally',NULL,NULL,NULL),
    (N'V',N'VH',N'V3',N'General purpose container with ventilation',NULL,N'(Unassigned)',NULL,NULL,NULL),
    (N'V',N'VH',N'V4',N'General purpose container with ventilation',NULL,N'Mechanical ventilation system, located externally',NULL,NULL,NULL),
    (N'V',N'VH',N'V5',N'General purpose container with ventilation',NULL,N'(Unassigned)',NULL,NULL,NULL),
    (N'V',N'VH',N'V6',N'General purpose container with ventilation',NULL,N'(Unassigned)',NULL,NULL,NULL),
    (N'V',N'VH',N'V7',N'General purpose container with ventilation',NULL,N'(Unassigned)',NULL,NULL,NULL),
    (N'V',N'VH',N'V8',N'General purpose container with ventilation',NULL,N'(Unassigned)',NULL,NULL,NULL),
    (N'V',N'VH',N'V9',N'General purpose container with ventilation',NULL,N'(Unassigned)',NULL,NULL,NULL),
    (N'B',N'BU',N'B0',N'Dry bulk container',N'Nonpressurized, box type',N'Closed',NULL,NULL,N'Nonpressurized'),
    (N'B',N'BU',N'B1',N'Dry bulk container',N'Nonpressurized, box type',N'Airtight',NULL,NULL,N'Nonpressurized'),
    (N'B',N'BU',N'B2',N'Dry bulk container',N'Nonpressurized, box type',N'(Unassigned)',NULL,NULL,N'Nonpressurized'),
    (N'B',N'BK',N'B3',N'Dry bulk container',N'Pressurized',N'Horizontal discharge, test pressure 150 kPa 1)',NULL,NULL,N'Pressurized'),
    (N'B',N'BK',N'B4',N'Dry bulk container',N'Pressurized',N'Horizontal discharge, test pressure 265 kPa',NULL,NULL,N'Pressurized'),
    (N'B',N'BK',N'B5',N'Dry bulk container',N'Pressurized',N'Tipping discharge, test pressure 150 kPa',NULL,NULL,N'Pressurized'),
    (N'B',N'BK',N'B6',N'Dry bulk container',N'Pressurized',N'Tipping discharge, test pressure 265 kPa',NULL,NULL,N'Pressurized'),
    (N'B',N'BK',N'B7',N'Dry bulk container',N'Pressurized',N'(Unassigned)',NULL,NULL,N'Pressurized'),
    (N'B',N'BK',N'B8',N'Dry bulk container',N'Pressurized',N'(Unassigned)',NULL,NULL,N'Pressurized'),
    (N'B',N'BK',N'B9',N'Dry bulk container',N'Pressurized',N'(Unassigned)',NULL,NULL,N'Pressurized'),
    (N'S',N'SN',N'S0',N'Named cargo container',NULL,N'Livestock carrier',NULL,NULL,NULL),
    (N'S',N'SN',N'S1',N'Named cargo container',NULL,N'Automobile carrier',NULL,NULL,NULL),
    (N'S',N'SN',N'S2',N'Named cargo container',NULL,N'Live fish carrier',NULL,NULL,NULL),
    (N'S',N'SN',N'S3',N'Named cargo container',NULL,N'(Unassigned)',NULL,NULL,NULL),
    (N'S',N'SN',N'S4',N'Named cargo container',NULL,N'(Unassigned)',NULL,NULL,NULL),
    (N'S',N'SN',N'S5',N'Named cargo container',NULL,N'(Unassigned)',NULL,NULL,NULL),
    (N'S',N'SN',N'S6',N'Named cargo container',NULL,N'(Unassigned)',NULL,NULL,NULL),
    (N'S',N'SN',N'S7',N'Named cargo container',NULL,N'(Unassigned)',NULL,NULL,NULL),
    (N'S',N'SN',N'S8',N'Named cargo container',NULL,N'(Unassigned)',NULL,NULL,NULL),
    (N'S',N'SN',N'S9',N'Named cargo container',NULL,N'(Unassigned)',NULL,NULL,NULL),
    (N'R',N'RE',N'R0',N'Thermal container',N'Refrigerated',N'Mechanically refrigerated ',NULL,N'Refrigerated',NULL),
    (N'R',N'RT',N'R1',N'Thermal container',N'Refrigerated and heated ',N'Mechanically refrigerated and heated',NULL,N'Refrigerated and heated ',NULL),
    (N'R',N'RS',N'R2',N'Thermal container',N'Self-powered refrigerated/heated',N'Mechanically refrigerated ',N'Self-powered',N'Refrigerated',NULL),
    (N'R',N'RS',N'R3',N'Thermal container',N'Self-powered refrigerated/heated',N'Mechanically refrigerated and heated',N'Self-powered',N'Refrigerated and heated',NULL),
    (N'R',N'RS',N'R4',N'Thermal container',N'Self-powered refrigerated/heated',N'(Unassigned)',N'Self-powered',N'Refrigerated and/or heated',NULL),
    (N'R',N'RS',N'R5',N'Thermal container',N'Self-powered refrigerated/heated',N'(Unassigned)',N'Self-powered',N'Refrigerated and/or heated',NULL),
    (N'R',N'RS',N'R6',N'Thermal container',N'Self-powered refrigerated/heated',N'(Unassigned)',N'Self-powered',N'Refrigerated and/or heated',NULL),
    (N'R',N'RS',N'R7',N'Thermal container',N'Self-powered refrigerated/heated',N'(Unassigned)',N'Self-powered',N'Refrigerated and/or heated',NULL),
    (N'R',N'RS',N'R8',N'Thermal container',N'Self-powered refrigerated/heated',N'(Unassigned)',N'Self-powered',N'Refrigerated and/or heated',NULL),
    (N'R',N'RS',N'R9',N'Thermal container',N'Self-powered refrigerated/heated',N'(Unassigned)',N'Self-powered',N'Refrigerated and/or heated',NULL),
    (N'H',N'HR',N'H0',N'Thermal container',N'Refrigerated and/or heated with removable equipment',N'Refrigerated and/or heated, with removable equipment HO heated with removable located externally; heat transfer coefficient equipment K = 0,4 W/(m*mK)',NULL,N'Refrigerated and/or heated with removable equipment',NULL),
    (N'H',N'HR',N'H1',N'Thermal container',N'Refrigerated and/or heated with removable equipment',N'Refrigerated and/or heated with removable equipment HI located internally',NULL,N'Refrigerated and/or heated with removable equipment',NULL),
    (N'H',N'HR',N'H2',N'Thermal container',N'Refrigerated and/or heated with removable equipment',N'Refrigerated and/or heated with removable equipment located externally; heat transfer coefficient K = 0,7 W/(m*-K)',NULL,N'Refrigerated and/or heated with removable equipment',NULL),
    (N'H',N'HR',N'H3',N'Thermal container',N'Refrigerated and/or heated with removable equipment',N'(Unassigned)',NULL,N'Refrigerated and/or heated with removable equipment',NULL),
    (N'H',N'HR',N'H4',N'Thermal container',N'Refrigerated and/or heated with removable equipment',N'(Unassigned)',NULL,N'Refrigerated and/or heated with removable equipment',NULL),
    (N'H',N'HI',N'H5',N'Thermal container',N'Insulated',N'Insulated; heat transfer coefficient K = 0,4 W/(m*mK)',NULL,NULL,NULL),
    (N'H',N'HI',N'H6',N'Thermal container',N'Insulated',N'Insulated; heat transfer coefficient K = 0,7 W/(m*mK)',NULL,NULL,NULL),
    (N'H',N'HI',N'H7',N'Thermal container',N'Insulated',N'(Unassigned)',NULL,NULL,NULL),
    (N'H',N'HI',N'H8',N'Thermal container',N'Insulated',N'(Unassigned)',NULL,NULL,NULL),
    (N'H',N'HI',N'H9',N'Thermal container',N'Insulated',N'(Unassigned)',NULL,NULL,NULL),
    (N'U',N'UT',N'U0',N'Open-top container',NULL,N'Opening(s) at one or both ends',NULL,NULL,NULL),
    (N'U',N'UT',N'U1',N'Open-top container',NULL,N'Opening(s) at one or both ends, plus removable top member(s) in end frame(s)',NULL,NULL,NULL),
    (N'U',N'UT',N'U2',N'Open-top container',NULL,N'Opening(s) at one or both ends, plus removable top member(s) in end frame(s)',NULL,NULL,NULL),
    (N'U',N'UT',N'U3',N'Open-top container',NULL,N'Opening(s) at one or both ends, plus opening(s) on one or both sides',NULL,NULL,NULL),
    (N'U',N'UT',N'U4',N'Open-top container',NULL,N'Opening(s) at one or both ends, plus opening(s) on one or both sides plus removable top member(s) in end frame(s)',NULL,NULL,NULL),
    (N'U',N'UT',N'U5',N'Open-top container',NULL,N'Complete, fixed side and end walls (no doors)',NULL,NULL,NULL),
    (N'U',N'UT',N'U6',N'Open-top container',NULL,N'Complete, fixed side and end walls (no doors)',NULL,NULL,NULL),
    (N'U',N'UT',N'U7',N'Open-top container',NULL,N'(Unassigned)',NULL,NULL,NULL),
    (N'U',N'UT',N'U8',N'Open-top container',NULL,N'(Unassigned)',NULL,NULL,NULL),
    (N'U',N'UT',N'U9',N'Open-top container',NULL,N'(Unassigned)',NULL,NULL,NULL),
    (N'P',N'PL',N'P0',N'Platform (container)',N'Platform-based containers with incomplete superstructure',N'Platform (container)',NULL,NULL,NULL),
    (N'P',N'PF',N'P1',N'Platform (container)',N'Fixed',N'Two complete and fixed ends',NULL,NULL,NULL),
    (N'P',N'PF',N'P2',N'Platform (container)',N'Fixed',N'Fixed posts, either free-standing or with removable top member',NULL,NULL,NULL),
    (N'P',N'PC',N'P3',N'Platform (container)',N'Folding (collapsible)',N'Folding complete end structure',NULL,NULL,NULL),
    (N'P',N'PC',N'P4',N'Platform (container)',N'Folding (collapsible)',N'Folding posts, either free-standing or with removable top member',NULL,NULL,NULL),
    (N'P',N'PS',N'P5',N'Platform (container)',N'Platform-based containers with complete superstructure',N'Open top, open ends (skeletal)',NULL,NULL,NULL),
    (N'P',N'PS',N'P6',N'Platform (container)',N'Platform-based containers with complete superstructure',N'(Unassigned)',NULL,NULL,NULL),
    (N'P',N'PS',N'P7',N'Platform (container)',N'Platform-based containers with complete superstructure',N'(Unassigned)',NULL,NULL,NULL),
    (N'P',N'PS',N'P8',N'Platform (container)',N'Platform-based containers with complete superstructure',N'(Unassigned)',NULL,NULL,NULL),
    (N'P',N'PS',N'P9',N'Platform (container)',N'Platform-based containers with complete superstructure',N'(Unassigned)',NULL,NULL,NULL),
    (N'T',N'TN',N'T0',N'Tank container',N'For nondangerous liquids',N'Minimum pressure 45 kPA',NULL,NULL,N'Nondangerous liquids'),
    (N'T',N'TN',N'T1',N'Tank container',N'For nondangerous liquids',N'Minimum pressure 150 kPA',NULL,NULL,N'Nondangerous liquids'),
    (N'T',N'TN',N'T2',N'Tank container',N'For nondangerous liquids',N'Minimum pressure 265 kPA',NULL,NULL,N'Nondangerous liquids'),
    (N'T',N'TD',N'T3',N'Tank container',N'For dangerous liquids',N'Minimum pressure 150 kPA',NULL,NULL,N'Dangerous Liquids'),
    (N'T',N'TD',N'T4',N'Tank container',N'For dangerous liquids',N'Minimum pressure 265 kPA',NULL,NULL,N'Dangerous Liquids'),
    (N'T',N'TD',N'T5',N'Tank container',N'For dangerous liquids',N'Minimum pressure 400 kPA',NULL,NULL,N'Dangerous Liquids'),
    (N'T',N'TD',N'T6',N'Tank container',N'For dangerous liquids',N'Minimum pressure 600 kPA',NULL,NULL,N'Dangerous Liquids'),
    (N'T',N'TG',N'T7',N'Tank container',N'For gases',N'Minimum pressure 910 kPA',NULL,NULL,N'Contains Gases'),
    (N'T',N'TG',N'T8',N'Tank container',N'For gases',N'Minimum pressure 2 200 kPa',NULL,NULL,N'Contains Gases'),
    (N'T',N'TG',N'T9',N'Tank container',N'For gases',N'Minimum pressure (to be decided)',NULL,NULL,N'Contains Gases'),
    (N'A',N'AS',N'A0',N'Air/surface container',NULL,NULL,NULL,NULL,NULL);
