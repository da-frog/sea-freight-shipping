IF OBJECT_ID('dbo.HSSection', 'U') IS NOT NULL
    TRUNCATE TABLE HSSection;
GO
INSERT INTO HSSection VALUES
    (N'I',N'live animals; animal products'),
    (N'II',N'Vegetable products'),
    (N'III',N'Animal or vegetable fats and oils and their cleavage products; prepared edible fats; animal or vegetable waxes'),
    (N'IV',N'Prepared foodstuffs; beverages, spirits and vinegar; tobacco and manufactured tobacco substitutes'),
    (N'V',N'Mineral products'),
    (N'VI',N'Products of the chemical or allied industries'),
    (N'VII',N'Plastics and articles thereof; rubber and articles thereof '),
    (N'VIII',N'Raw hides and skins, leather, furskins and articles thereof; saddlery and harness; travel goods, handbags and similar containers; articles of animal gut (other than silk-worm gut)'),
    (N'IX',N'Wood and articles of wood; wood charcoal; cork and articles of cork; manufactures of straw, of esparto or of other plaiting materials; basketware and wickerwork'),
    (N'X',N'Pulp of wood or of other fibrous cellulosic material; recovered (waste and scrap) paper or paperboard; paper and paperboard and articles thereof'),
    (N'XI',N'Textiles and textile articles'),
    (N'XII',N'Footwear, headgear, umbrellas, sun umbrellas, walking-sticks, seat-sticks, whips, riding-crops and parts thereof; prepared feathers and articles made therewith; artificial flowers; articles of human hair'),
    (N'XIII',N'Articles of stone, plaster, cement, asbestos, mica or similar materials; ceramic products; glass and glassware'),
    (N'XIV',N'Natural or cultured pearls, precious or semi-precious stones, precious metals, metals clad with precious metal and articles thereof; imitation jewellery; coin'),
    (N'XV',N'Base metals and articles of base metal'),
    (N'XVI',N'Machinery and mechanical appliances; electrical equipment; parts thereof; sound recorders and reproducers, television image and sound recorders and reproducers, and parts and accessories of such articles'),
    (N'XVII',N'Vehicles, aircraft, vessels and associated transport equipment'),
    (N'XVIII',N'Optical, photographic, cinematographic, measuring, checking, precision, medical or surgical instruments and apparatus; clocks and watches; musical instruments; parts and accessories thereof'),
    (N'XIX',N'Arms and ammunition; parts and accessories thereof'),
    (N'XX',N'Miscellaneous manufactured articles'),
    (N'XXI',N'Works of art, collectors'' pieces and antiques');
