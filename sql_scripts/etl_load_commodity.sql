SELECT [Commodity Key],
       [HS Code],
       HS6.hscode      [HS Sub Heading],
       HS6.description [HS Sub Heading Description],
       HS4.hscode      [HS Heading],
       HS4.description [HS Heading Description],
       HS2.hscode      [HS Chapter],
       HS2.description [HS Chapter Description],
       HSS.section     [HS Section],
       HSS.name        [HS Section Name],
       C.[Description] [Commodity Description],
       [Package Size (m^3)],
       CASE
           WHEN [Package Size (m^3)] < 1 THEN N'0.000–0.999'
           WHEN [Package Size (m^3)] < 3 THEN N'1.000–2.999'
           WHEN [Package Size (m^3)] < 5 THEN N'3.000–4.999'
           ELSE N'5.000+'
       END [Package Size Range (m^3)],
       [Package Weight (kg)]
FROM FreightShipping.dbo.Commodity C
         JOIN FreightShippingETL.dbo.HSCode HS6 on SUBSTRING(C.[HS Code], 1, 6) = HS6.hscode -- Sub Heading
         JOIN FreightShippingETL.dbo.HSCode HS4 on SUBSTRING(C.[HS Code], 1, 4) = HS4.hscode -- Heading
         JOIN FreightShippingETL.dbo.HSCode HS2 on SUBSTRING(C.[HS Code], 1, 2) = HS2.hscode -- Chapter
         JOIN FreightShippingETL.dbo.HSSection HSS on HS6.section = HSS.section
ORDER BY [Commodity Key];
