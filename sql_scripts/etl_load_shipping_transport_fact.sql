-- USE FreightShipping;

SELECT DDim1.[Date] [Scheduled Voyage Departure Date Key],
       DDim2.[Date] [Scheduled Voyage Arrival Date Key],
       DDim3.[Date] [Scheduled Shipment Departure Date Key],
       DDim4.[Date] [Scheduled Shipment Arrival Date Key],
       DDim5.[Date] [Actual Voyage Departure Date Key],
       DDim6.[Date] [Actual Voyage Arrival Date Key],
       DDim7.[Date] [Actual Shipment Departure Date Key],
       DDim8.[Date] [Actual Shipment Arrival Date Key],
                              [Voyage Origin Port Key],
                           [Voyage Destination Port Key],
       L1.[Origin Port Key]                             [Shipment Origin Port Key],
       L2.[Destination Port Key]                        [Shipment Destination Port Key],
       S.[Vehicle Key]                                  [Ship Mode Key],
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
FROM FreightShipping.dbo.Shipment S
         JOIN FreightShipping.dbo.Vehicle Ve ON S.[Vehicle Key] = Ve.[Vehicle Key]
         JOIN FreightShipping.dbo.BillOfLading BOL ON S.[Bill-of-Lading Key] = BOL.[Bill-of-Lading Key]
         JOIN FreightShipping.dbo.VoyageSchedule VS ON S.[Voyage Schedule Key] = VS.[Voyage Schedule Key]
         JOIN FreightShipping.dbo.Voyage Vo ON VS.[Voyage Key] = Vo.[Voyage Key]
         JOIN FreightShipping.dbo.LegScheduleBridge LSB1 ON VS.[Leg Schedule Bridge Key] = LSB1.[Leg Schedule Bridge Key]
         JOIN FreightShipping.dbo.LegScheduleBridge LSB2 ON VS.[Leg Schedule Bridge Key] = LSB2.[Leg Schedule Bridge Key]
         JOIN FreightShipping.dbo.LegScheduleBridge LSB3 ON VS.[Leg Schedule Bridge Key] = LSB3.[Leg Schedule Bridge Key]
         JOIN FreightShipping.dbo.LegScheduleBridge LSB4 ON VS.[Leg Schedule Bridge Key] = LSB4.[Leg Schedule Bridge Key]
         JOIN FreightShipping.dbo.Leg StartLeg ON Vo.[Origin Port Key] = StartLeg.[Origin Port Key]
         JOIN FreightShipping.dbo.LegSchedule StartLS ON StartLeg.[Leg Key] = StartLS.[Leg Key] AND StartLS.[Leg Schedule Key] = LSB1.[Leg Schedule Key]
         JOIN FreightShipping.dbo.Leg EndLeg ON Vo.[Destination Port Key] = EndLeg.[Destination Port Key]
         JOIN FreightShipping.dbo.LegSchedule EndLS ON EndLeg.[Leg Key] = EndLS.[Leg Key] AND EndLS.[Leg Key] = LSB2.[Leg Schedule Key]
         JOIN FreightShipping.dbo.Leg L1 ON BOL.[Port of Loading Key] = L1.[Origin Port Key]
         JOIN FreightShipping.dbo.LegBridge LB1 ON L1.[Leg Key] = LB1.[Leg Key]
         JOIN FreightShipping.dbo.LegSchedule LS1 ON L1.[Leg Key] = LS1.[Leg Key] AND LS1.[Leg Schedule Key] = LSB3.[Leg Schedule Key]
         JOIN FreightShipping.dbo.Leg L2 ON BOL.[Port of Discharge Key] = L2.[Destination Port Key]
         JOIN FreightShipping.dbo.LegBridge LB2 ON L2.[Leg Key] = LB2.[Leg Key]
         JOIN FreightShipping.dbo.LegSchedule LS2 ON L2.[Leg Key] = LS2.[Leg Key] AND LS2.[Leg Schedule Key] = LSB4.[Leg Schedule Key]
         JOIN FreightShipping.dbo.LegBridge LB ON Vo.[Leg Bridge Key] = LB.[Leg Bridge Key]
         JOIN FreightShipping.dbo.Leg L ON LB.[Leg Key] = L.[Leg Key] AND LB.[Order] >= LB1.[Order] AND LB.[Order] <= LB2.[Order]

        JOIN FreightShippingDW.dbo.DateDimension DDim1 ON StartLS.[Origin Port Scheduled Departure Date] = DDim1.[Date]
        JOIN FreightShippingDW.dbo.DateDimension DDim2 ON EndLS.[Destination Port Scheduled Arrival Date] = DDim2.[Date]
        JOIN FreightShippingDW.dbo.DateDimension DDim3 ON LS1.[Origin Port Scheduled Departure Date] = DDim3.[Date]
        JOIN FreightShippingDW.dbo.DateDimension DDim4 ON LS2.[Destination Port Scheduled Arrival Date] = DDim4.[Date]
        JOIN FreightShippingDW.dbo.DateDimension DDim5 ON StartLS.[Origin Port Actual Departure Date] = DDim5.[Date]
        JOIN FreightShippingDW.dbo.DateDimension DDim6 ON EndLS.[Destination Port Actual Arrival Date] = DDim6.[Date]
        JOIN FreightShippingDW.dbo.DateDimension DDim7 ON LS1.[Origin Port Actual Departure Date] = DDim7.[Date]
        JOIN FreightShippingDW.dbo.DateDimension DDim8 ON LS2.[Destination Port Actual Arrival Date] = DDim8.[Date]

        JOIN FreightShippingDW.dbo.PortDimension PDim1 ON StartLeg.[Origin Port Key] = PDim1.[]
        JOIN FreightShippingDW.dbo.PortDimension PDim1 ON EndLeg.[Destination Port Key] = PDim2

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

