-- ADMISSION
INSERT INTO ADMISSION
    (AdmissionType, AdmissionPrice)
VALUES
    ('General', 15.99),
    ('Child', 10.99),
    ('Senior', 12.49),
    ('VIP', 24.99),
    ('Tuesday General', 4.99);

-- USER
INSERT INTO [USER]
    (FirstName, LastName, Email, Phone, Birthday, PasswordHash, ProfilePicURL)
VALUES
    ('John', 'Doe', 'doejohn@gmail.com', '4161234567', '2001-03-15', '0ac28ef634f3a841', 'https://cdn.cineplex.com/profiles/1.jpg'),
    ('Henry', 'Outer', 'henryouter@yahoo.ca', NULL, NULL, 'bbdd75b09cae1028', 'https://cdn.cineplex.com/profiles/2.jpg'),
    ('Felix', 'Lengyel', 'thatcow@gmail.com', '4163456789', '1999-11-05', '77aaa45466c471d4', 'https://cdn.cineplex.com/profiles/3.jpg'),
    ('Nona', 'Masery', 'Mnasery@gmail.com', '4164567890', '2002-01-30', 'ebd7203f0c3b16d1', 'https://cdn.cineplex.com/profiles/4.jpg'),
    ('Jordan', 'Beethoven', 'jaybeet@gmail.com', '4165678901', NULL, '9e36ea86f6cdc955', 'https://cdn.cineplex.com/profiles/5.jpg');

-- THEATRE
INSERT INTO THEATRE
    (TheatreName, Phone, Address, Unit, PostalCode)
VALUES
    ('Cineplex VIP Cinemas Don Mills', '4166440820', '12 Marie Labatte Rd', 'B7', 'M3C0H9'),
    ('Cineplex Cinemas Scarborough', '4162960022', '300 Borough Dr', NULL, 'M1P4P5'),
    ('Cineplex Cinemas Fairview Mall', '4166447746', '1800 Sheppard Ave East', 'Y007', 'M2J5A7'),
    ('Cineplex Cinemas Mississauga', '9058901600', '100 City Centre Dr', NULL, 'L5B2C9'),
    ('Cineplex VIP Cinemas Oakville', '9058429200', '240 Leighland Ave', NULL, 'L6H3H6');

-- GENRE
INSERT INTO GENRE
    (GenreName)
VALUES
    ('Horror'),
    ('Action'),
    ('Comedy'),
    ('Thriller'),
    ('Romance'),
    ('Drama'),
	('Family'),
	('Animation'),
	('Sci-fi');

-- MOVIE
INSERT INTO MOVIE
    (MovieName, PosterURL, TrailerURL, Language, Description, Director, Cast, ReleaseDate, Rating)
VALUES
    ('Hoppers',
        'https://www.cineplex.com/posters/hoppers.jpg',
        'https://www.cineplex.com/trailers/hoppers.mp4',
        'English',
        'When scientists discover a way to transform human consciousness into robotic animals, Mabel uses the new technology to uncover mysteries of the animal world that are beyond anything she could have ever imagined.',
        'Dan Abraham',
        'Piper Curda, Bobby Moynihan, Jon Hamm',
        '2026-04-23', 'PG'),

    ('The Bride!',
        'https://www.cineplex.com/posters/the_bride.jpg',
        'https://www.cineplex.com/trailers/the_bride.mp4',
        'English',
        'A lonely Frankenstein (Bale) travels to 1930s Chicago to ask groundbreaking scientist Dr. Euphronious to create a companion for him.',
        'Maggie Gyllenhaal',
        'Jessie Buckley, Christian Bale',
        '2026-03-05', 'R'),

    ('The Super Mario Galaxy Movie',
        'https://www.cineplex.com/posters/mario_galaxy.jpg',
        'https://www.cineplex.com/trailers/mario_galaxy.mp4',
        'English',
        'The Super Mario Galaxy Movie is an upcoming animated adventure comedy film based on the 2007 video game Super Mario Galaxy.',
        'Aaron Horvath',
        'Chris Pratt, Anya Taylor-Joy, Jack Black',
        '2026-03-31', 'G'),

    ('Scream 7',
        'https://www.cineplex.com/posters/scream7.jpg',
        'https://www.cineplex.com/trailers/scream7.mp4',
        'English',
        'When a new Ghostface killer emerges in the quiet town where Sidney Prescott has built a new life, her darkest fears are realized.',
        'Kevin Williamson',
        'Melissa Barrera, Jenna Ortega, Courteney Cox',
        '2026-03-26', 'R'),

    ('Peaky Blinders: The Immortal Man',
        'https://www.cineplex.com/posters/peaky_blinders.jpg',
        'https://www.cineplex.com/trailers/peaky_blinders.mp4',
        'English',
        'Birmingham, 1940. Amidst the chaos of WWII, Tommy Shelby is driven back from a self-imposed exile to face his most destructive reckoning yet.',
        'Tom Harper',
        'Cillian Murphy, Tom Hardy, Sophie Rundle',
        '2026-03-05', 'R'),

	('Oppenheimer',
		'https://www.cineplex.com/posters/oppenheimer.jpg',
		'https://www.cineplex.com/trailers/oppenheimer.mp4',
		'English',
		'Oppenheimer and a team of scientists spend years developing and designing the atomic bomb. Their work comes to fruition on July 16, 1945, as they witness the world''s first nuclear explosion, forever changing the course of history.',
		'Christopher Nolan',
		'Cillian Murphy, Florence Pugh, Emily Blunt',
		'2023-07-21', 'R'),

	('The Prestige',
		'https://www.cineplex.com/posters/the_prestige.jpg',
		'https://www.cineplex.com/trailers/the_prestige.mp4',
		'English',
		'An illusion gone horribly wrong pits two 19th-century magicians against each other in a bitter battle for supremacy.',
		'Christopher Nolan',
		'Christian Bale, Hugh Jackman, Scarlett Johansson',
		'2006-10-20', 'PG-13');

