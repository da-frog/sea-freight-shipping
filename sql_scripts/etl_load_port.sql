SELECT [Port Key],
       [Port Name],
       [Port Type],
       CACC.Continent_Name                                                               [Port Region],
       [Country]                                                                         [Port Country],
       [City]                                                                            [Port City],
       CONCAT_WS(' ', [Address Line 1], [Address Line 2], [City], [Country], [ZIP Code]) [Port Address],
       P.Phone                                                                           [Port Telephone]
FROM Port P
         JOIN FreightShipping.dbo.Address A ON P.[Address Key] = A.[Address Key]
         JOIN FreightShippingETL.dbo.CountryAndContinentCodes CACC ON A.[Alpha 2] = CACC.Two_Letter_Country_Code
ORDER BY [Port Key]

