IF (SELECT OBJECT_ID('dbo.BillOfLadingFact')) > 0
    DROP TABLE dbo.BillOfLadingFact;

CREATE TABLE BillOfLadingFact (
    [Bill-of-Lading Key]    int IDENTITY (1,1) NOT NULL
);
