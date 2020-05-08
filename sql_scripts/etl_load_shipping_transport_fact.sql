SELECT SVDDDim.[Date]                [Scheduled Voyage Departure Date Key],
       SVADDim.[Date]                [Scheduled Voyage Arrival Date Key],
       SSDDDim.[Date]                [Scheduled Shipment Departure Date Key],
       SSADDim.[Date]                [Scheduled Shipment Arrival Date Key],
       AVDDDim.[Date]                [Actual Voyage Departure Date Key],
       AVADDim.[Date]                [Actual Voyage Arrival Date Key],
       ASDDDim.[Date]                [Actual Shipment Departure Date Key],
       ASADDim.[Date]                [Actual Shipment Arrival Date Key],
       StartLeg.[Origin Port Key]    [Voyage Origin Port Key],
       EndLeg.[Destination Port Key] [Voyage Destination Port Key],
       L1.[Origin Port Key]          [Shipment Origin Port Key],
       L2.[Destination Port Key]     [Shipment Destination Port Key],
       S.[Vehicle Key]               [Ship Mode Key],
       [Container Key],
       [Commodity Key],
       [Consignor Key],
       [Foreign Transporter Key],
       [Foreign Consolidator Key],
       [Courier Key]                 [Shipper Key],
       [Domestic Consolidator Key],
       [Domestic Transporter Key],
       [Consignee Key],
       [Bill-of-Lading Number]       [Bill-of-Lading Number (DD)],
       [Voyage Fee],
       [Expected Tariffs],
       [Actual Tariffs],
       SUM(L.[Leg Miles])            [Shipment Miles]
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
         JOIN FreightShippingDW.dbo.DateDimension SVDDDim ON StartLS.[Origin Port Scheduled Departure Date] = SVDDDim.[Date]
         JOIN FreightShippingDW.dbo.DateDimension SVADDim ON EndLS.[Destination Port Scheduled Arrival Date] = SVADDim.[Date]
         JOIN FreightShippingDW.dbo.DateDimension SSDDDim ON LS1.[Origin Port Scheduled Departure Date] = SSDDDim.[Date]
         JOIN FreightShippingDW.dbo.DateDimension SSADDim ON LS2.[Destination Port Scheduled Arrival Date] = SSADDim.[Date]
         JOIN FreightShippingDW.dbo.DateDimension AVDDDim ON StartLS.[Origin Port Actual Departure Date] = AVDDDim.[Date]
         JOIN FreightShippingDW.dbo.DateDimension AVADDim ON EndLS.[Destination Port Actual Arrival Date] = AVADDim.[Date]
         JOIN FreightShippingDW.dbo.DateDimension ASDDDim ON LS1.[Origin Port Actual Departure Date] = ASDDDim.[Date]
         JOIN FreightShippingDW.dbo.DateDimension ASADDim ON LS2.[Destination Port Actual Arrival Date] = ASADDim.[Date]
GROUP BY LB.[Leg Bridge Key], SVDDDim.[Date], SVADDim.[Date], SSDDDim.[Date], SSADDim.[Date], AVDDDim.[Date],
         AVADDim.[Date], ASDDDim.[Date], ASADDim.[Date], StartLeg.[Origin Port Key], EndLeg.[Destination Port Key],
         L1.[Origin Port Key], L2.[Destination Port Key], S.[Vehicle Key], [Container Key], [Commodity Key],
         [Consignor Key], [Foreign Transporter Key], [Foreign Consolidator Key], [Courier Key],
         [Domestic Consolidator Key], [Domestic Transporter Key], [Consignee Key], [Bill-of-Lading Number],
         [Voyage Fee], [Expected Tariffs], [Actual Tariffs], [Shipment Key]
ORDER BY [Shipment Key]
