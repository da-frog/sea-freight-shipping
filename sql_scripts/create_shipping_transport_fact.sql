USE FreightShippingDW;

IF OBJECT_ID('dbo.ShippingTransportFact', 'U') IS NOT NULL
    DROP TABLE ShippingTransportFact;
GO
CREATE TABLE ShippingTransportFact
(
    [Scheduled Voyage Departure Date Key]   int REFERENCES DateDimension,
    [Scheduled Voyage Arrival Date Key]     int REFERENCES DateDimension,
    [Scheduled Shipment Departure Date Key] int REFERENCES DateDimension,
    [Scheduled Shipment Arrival Date Key]   int REFERENCES DateDimension,
    [Actual Voyage Departure Date Key]      int REFERENCES DateDimension,
    [Actual Voyage Arrival Date Key]        int REFERENCES DateDimension,
    [Actual Shipment Departure Date Key]    int REFERENCES DateDimension,
    [Actual Shipment Arrival Date Key]      int REFERENCES DateDimension,
    [Voyage Origin Port Key]                int REFERENCES PortDimension,
    [Voyage Destination Port Key]           int REFERENCES PortDimension,
    [Shipment Origin Port Key]              int REFERENCES PortDimension,
    [Shipment Destination Port Key]         int REFERENCES PortDimension,
    [Ship Mode Key]                         int REFERENCES ShipModeDimension,
    [Container Key]                         int REFERENCES ContainerDimension,
    [Commodity Key]                         int REFERENCES CommodityDimension,
    [Consignor Key]                         int REFERENCES BusinessEntityDimension,
    [Foreign Transporter Key]               int REFERENCES BusinessEntityDimension,
    [Foreign Consolidator Key]              int REFERENCES BusinessEntityDimension,
    [Shipper Key]                           int REFERENCES BusinessEntityDimension,
    [Domestic Consolidator Key]             int REFERENCES BusinessEntityDimension,
    [Domestic Transporter Key]              int REFERENCES BusinessEntityDimension,
    [Consignee Key]                         int REFERENCES BusinessEntityDimension,
    [Bill-of-Lading Number (DD)]            varchar(17),
    [Leg Fee]                               money,
    [Expected Tariffs]                      decimal,
    [Actual Tariffs]                        decimal,
    [Leg Miles]                             decimal,
);