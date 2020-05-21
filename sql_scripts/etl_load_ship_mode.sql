USE FreightShipping;

SELECT [Vehicle Key],
       [Vehicle Type],
       [Vehicle Name],
       [Vehicle Capacity],
       CASE
           WHEN [Vehicle Capacity] <= 1000 THEN N'Small feeder'
           WHEN [Vehicle Capacity] <= 2000 THEN N'Feeder'
           WHEN [Vehicle Capacity] < 3000 THEN N'Feedermax'
           WHEN [Vehicle Capacity] < 5100 THEN N'Panamax'
           WHEN [Vehicle Capacity] < 10000 THEN N'Post-Panamax'
           WHEN [Vehicle Capacity] < 14500 THEN N'New Panamax'
           ELSE N'Ultra Large Container Vessel'
       END [Ship Size Category],
       [Vehicle Speed (km/h)],
       CAST(ROUND([Vehicle Speed (km/h)] * 0.6, 3) AS decimal(18, 3)) [Vehicle Speed (mile/h)],
       [Vehicle Builder],
       [Vehicle Fuel Usage per Day] * 400                             [Fuel cost per day]
FROM Vehicle V
ORDER BY [Vehicle Key]