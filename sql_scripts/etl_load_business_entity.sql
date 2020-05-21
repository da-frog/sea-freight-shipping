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
SELECT [Business Entity Key]
       ,[Name]                                                                            [Business Entity Name]
       ,[Phone]                                                                           [Business Entity Telephone]
       ,[Fax]                                                                             [Business Entity Fax]
       ,[E-mail]                                                                          [Business Entity E-mail]
       ,CONCAT_WS(' ', [Address Line 1], [Address Line 2], [City], [Country], [ZIP Code]) [Business Entity Address]
       ,CC.continent_continent                                                            [Business Entity Region]
       ,[City]                                                                            [Business Entity City]
       ,[Country]                                                                         [Business Entity Country]
       ,[ZIP code]                                                                        [Business Entity ZIP Code]
FROM FreightShipping.dbo.BusinessEntity BE
         JOIN FreightShipping.dbo.Address A ON BE.[Address Key] = A.[Address Key]
         LEFT JOIN CountryContinent CC ON A.[Alpha 2] = CC.Two_Letter_Country_Code
ORDER BY [Business Entity Key]
