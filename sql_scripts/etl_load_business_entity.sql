USE FreightShipping;

SELECT [Business Entity Key],
       [Name],
       [Phone]                                                                   [Telephone],
       [Fax],
       [E-mail]                                                                  [Email],
       CONCAT([Address Line 1], [Address Line 2], [City], [Country], [ZIP Code]) [Address],
       [City],
       [Country],
       [ZIP code]
FROM BusinessEntity BE
         JOIN Address A ON BE.[Address Key] = A.[Address Key]
