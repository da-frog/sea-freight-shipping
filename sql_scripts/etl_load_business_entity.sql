SELECT [Business Entity Key],
       [Name]                                                                            [Business Entity Name],
       [Phone]                                                                           [Business Entity Telephone],
       [Fax]                                                                             [Business Entity Fax],
       [E-mail]                                                                          [Business Entity E-mail],
       CONCAT_WS(' ', [Address Line 1], [Address Line 2], [City], [Country], [ZIP Code]) [Business Entity Address],
       CACC.Continent_Name                                                               [Business Entity Region],
       [City]                                                                            [Business Entity City],
       [Country]                                                                         [Business Entity Country],
       [ZIP code]                                                                        [Business Entity ZIP Code]
FROM BusinessEntity BE
         JOIN FreightShipping.dbo.Address A ON BE.[Address Key] = A.[Address Key]
         JOIN FreightShippingETL.dbo.CountryAndContinentCodes CACC ON A.[Alpha 2] = CACC.Two_Letter_Country_Code
ORDER BY [Business Entity Key]
