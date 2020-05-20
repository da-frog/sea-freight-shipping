SELECT [Commodity Key],
       [HS Code],
       C.[Description]  [Commodity Description],
       HSS.name       [Category Description],
       HS.description [Subcategory Description],
       [Package Size (m^3)],
       [Package Weight (kg)]
FROM FreightShipping.dbo.Commodity C
         JOIN FreightShippingETL.dbo.HSCode HS on C.[HS Code] = HS.hscode
         JOIN FreightShippingETL.dbo.HSSection HSS on HS.section = HSS.section
ORDER BY [Commodity Key];
