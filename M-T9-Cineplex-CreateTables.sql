CREATE TABLE MOVIE (
	MovieID INT IDENTITY(10000, 1) PRIMARY KEY,
    MovieName VARCHAR(150) NOT NULL,
    PosterURL VARCHAR(200) NOT NULL,
    TrailerURL VARCHAR(200) NOT NULL,
    Language VARCHAR(50) NOT NULL,
    Description VARCHAR(1000) NOT NULL,
    Director VARCHAR(100) NOT NULL,
    Cast VARCHAR(500) NOT NULL,
    ReleaseDate DATE NOT NULL,
    Rating VARCHAR(5) NOT NULL CHECK (Rating IN ('G', 'PG', 'PG-13', 'R', 'NC-17')) -- MPA age ratings
);

CREATE TABLE GENRE (
    GenreID INT IDENTITY(10000, 1) PRIMARY KEY,
    GenreName VARCHAR(20) NOT NULL UNIQUE,
);

CREATE TABLE MOVIEGENRE (
    MovieID INT,
    GenreID INT,

    PRIMARY KEY(MovieID, GenreID),
    FOREIGN KEY (MovieID) REFERENCES MOVIE(MovieID)
		ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (GenreID) REFERENCES GENRE(GenreID)
		ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE FORMAT (
    FormatID INT IDENTITY(10000, 1) PRIMARY KEY,
    FormatName VARCHAR(50) NOT NULL UNIQUE,
    MotionType VARCHAR(20) NOT NULL CHECK (MotionType IN ('STANDARD', 'D-BOX', '4DX')),
    VisualType VARCHAR(20) NOT NULL CHECK (VisualType IN ('STANDARD', '3D', 'SCREENX')),
    AudioType VARCHAR(20) NOT NULL CHECK (AudioType IN ('STANDARD', 'DOLBY_ATMOS', 'IMAX')),
    ComfortType VARCHAR(20) NOT NULL CHECK (ComfortType IN ('STANDARD', 'VIP', 'CLUBHOUSE')),

	UNIQUE(MotionType, VisualType, AudioType, ComfortType)
);

CREATE TABLE MOVIEFORMAT (
    MovieID INT,
    FormatID INT,

    PRIMARY KEY (MovieID, FormatID),
    FOREIGN KEY (MovieID) REFERENCES MOVIE(MovieID)
		ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (FormatID) REFERENCES FORMAT(FormatID)
		ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE THEATRE (
    TheatreID INT IDENTITY(10000, 1) PRIMARY KEY,
    TheatreName VARCHAR(50) NOT NULL,
    Phone CHAR(10) NOT NULL,
    Address VARCHAR(50) NOT NULL,
	Unit VARCHAR(50) NULL,
    PostalCode CHAR(6) NOT NULL
);

CREATE TABLE AUDITORIUM (
    AudID INT IDENTITY(10000, 1) PRIMARY KEY,
    AudCode VARCHAR(10) NOT NULL, -- e.g. 'Aud 1', 'VIP 4'
    SeatCapacity INT NOT NULL CHECK (SeatCapacity > 0),
    TheatreID INT NOT NULL,

	UNIQUE (TheatreID, AudCode), -- ensure auditorium codes are all unique within the same theatre
    FOREIGN KEY (TheatreID) REFERENCES THEATRE(TheatreID)
		ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE SEAT (
    SeatID INT IDENTITY(10000, 1) PRIMARY KEY,
    SeatCode VARCHAR(10) NOT NULL, -- e.g. 'A5', 'D20'
    SeatType VARCHAR(20) NOT NULL CHECK (SeatType IN ('STANDARD', 'VIP', 'RECLINER', 'ACCESSIBLE')),
    AudID INT NOT NULL,

    UNIQUE (AudID, SeatCode), -- ensure seat codes are all unique within the same auditorium
    FOREIGN KEY (AudID) REFERENCES AUDITORIUM(AudID)
		ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE FORMATAVAILABILITY (
    AudID INT,
    FormatID INT,

    PRIMARY KEY (AudID, FormatID),
    FOREIGN KEY (AudID) REFERENCES AUDITORIUM(AudID)
		ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (FormatID) REFERENCES FORMAT(FormatID)
		ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE SHOWING (
    ShowingID INT IDENTITY(10000, 1) PRIMARY KEY,
    MovieID INT NOT NULL,
    AudID INT NOT NULL,
    StartTime DATETIME NOT NULL,

    UNIQUE (AudID, StartTime), -- ensure no two showings start at the same time in the same auditorium
    FOREIGN KEY (MovieID) REFERENCES MOVIE(MovieID)
		ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (AudID) REFERENCES AUDITORIUM(AudID)
		ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE ADMISSION (
    AdmissionID INT IDENTITY(10000, 1) PRIMARY KEY,
    AdmissionType VARCHAR(20) NOT NULL UNIQUE,
    AdmissionPrice NUMERIC(6, 2) NOT NULL CHECK (AdmissionPrice >= 0)
);

CREATE TABLE [USER] (
    UserID INT IDENTITY(10000, 1) PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE, -- every user must have a unique email
    Phone CHAR(10) NULL,
    Birthday DATE NULL,
    PasswordHash VARCHAR(256) NOT NULL, -- supports 256-bit hash digests
    ProfilePicURL VARCHAR(200) NOT NULL
);

CREATE TABLE SCENECARD (
    SceneCardID INT IDENTITY(10000, 1) PRIMARY KEY,
    SceneCardNum CHAR(16) NOT NULL UNIQUE, -- a scene card number is always 16 digits. every scenecard must have a unique scenecardnum
    ExpirationDate DATE NOT NULL,
    ScenePoints INT NOT NULL CHECK (ScenePoints >= 0),
    UserID INT UNIQUE, -- only one scene card per user, and optional

    FOREIGN KEY (UserID) REFERENCES [USER](UserID)
		ON DELETE SET NULL ON UPDATE CASCADE -- a user deletion will not delete the card, instead detach it
);

CREATE TABLE [ORDER] (
    OrderID INT IDENTITY(10000, 1) PRIMARY KEY,
    OrderDateTime DATETIME NOT NULL,
    OrderChannel VARCHAR(50) NOT NULL CHECK (OrderChannel IN ('DESKTOP', 'MOBILE', 'BOX_OFFICE', 'KIOSK')),
    Discount NUMERIC(6, 2) NOT NULL CHECK (Discount >= 0),
	ScenePointsEarned INT NOT NULL CHECK (ScenePointsEarned >= 0), -- scene points are never fractional
    UserID INT, -- can be null (guest order)

    FOREIGN KEY (UserID) REFERENCES [USER](UserID)
		ON DELETE SET NULL ON UPDATE CASCADE -- preserve historical orders even if a user is deleted
);

CREATE TABLE PAYMENT (
    PaymentID INT IDENTITY(10000, 1) PRIMARY KEY,
    PaymentDateTime DATETIME NOT NULL,
    PaymentMethod VARCHAR(20) NOT NULL
	CHECK (PaymentMethod IN ('CREDIT', 'DEBIT', 'CASH', 'PAYPAL', 'GIFT_CARD')),
    OrderID INT NOT NULL,

    FOREIGN KEY (OrderID) REFERENCES [ORDER](OrderID)
		ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE TICKET (
    TicketID INT IDENTITY(10000, 1) PRIMARY KEY,
    AdmissionID INT NOT NULL,
	SeatID INT NOT NULL,
    OrderID INT NOT NULL,
	ShowingID INT NOT NULL,
	TicketStatus VARCHAR(20) NOT NULL
	DEFAULT 'VALID' CHECK (TicketStatus IN ('VALID', 'USED', 'REFUNDED', 'CANCELLED')),

	UNIQUE (ShowingID, SeatID), -- ensure no double booking for the same seat in the same showing
    FOREIGN KEY (AdmissionID) REFERENCES ADMISSION(AdmissionID)
		ON DELETE NO ACTION ON UPDATE CASCADE, -- prevent deleting admissions with links to tickets to avoid mass data loss
    FOREIGN KEY (SeatID) REFERENCES SEAT(SeatID)
		ON DELETE NO ACTION ON UPDATE CASCADE, -- prevent deleting seats with links to tickets to avoid mass data loss
    FOREIGN KEY (OrderID) REFERENCES [ORDER](OrderID)
		ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (ShowingID) REFERENCES SHOWING(ShowingID)
		ON DELETE NO ACTION ON UPDATE NO ACTION -- prevent cascading paths
);

CREATE TABLE CONCESSIONITEM (
    ItemID INT IDENTITY(10000, 1) PRIMARY KEY,
    ItemName VARCHAR(50) NOT NULL,
    ItemPrice NUMERIC(6, 2) NOT NULL CHECK (ItemPrice >= 0),
    Category VARCHAR(25) NOT NULL CHECK (Category IN ('POPCORN', 'DRINK', 'CANDY', 'SNACK')) -- enum used to avoid extra entity creation
);

CREATE TABLE CONCESSIONORDER (
    ItemID INT,
    OrderID INT,
    Quantity INT NOT NULL CHECK (Quantity > 0),

    PRIMARY KEY (ItemID, OrderID),
    FOREIGN KEY (ItemID) REFERENCES CONCESSIONITEM(ItemID)
		ON DELETE NO ACTION ON UPDATE CASCADE, -- prevent deleting concessionitems to preserve concessionorder history
    FOREIGN KEY (OrderID) REFERENCES [ORDER](OrderID)
		ON DELETE CASCADE ON UPDATE CASCADE
);
GO

CREATE TRIGGER trg_Movie_Delete ON MOVIE
INSTEAD OF DELETE AS
BEGIN
    -- Delete tickets first before movie (dependancy order)
    DELETE FROM TICKET
    WHERE ShowingID IN (
        SELECT ShowingID FROM SHOWING
        WHERE MovieID IN (SELECT MovieID FROM deleted)
    );

    -- Delete the movie
    DELETE FROM MOVIE
    WHERE MovieID IN (SELECT MovieID FROM deleted);
END;