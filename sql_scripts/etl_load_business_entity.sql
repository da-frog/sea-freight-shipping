USE FreightShipping;

SELECT [Business Entity Key],
       [Name]                                                                    [Business Entity Name],
       [Phone]                                                                   [Business Entity Telephone],
       [Fax]                                                                     [Business Entity Fax],
       [E-mail]                                                                  [Business Entity E-mail],
       CONCAT([Address Line 1], [Address Line 2], [City], [Country], [ZIP Code]) [Business Entity Address],
       [City]                                                                    [Business Entit City],
       [Country]                                                                 [Business Entity Country],
       [ZIP code]                                                                [Business Entity ZIP Code]
FROM BusinessEntity BE
         JOIN Address A ON BE.[Address Key] = A.[Address Key]
ORDER BY [Business Entity Key]