-- MOVIE GENRE
INSERT INTO MOVIEGENRE
    (MovieID, GenreID)
VALUES
    (10000, 10002),
	(10000, 10007),
	(10000, 10008),
    (10001, 10004),
	(10001, 10008),
    (10002, 10006),
    (10002, 10007),
    (10003, 10000),
    (10004, 10001),
	(10004, 10003),
	(10005, 10001),
	(10005, 10003),
	(10006, 10001),
	(10006, 10008);

-- FORMAT
INSERT INTO FORMAT
    (FormatName, MotionType, VisualType, AudioType, ComfortType)
VALUES
    ('Standard', 'STANDARD', 'STANDARD', 'STANDARD', 'STANDARD'),
    ('3D Clubhouse', 'STANDARD', '3D', 'STANDARD', 'CLUBHOUSE'),
    ('IMAX', 'STANDARD', 'STANDARD', 'IMAX', 'STANDARD'),
    ('UltraAVX', 'D-BOX', 'SCREENX', 'DOLBY_ATMOS', 'STANDARD'),
    ('VIP', 'STANDARD', 'STANDARD', 'DOLBY_ATMOS', 'VIP');

-- MOVIEFORMAT
INSERT INTO MOVIEFORMAT
    (MovieID, FormatID)
VALUES
    (10000, 10000),
    (10000, 10002),
    (10001, 10000),
    (10001, 10003),
    (10002, 10001),
    (10002, 10000),
    (10003, 10000),
    (10003, 10001),
    (10004, 10004),
	(10005, 10000),
	(10005, 10002),
	(10006, 10000),
	(10006, 10003);

-- AUDITORIUM
INSERT INTO AUDITORIUM
    (AudCode, SeatCapacity, TheatreID)
VALUES
    ('Aud 1', 200, 10000),
    ('IMAX 1', 350, 10000),
    ('VIP 2', 80, 10004),
    ('Aud 10', 175, 10003),
    ('D-BOX 1', 120, 10002),
	('VIP 4', 100, 10001);

-- FORMATAVAILABILITY
INSERT INTO FORMATAVAILABILITY
    (AudID, FormatID)
VALUES
    (10000, 10000),
    (10001, 10002),
    (10002, 10004),
    (10003, 10000),
    (10003, 10001),
    (10004, 10003),
	(10005, 10004);

-- SEAT
INSERT INTO SEAT
    (SeatCode, SeatType, AudID)
VALUES
	-- Standard auditorium
	('A1', 'ACCESSIBLE', 10000),
	('A2', 'STANDARD', 10000),
	('B1', 'STANDARD', 10000),
	('B2', 'STANDARD', 10000),
	('C1', 'STANDARD', 10000),

	-- IMAX auditorium
	('B1', 'STANDARD', 10001),
	('B2', 'RECLINER', 10001),
	('B3', 'RECLINER', 10001),
	('C1', 'ACCESSIBLE', 10001),
	('C2', 'RECLINER', 10001),

	-- VIP auditorium
	('A1', 'ACCESSIBLE', 10002),
	('B2', 'VIP', 10002),
	('C3', 'VIP', 10002),
	('D4', 'VIP', 10002),
	('E5', 'VIP', 10002),

	-- Standard auditorium
	('C1', 'STANDARD', 10003),
	('C2', 'STANDARD', 10003),
	('C3', 'STANDARD', 10003),
	('D1', 'RECLINER', 10003),
	('D2', 'RECLINER', 10003),

	-- D-BOX auditorium
	('A1', 'ACCESSIBLE', 10004),
	('A2', 'VIP', 10004),
	('B1', 'STANDARD', 10004),
	('B2', 'STANDARD', 10004),
	('C1', 'VIP', 10004),

	-- VIP auditorium
	('A1', 'ACCESSIBLE', 10005),
	('A2', 'VIP', 10005),
	('A3', 'RECLINER', 10005),
	('A4', 'VIP', 10005),
	('A5', 'ACCESSIBLE', 10005);

