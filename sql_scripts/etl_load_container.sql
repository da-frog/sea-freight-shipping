USE FreightShipping;

SELECT [Container Key],
       CONCAT(C.[Owner Code], [Serial Number], [Check Digit])              [Container Number],
       [Type Designation]                                                  [Container Type],
       [Tare Weight (kg)]                                                  [Container Tare Weight (kg)],
       [Inside Length (mm)]                                                [Container Inside Length (mm)],
       [Inside Width (mm)]                                                 [Container Inside Width (mm)],
       [Inside Height (mm)]                                                [Container Inside Height (mm)],
       CAST(ROUND([Inside Length (mm)] * 0.00328084, 3) AS decimal(18, 3)) [Container Inside Length (ft)],
       CAST(ROUND([Inside Width (mm)] * 0.00328084, 3) AS decimal(18, 3))  [Container Inside Width (ft)],
       CAST(ROUND([Inside Height (mm)] * 0.00328084, 3) AS decimal(18, 3)) [Container Inside Height (ft)],
       [Container length (mm)]                                             [Container Outside Length (mm)],
       IIF([Container width (mm) Range Start] = [Container width (mm) Range End], [Container width (mm) Range End],
           NULL)                                                           [Container Outside Width (mm)],
       IIF([Container height (mm) Range Start] = [Container height (mm) Range End], [Container height (mm) Range End],
           NULL)                                                           [Container Outside Height (mm)],
       [Container length (mm)]                                             [Container Outside Length (ft)],
       CAST(ROUND(IIF([Container width (mm) Range Start] = [Container width (mm) Range End],
                      [Container width (mm) Range End],
                      NULL) * 0.00328084, 1) AS decimal(18, 1))            [Container Outside Width (ft)],
       CAST(ROUND(IIF([Container height (mm) Range Start] = [Container height (mm) Range End],
                      [Container height (mm) Range End],
                      NULL) * 0.00328084, 1) AS decimal(18, 1))            [Container Outside Height (ft)],
       [Capacity (m^3)]                                                    [Container Capacity],
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
ORDER BY [Container Key]
