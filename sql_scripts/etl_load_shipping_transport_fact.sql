USE FreightShipping;

SELECT StartLS.[Origin Port Scheduled Departure Date]  [Scheduled Voyage Departure Date Key],
       EndLS.[Destination Port Scheduled Arrival Date] [Scheduled Voyage Arrival Date Key],
       LS1.[Origin Port Scheduled Departure Date]      [Scheduled Shipment Departure Date Key],
       LS2.[Destination Port Scheduled Arrival Date]   [Scheduled Shipment Arrival Date Key],
       StartLS.[Origin Port Actual Departure Date]     [Actual Voyage Departure Date Key],
       EndLS.[Destination Port Actual Arrival Date]    [Actual Voyage Arrival Date Key],
       LS1.[Origin Port Actual Departure Date]         [Actual Shipment Departure Date Key],
       LS2.[Destination Port Actual Arrival Date]      [Actual Shipment Arrival Date Key],
       StartLeg.[Origin Port Key]                      [Voyage Origin Port Key],
       EndLeg.[Destination Port Key]                   [Voyage Destination Port Key],
       L1.[Origin Port Key]                            [Shipment Origin Port Key],
       L2.[Destination Port Key]                       [Shipment Destination Port Key],
       S.[Vehicle Key]                                 [Ship Mode Key],
       [Container Key],
       [Commodity Key],
       [Consignor Key],
       [Foreign Transporter Key],
       [Foreign Consolidator Key],
       [Courier Key]                                   [Shipper Key],
       [Domestic Consolidator Key],
       [Domestic Transporter Key],
       [Consignee Key],
       [Bill-of-Lading Number]                         [Bill-of-Lading Number (DD)],
       [Shipment Fees]                                 [Voyage Fee],
       [Expected Tariffs],
       [Actual Tariffs],
       SUM(L.[Leg Miles])                              [Shipment Miles]
FROM Shipment S
         JOIN Vehicle Ve ON S.[Vehicle Key] = Ve.[Vehicle Key]
         JOIN BillOfLading BOL ON S.[Bill-of-Lading Key] = BOL.[Bill-of-Lading Key]
         JOIN VoyageSchedule VS ON S.[Voyage Schedule Key] = VS.[Voyage Schedule Key]
         JOIN Voyage Vo ON VS.[Voyage Key] = Vo.[Voyage Key]
         JOIN LegScheduleBridge LSB1 ON VS.[Leg Schedule Bridge Key] = LSB1.[Leg Schedule Bridge Key]
         JOIN LegScheduleBridge LSB2 ON VS.[Leg Schedule Bridge Key] = LSB2.[Leg Schedule Bridge Key]
         JOIN LegScheduleBridge LSB3 ON VS.[Leg Schedule Bridge Key] = LSB3.[Leg Schedule Bridge Key]
         JOIN LegScheduleBridge LSB4 ON VS.[Leg Schedule Bridge Key] = LSB4.[Leg Schedule Bridge Key]
         JOIN Leg StartLeg ON Vo.[Origin Port Key] = StartLeg.[Origin Port Key]
         JOIN LegSchedule StartLS ON StartLeg.[Leg Key] = StartLS.[Leg Key] AND StartLS.[Leg Schedule Key] = LSB1.[Leg Schedule Key]
         JOIN Leg EndLeg ON Vo.[Destination Port Key] = EndLeg.[Destination Port Key]
         JOIN LegSchedule EndLS ON EndLeg.[Leg Key] = EndLS.[Leg Key] AND EndLS.[Leg Key] = LSB2.[Leg Schedule Key]
         JOIN Leg L1 ON BOL.[Port of Loading Key] = L1.[Origin Port Key]
         JOIN LegBridge LB1 ON L1.[Leg Key] = LB1.[Leg Key]
         JOIN LegSchedule LS1 ON L1.[Leg Key] = LS1.[Leg Key] AND LS1.[Leg Schedule Key] = LSB3.[Leg Schedule Key]
         JOIN Leg L2 ON BOL.[Port of Discharge Key] = L2.[Destination Port Key]
         JOIN LegBridge LB2 ON L2.[Leg Key] = LB2.[Leg Key]
         JOIN LegSchedule LS2 ON L2.[Leg Key] = LS2.[Leg Key] AND LS2.[Leg Schedule Key] = LSB4.[Leg Schedule Key]
         JOIN LegBridge LB ON Vo.[Leg Bridge Key] = LB.[Leg Bridge Key]
         JOIN Leg L ON LB.[Leg Key] = L.[Leg Key] AND LB.[Order] >= LB1.[Order] AND LB.[Order] <= LB2.[Order]

GROUP BY LB.[Leg Bridge Key],
         StartLS.[Origin Port Scheduled Departure Date],
         EndLS.[Destination Port Scheduled Arrival Date],
         LS1.[Origin Port Scheduled Departure Date],
         LS2.[Destination Port Scheduled Arrival Date],
         StartLS.[Origin Port Actual Departure Date],
         EndLS.[Destination Port Actual Arrival Date],
         LS1.[Origin Port Actual Departure Date],
         LS2.[Destination Port Actual Arrival Date],
         StartLeg.[Origin Port Key],
         EndLeg.[Destination Port Key],
         L1.[Origin Port Key],
         L2.[Destination Port Key],
         S.[Vehicle Key],
         [Container Key],
         [Commodity Key],
         [Consignor Key],
         [Foreign Transporter Key],
         [Foreign Consolidator Key],
         [Courier Key],
         [Domestic Consolidator Key],
         [Domestic Transporter Key],
         [Consignee Key],
         [Bill-of-Lading Number],
         [Shipment Fees],
         [Expected Tariffs],
         [Actual Tariffs]