-- SHOWING
INSERT INTO SHOWING
    (MovieID, AudID, StartTime)
VALUES
	-- Afternoon
	(10000, 10000, '2026-04-23 13:30:00'),
	(10002, 10003, '2026-03-31 14:00:00'), -- Tuesday
	(10001, 10001, '2026-03-05 15:15:00'),

	-- Early evening
	(10000, 10000, '2026-04-23 17:30:00'),
	(10003, 10003, '2026-03-26 17:45:00'),
	(10002, 10004, '2026-03-30 18:00:00'),
	(10006, 10003, '2026-03-04 18:30:00'),
	(10002, 10005, '2026-03-19 18:45:00'),

	-- Prime evening
	(10005, 10001, '2026-01-01 19:00:00'),
	(10003, 10003, '2026-03-26 19:30:00'),
	(10004, 10002, '2026-03-05 19:45:00'),
	(10000, 10000, '2026-04-23 20:00:00'),
	(10002, 10001, '2026-03-30 20:15:00'),

	-- Late evening
	(10006, 10003, '2026-03-03 21:15:00'),
	(10003, 10003, '2026-03-26 21:30:00'),
	(10004, 10002, '2026-03-05 21:45:00'),
	(10005, 10001, '2026-01-01 21:45:00'),
	(10001, 10001, '2026-03-05 22:00:00'),

	-- Late night
	(10003, 10004, '2026-03-26 23:00:00'),
	(10002, 10003, '2026-03-30 23:15:00');

-- CONCESSIONITEM
INSERT INTO CONCESSIONITEM
    (ItemName, ItemPrice, Category)
VALUES
	('Small Popcorn', 6.49, 'POPCORN'),
    ('Large Popcorn', 9.99, 'POPCORN'),
	('Medium Coca-Cola', 5.49, 'DRINK'),
	('Large Sprite', 5.99, 'DRINK'),
	('Bottled Water', 3.99, 'DRINK'),
	('Sour Patch Kids', 4.49, 'CANDY'),
	('M&Ms', 4.99, 'CANDY'),
	('Nachos & Cheese', 8.49, 'SNACK'),
	('Hot Dog', 6.99, 'SNACK'),
	('Pretzel Bites', 7.49, 'SNACK');

-- SCENECARD
INSERT INTO SCENECARD
    (SceneCardNum, ExpirationDate, ScenePoints, UserID)
VALUES
    ('4829153076419026', '2027-01-01', 500, 10000),
    ('7392641805529173', '2028-06-30', 1200, 10001),
    ('6157082943361048', '2027-03-15', 300, 10002),
    ('9041735682207195', '2026-12-31', 850, 10003);
	-- one user without SceneCard --

-- ORDER
INSERT INTO [ORDER]
    (OrderDateTime, OrderChannel, Discount, ScenePointsEarned, UserID)
VALUES
    ('2026-02-28 14:30:00', 'KIOSK', 0.00, 50, 10000),
    ('2026-03-01 11:15:00', 'KIOSK', 6.50, 30, 10001),
    ('2026-03-04 18:45:00', 'BOX_OFFICE', 0.00, 75, 10002),
    ('2026-03-06 20:00:00', 'DESKTOP', 2.50, 100, 10003),
    ('2026-03-09 09:30:00', 'MOBILE', 24.99, 60, 10004),
    ('2026-03-26 19:15:00', 'MOBILE', 0.00, 150, 10001),
    ('2026-03-26 19:45:00', 'BOX_OFFICE', 0.00, 0, NULL), -- Guest checkout
    ('2026-04-23 13:30:00', 'DESKTOP', 5.00, 45, 10000),
    ('2026-03-05 16:30:00', 'KIOSK', 0.00, 20, 10003),
    ('2026-03-05 18:50:00', 'MOBILE', 0.00, 50, 10002),
    ('2026-03-01 18:30:00', 'DESKTOP', 0.00, 40, 10002),
    ('2026-03-01 21:30:00', 'BOX_OFFICE', 0.00, 40, NULL),
    ('2026-03-03 17:45:00', 'KIOSK', 0.00, 35, 10003),
    ('2026-03-03 21:00:00', 'BOX_OFFICE', 0.00, 0, NULL),
    ('2026-03-03 21:10:00', 'MOBILE', 15.99, 20, 10004);

