USE FreightShipping;

SELECT [Port Key],
       [Port Name],
       [Port Type],
       [Country]                                                                         [Port Country],
       [City]                                                                            [Port City],
       CONCAT_WS(' ', [Address Line 1], [Address Line 2], [City], [Country], [ZIP Code]) [Port Address],
       P.Phone                                                                           [Port Telephone]
FROM Port P
         JOIN Address A on P.[Address Key] = A.[Address Key]
ORDER BY [Port Key]

