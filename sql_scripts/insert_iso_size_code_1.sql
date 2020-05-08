IF OBJECT_ID('dbo.ISOSizeCode1', 'U') IS NOT NULL
    TRUNCATE TABLE ISOSizeCode1;
GO
INSERT INTO ISOSizeCode1 VALUES
    (N'2991',N'10',NULL,N'1'),
    (N'6068',N'20',NULL,N'2'),
    (N'9125',N'30',NULL,N'3'),
    (N'12192',N'40',NULL,N'4'),
    (NULL,NULL,NULL,N'5'),
    (NULL,NULL,NULL,N'6'),
    (NULL,NULL,NULL,N'7'),
    (NULL,NULL,NULL,N'8'),
    (NULL,NULL,NULL,N'9'),
    (N'7150',NULL,NULL,N'A'),
    (N'7315',N'24',NULL,N'B'),
    (N'7430',N'24',N'6',N'C'),
    (N'7450',NULL,NULL,N'D'),
    (N'7820',NULL,NULL,N'E'),
    (N'8100',NULL,NULL,N'F'),
    (N'12500',N'41',NULL,N'G'),
    (N'13106',N'43',NULL,N'H'),
    (N'13600',NULL,NULL,N'K'),
    (N'13716',N'45',NULL,N'L'),
    (N'14630',N'48',NULL,N'M'),
    (N'14935',N'49',NULL,N'N'),
    (N'16154',NULL,NULL,N'P'),
    (NULL,NULL,NULL,N'R');