-- PAYMENT
INSERT INTO PAYMENT
    (PaymentDateTime, PaymentMethod, OrderID)
VALUES
    ('2026-02-28 14:31:00', 'CREDIT', 10000),
    ('2026-03-01 11:16:00', 'DEBIT', 10001),
    ('2026-03-04 18:46:00', 'CASH', 10002),
    ('2026-03-06 20:01:00', 'CREDIT', 10003),
    ('2026-03-09 09:31:00', 'GIFT_CARD', 10004),
    ('2026-03-26 19:16:00', 'CREDIT', 10005),
    ('2026-03-26 19:46:00', 'CASH', 10006),
    ('2026-04-23 13:31:00', 'DEBIT', 10007),
    ('2026-03-05 16:32:00', 'CREDIT', 10008),
    ('2026-03-05 18:52:00', 'PAYPAL', 10009),
    ('2026-03-01 18:31:00', 'DEBIT', 10010),
    ('2026-03-01 21:31:00', 'CREDIT', 10011),
    ('2026-03-03 17:46:00', 'CASH', 10012),
    ('2026-03-03 21:01:00', 'PAYPAL', 10013),
    ('2026-03-03 21:11:00', 'GIFT_CARD', 10014);

-- TICKET
INSERT INTO TICKET
    (AdmissionID, OrderID, ShowingID, SeatID)
VALUES
    (10000, 10000, 10000, 10000),
    (10004, 10001, 10001, 10004),
    (10002, 10002, 10002, 10007),
    (10003, 10003, 10003, 10009),
    (10000, 10004, 10004, 10014),
    (10000, 10005, 10003, 10010),
    (10000, 10005, 10003, 10011),
    (10003, 10006, 10003, 10012),
    (10001, 10007, 10000, 10001),
    (10001, 10007, 10000, 10002),
    (10004, 10008, 10001, 10005),
    (10000, 10009, 10004, 10015),
	(10000, 10010, 10015, 10003),
	(10000, 10010, 10015, 10004),
	(10003, 10011, 10007, 10012),
	(10000, 10012, 10017, 10016),
	(10002, 10013, 10016, 10018),
	(10002, 10014, 10016, 10019),
	(10000, 10012, 10005, 10020),
    (10000, 10012, 10006, 10015),
    (10003, 10014, 10008, 10006),
    (10000, 10003, 10008, 10017),
	-- no ticket for showing 10009 --
    (10002, 10009, 10010, 10011),
    (10000, 10000, 10011, 10003),
    (10001, 10001, 10012, 10007),
    (10000, 10002, 10013, 10018),
    (10000, 10004, 10014, 10019),
    (10003, 10005, 10018, 10021),
    (10002, 10006, 10019, 10016);

-- CONCESSIONORDER
INSERT INTO CONCESSIONORDER
    (ItemID, OrderID, Quantity)
VALUES
    (10000, 10000, 2),
    (10001, 10001, 1),
    (10002, 10002, 3),
    (10003, 10003, 1),
    (10004, 10004, 2),
    (10000, 10005, 1),
    (10001, 10005, 2),
    (10000, 10007, 2),
    (10002, 10007, 1),
    (10003, 10008, 1),
	(10001, 10010, 1),
	(10002, 10010, 2),
	(10005, 10011, 1),
	(10006, 10012, 1),
	(10007, 10013, 2),
	(10008, 10014, 1);

-- print tables
SELECT * FROM MOVIE;
SELECT * FROM GENRE;
SELECT * FROM MOVIEGENRE;
SELECT * FROM FORMAT;
SELECT * FROM MOVIEFORMAT;
SELECT * FROM THEATRE;
SELECT * FROM AUDITORIUM;
SELECT * FROM FORMATAVAILABILITY;
SELECT * FROM SEAT;
SELECT * FROM SHOWING;
SELECT * FROM ADMISSION;
SELECT * FROM [USER];
SELECT * FROM SCENECARD;
SELECT * FROM [ORDER];
SELECT * FROM PAYMENT;
SELECT * FROM TICKET;
SELECT * FROM CONCESSIONITEM;
SELECT * FROM CONCESSIONORDER;