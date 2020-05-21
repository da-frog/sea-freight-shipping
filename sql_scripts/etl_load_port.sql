WITH CountryContinent (Two_Letter_Country_Code, continent_continent)
         AS (
        SELECT m.Two_Letter_Country_Code,
               continent_continent = STUFF((SELECT '/' + md.Continent_Name
                                            FROM FreightShippingETL.dbo.CountryAndContinentCodes md
                                            WHERE m.Two_Letter_Country_Code = md.Two_Letter_Country_Code
                                            FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 1, '')
        FROM FreightShippingETL.dbo.CountryAndContinentCodes m
                 JOIN FreightShippingETL.dbo.CountryAndContinentCodes s
                      ON s.Two_Letter_Country_Code = m.Two_Letter_Country_Code
        GROUP BY m.Two_Letter_Country_Code
    )
SELECT [Port Key],
       [Port Name],
       [Port Type],
       CC.continent_continent                                                            [Port Region],
       [Country]                                                                         [Port Country],
       [City]                                                                            [Port City],
       CONCAT_WS(' ', [Address Line 1], [Address Line 2], [City], [Country], [ZIP Code]) [Port Address],
       P.Phone                                                                           [Port Telephone]
FROM Port P
         JOIN FreightShipping.dbo.Address A ON P.[Address Key] = A.[Address Key]
         LEFT JOIN CountryContinent CC ON A.[Alpha 2] = CC.Two_Letter_Country_Code
ORDER BY [Port Key]
