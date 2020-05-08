USE FreightShipping;

SELECT [Vehicle Key],
       [Vehicle Name],
       [Vehicle Capacity],
       [Vehicle Speed (km/h)],
       [Vehicle Speed (km/h)] * 0.6       [Vehicle Speed (mile/h)],
       [Vehicle Builder],
       [Vehicle Fuel Usage per Day] * 400 [Fuel cost per day]
FROM Vehicle V
