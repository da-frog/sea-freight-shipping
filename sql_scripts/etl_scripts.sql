USE FreightShipping;


SELECT CONCAT(C.[Owner Code], [Serial Number], [Check Digit]) [Container Number],
       [Type Designation]                                     [Container Type],
       [Tare Weight (kg)]                                     [Container Tare Weight (kg)],
       [Inside Length (mm)]                                   [Container Inside Length (mm)],
       [Inside Width (mm)]                                    [Container Inside Width (mm)],
       [Inside Height (mm)]                                   [Container Inside Height (mm)],
       [Inside Length (mm)] * 0.00328084                      [Container Inside Length (ft)],
       [Inside Width (mm)] * 0.00328084                       [Container Inside Width (ft)],
       [Inside Height (mm)] * 0.00328084                      [Container Inside Height (ft)],
       [Container length (mm)]                                [Container Outside Length (mm)],
       IIF([Container width (mm) Range Start] = [Container width (mm) Range End], [Container width (mm) Range End],
           NULL)                                              [Container Outside Width (mm)],
       IIF([Container height (mm) Range Start] = [Container height (mm) Range End], [Container height (mm) Range End],
           NULL)                                              [Container Outside Height (mm)],
       [Container length (mm)]                                [Container Outside Length (ft)],
       IIF([Container width (mm) Range Start] = [Container width (mm) Range End], [Container width (mm) Range End],
           NULL) * 0.00328084                                 [Container Outside Width (ft)],
       IIF([Container height (mm) Range Start] = [Container height (mm) Range End], [Container height (mm) Range End],
           NULL) * 0.00328084                                 [Container Outside Height (ft)],
       [Capacity (m^3)]                                       [Container Capacity],
       [Container Electricity Indicator],
       [Container Refrigeration Indicator],
       [Container Danger Indicator]
FROM Container C
         JOIN ContainerModel CM
              ON C.[ISO Size Code] = CM.[ISO Size Code]
                  AND C.[ISO Type Code] = CM.[ISO Type Code]
                  AND C.[Serial Number] >= CM.[Serial Number Range Start]
                  AND C.[Serial Number] <= CM.[Serial Number Range End]
         JOIN ISOSizeCode1 ISC1
              ON SUBSTRING(C.[ISO Size Code], 1, 1) = ISC1.[Code character]
         JOIN ISOSizeCode2 ISC2
              ON SUBSTRING(C.[ISO Size Code], 2, 1) = ISC2.[Code character]
         JOIN ISOTypeCode ITC
              ON C.[ISO Type Code] = ITC.[Detailed Type Code]


SELECT [HS Code],
       C.[Description]  [Commodity Description],
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
