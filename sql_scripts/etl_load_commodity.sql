SELECT [Commodity Key],
       [HS Code],
       HS6.hscode      [Sub Heading],
       HS6.description [Sub Heading Description],
       HS4.hscode      [Heading],
       HS4.description [Heading Description],
       HS2.hscode      [Chapter],
       HS2.description [Chapter Description],
       HSS.section     [Section],
       HSS.name        [Section Name],
       C.[Description] [Commodity Description],
       [Package Size (m^3)],
       [Package Weight (kg)]
FROM FreightShipping.dbo.Commodity C
         JOIN FreightShippingETL.dbo.HSCode HS6 on SUBSTRING(C.[HS Code], 1, 6) = HS6.hscode -- Sub Heading
         JOIN FreightShippingETL.dbo.HSCode HS4 on HS6.parent = HS4.hscode -- Heading
         JOIN FreightShippingETL.dbo.HSCode HS2 on HS4.parent = HS2.hscode -- Chapter
         JOIN FreightShippingETL.dbo.HSSection HSS on HS6.section = HSS.section
ORDER BY [Commodity Key];
