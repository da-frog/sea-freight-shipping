USE FreightShipping;

SELECT [Commodity Key],
       [HS Code],
       C.[Description]  [Commodity Description],
--        HSS.name       [Category Description],
       HS.description [Subcategory Description],
       [Package Size (m^3)],
       [Package Weight (kg)]
FROM Commodity C
         JOIN HSCode HS on C.[HS Code] = HS.hscode
--          JOIN HSSection HSS on HS.section = HSS.section
