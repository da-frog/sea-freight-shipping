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
    [Actual Voyage Departure Date Key]      varchar(),
    [Actual Voyage Arrival Date Key]        varchar(),
    [Actual Shipment Departure Date Key]    int REFERENCES DateDimension,
    [Actual Shipment Arrival Date Key]      int REFERENCES DateDimension,
    [Voyage Origin Port Key]                int REFERENCES PortDimension,
    [Voyage Destination Port Key]           int REFERENCES PortDimension,
    [Shipment Origin Port Key]              int REFERENCES PortDimension,
    [Shipment Destination Port Key]         int REFERENCES PortDimension,
    [Ship Mode Key]                         int REFERENCES ModeDimension,
    [Container Key]                         int REFERENCES ContainerDimension,
    [Commodity Key]                         int REFERENCES CommodityDimension,
    [Consignor Key]                         int REFERENCES ConsignorDimension,
    [Foreign Transporter Key]               int REFERENCES TransporterDimension,
    [Foreign Consolidator Key]              int REFERENCES ConsolidatorDimension,
    [Shipper Key]                           int REFERENCES ShipperDimension,
    [Domestic Consolidator Key]             int REFERENCES ConsolidatorDimension,
    [Domestic Transporter Key]              int REFERENCES TransporterDimension,
    [Consignee Key]                         int REFERENCES ConsigneeDimension,
    [Bill-of-Lading Number (DD)]            varchar(),
    [Leg Fee]                               varchar(),
    [Expected Tariffs]                      varchar(),
    [Actual Tariffs]                        varchar(),
    [Leg Miles]                             float,
);