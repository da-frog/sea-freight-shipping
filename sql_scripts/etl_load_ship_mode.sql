USE FreightShipping;

SELECT [Vehicle Key],
       [Vehicle Type],
       [Vehicle Name],
       [Vehicle Capacity],
       [Vehicle Speed (km/h)],
       CAST(ROUND([Vehicle Speed (km/h)] * 0.6, 3) AS decimal(18, 3)) [Vehicle Speed (mile/h)],
       [Vehicle Builder],
       [Vehicle Fuel Usage per Day] * 400                             [Fuel cost per day]
FROM Vehicle V
