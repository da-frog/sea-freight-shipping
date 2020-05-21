USE FreightShipping;

SELECT [Vehicle Key],
       [Vehicle Type],
       [Vehicle Name],
       [Vehicle Capacity],
       CASE
           WHEN [Vehicle Capacity] <= 1000 THEN N'Small feeder'
           WHEN [Vehicle Capacity] <= 2000 THEN N'Feeder'
           WHEN [Vehicle Capacity] <= 3000 THEN N'Feedermax'
           WHEN [Vehicle Capacity] <= 5100 THEN N'Panamax'
           WHEN [Vehicle Capacity] <= 10000 THEN N'Post-Panamax'
           WHEN [Vehicle Capacity] <= 14500 THEN N'New Panamax'
           ELSE N'Ultra Large Container Vessel'
       END [Ship Size Category],
       [Vehicle Speed (km/h)],
       CAST(ROUND([Vehicle Speed (km/h)] * 0.6, 3) AS decimal(18, 3)) [Vehicle Speed (mile/h)],
       CAST(ROUND([Vehicle Speed (km/h)] * 0.54, 3) AS decimal(18, 1)) [Vehicle Speed (knots)],
       CASE
           WHEN [Vehicle Speed (km/h)] <= 22.2 THEN N'0.0–11.9'
           WHEN [Vehicle Speed (km/h)] <= 27.8 THEN N'12.0–14.9'
           WHEN [Vehicle Speed (km/h)] <= 33.3 THEN N'15.0–17.9'
           WHEN [Vehicle Speed (km/h)] <= 37.0 THEN N'18.0–19.9'
           WHEN [Vehicle Speed (km/h)] <= 46.3 THEN N'20.0–24.9'
           ELSE N'25.0+'
       END [Vehicle Speed Range (knots)],
       [Vehicle Builder],
       CAST([Vehicle Fuel Usage per Day] * 400 AS decimal(18,2))                             [Fuel cost per day],
       CASE
           WHEN [Vehicle Fuel Usage per Day] <= 50  THEN     N'0-19999'
           WHEN [Vehicle Fuel Usage per Day] <= 75  THEN N'20000–29999'
           WHEN [Vehicle Fuel Usage per Day] <= 100 THEN N'30000–39999'
           WHEN [Vehicle Fuel Usage per Day] <= 125 THEN N'40000–49999'
           WHEN [Vehicle Fuel Usage per Day] <= 150 THEN N'50000–59999'
           WHEN [Vehicle Fuel Usage per Day] <= 175 THEN N'60000–69999'
           WHEN [Vehicle Fuel Usage per Day] <= 200 THEN N'70000–79999'
           WHEN [Vehicle Fuel Usage per Day] <= 225 THEN N'80000–89999'
           WHEN [Vehicle Fuel Usage per Day] <= 250 THEN N'90000–99999'
           ELSE N'100000+'
       END [Vehicle Fuel Usage per Day Range 1],
       CASE
           WHEN [Vehicle Fuel Usage per Day] <= 50  THEN     N'0-19999'
           WHEN [Vehicle Fuel Usage per Day] <= 150 THEN N'20000–59999'
           WHEN [Vehicle Fuel Usage per Day] <= 250 THEN N'60000–99999'
           ELSE N'100000+'
       END [Vehicle Fuel Usage per Day Range 2]
FROM Vehicle V
ORDER BY [Vehicle Key]