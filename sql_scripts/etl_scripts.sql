USE FreightShipping;


SELECT CONCAT(C.[Owner Code], [Serial Number], [Check Digit]) [Container Number],
       [Container Size (Volume)],
       [Container Type],
       [Tare Weight (kg)]                                     [Container Tare Weight (kg)],
       [Inside Length (mm)]                                   [Container Inside Length (mm)],
       [Inside Width (mm)]                                    [Container Inside Width (mm)],
       [Inside Height (mm)]                                   [Container Inside Height (mm)],
       [Inside Length (mm)] * 0.00328084                      [Container Inside Length (ft)],
       [Inside Width (mm)] * 0.00328084                       [Container Inside Width (ft)],
       [Inside Height (mm)] * 0.00328084                      [Container Inside Height (ft)],
       [Container Outside Length (mm)],
       [Container Outside Width (mm)],
       [Container Outside Height (mm)],
       [Container Outside Length (ft)],
       [Container Outside Width (ft)],
       [Container Outside Height (ft)],
       [Capacity (cbm)]                                       [Container Capacity],
       [Container Electricity Indicator],
       [Container Refrigeration Indicator],
       [Container Thermal Indicator],
       [Container Dangerous Indicator]
FROM Container C
         JOIN ContainerModel CM
              ON C.[ISO Size Code] = CM.[ISO Size Code]
                  AND C.[ISO Type Code] = CM.[ISO Type Code]
                  AND C.[Serial Number] >= CM.[Serial Number Range Start]
                  AND C.[Serial Number] <= CM.[Serial Number Range End]

SELECT [HS Code],
       [Description]  [Commodity Description],
       HSS.name       [Category Description],
       HS.description [Subcategory Description],
       [Package Size (m^3)],
       [Package Weight (kg)]
FROM Commodity C
         JOIN HarmonizedSystem HS on C.[HS Code] = HS.hscode
         JOIN HSSection HSS on HS.section = HSS.section

SELECT [Name],
       [Phone]                                                                   [Telephone],
       [Fax],
       [E-mail]                                                                  [Email],
       CONCAT([Address Line 1], [Address Line 2], [City], [Country], [ZIP Code]) [Address],
       [City],
       [Country],
       [ZIP code]
FROM BusinessEntity BE
         JOIN Address A ON BE.[Address Key] = A.[Address Key]


SELECT [Port Name],
       [Port Type],
       [Country]                                                                 [Port Country],
       [City]                                                                    [Port City],
       CONCAT([Address Line 1], [Address Line 2], [City], [Country], [ZIP Code]) [Address],
       P.Phone                                                                   [Port Telephone]
FROM Port P
         JOIN Address A on P.[Address Key] = A.[Address Key]


SELECT [Vehicle Key],
       [Vehicle Name],
       [Vehicle Capacity],
       [Vehicle Speed (km/h)],
       [Vehicle Speed (km/h)] * 0.6       [Vehicle Speed (mile/h)],
       [Vehicle Builder],
       [Vehicle Fuel Usage per Day] * 400 [Fuel cost per day]
FROM Vehicle V
