-- Query 1 --
-- Get total ticket sales for each movie
SELECT MAX(MOVIE.MovieName) AS MovieName, COUNT(TICKET.TicketID) AS TicketSales
FROM SHOWING
   INNER JOIN TICKET ON TICKET.ShowingID = SHOWING.ShowingID
   INNER JOIN MOVIE ON MOVIE.MovieID = SHOWING.MovieID
GROUP BY MOVIE.MovieID
ORDER BY TicketSales DESC, MovieName ASC;

-- Query 2 --
-- Get total ticket sales for each admission type
SELECT MAX(ADMISSION.AdmissionType) AS AdmissionType, COUNT(TICKET.TicketID) AS TicketSales
FROM ADMISSION
   INNER JOIN TICKET ON TICKET.AdmissionID = ADMISSION.AdmissionID
GROUP BY ADMISSION.AdmissionID
ORDER BY TicketSales DESC, AdmissionType ASC;

-- Query 3 --
-- Sort movies in order of highest to lowest grossing --
WITH
    -- CTE definition
    MOVIE_ADMISSIONS
    AS
    (
        SELECT MAX(ADMISSION.AdmissionType) AS AdmissionType,
            MAX(ADMISSION.AdmissionPrice) AS AdmissionPrice,
            MAX(MOVIE.MovieID) AS MovieID,
            MAX(MOVIE.MovieName) AS MovieName,
            COUNT(TICKET.TicketID) AS TicketSales
        FROM ADMISSION
            INNER JOIN TICKET ON TICKET.AdmissionID = ADMISSION.AdmissionID
            INNER JOIN SHOWING ON TICKET.ShowingID = SHOWING.ShowingID
            INNER JOIN MOVIE ON SHOWING.MovieID = MOVIE.MovieID
        GROUP BY ADMISSION.AdmissionID, MOVIE.MovieID
        -- Group by each unique combination of AdmissionID & MovieID
    )
-- Main query
SELECT MOVIE_ADMISSIONS.MovieID,
    MAX(MOVIE_ADMISSIONS.MovieName) AS MovieName,
    SUM(MOVIE_ADMISSIONS.TicketSales * MOVIE_ADMISSIONS.AdmissionPrice) AS TotalRevenue
FROM MOVIE_ADMISSIONS
GROUP BY MOVIE_ADMISSIONS.MovieID
ORDER BY TotalRevenue DESC;

-- Query 4 --
-- Update ScenePoints from an order

-- Before updating the points
SELECT SCENECARD.SceneCardID, SCENECARD.UserID, [USER].LastName,
    [USER].FirstName, SCENECARD.SceneCardNum, SCENECARD.ExpirationDate,
    SCENECARD.ScenePoints AS OLD_SCENE_POINTS
FROM SCENECARD
    INNER JOIN [USER] ON SCENECARD.UserID = [USER].UserID
ORDER BY SCENECARD.SceneCardID;

-- Precondition: User associated with this order must have a Scene+ card.
-- In other words, for this order, its UserID must be associated with an existing Scene+ card.
WITH ORDER_FOR_UPDATE AS (
	-- Order used to update a SceneCard
	SELECT [ORDER].OrderID, SCENECARD.UserID, [ORDER].ScenePointsEarned
	FROM [ORDER]
		INNER JOIN SCENECARD ON [ORDER].UserID = SCENECARD.UserID
	WHERE [ORDER].OrderID = 10002) -- An arbitrary order
UPDATE SCENECARD
	SET ScenePoints = ScenePoints + (
    	SELECT ORDER_FOR_UPDATE.ScenePointsEarned
	FROM ORDER_FOR_UPDATE)
	WHERE EXISTS (
		SELECT 1
    FROM ORDER_FOR_UPDATE)
    AND SCENECARD.UserID = (
    	SELECT ORDER_FOR_UPDATE.UserID
    FROM ORDER_FOR_UPDATE) -- A card holder indicated in the ORDER_FOR_UPDATE CTE
    AND GETDATE() <= SCENECARD.ExpirationDate;
	-- Only update when:
	-- There is a Scene card for the user associated with the order.
	-- SceneCard must not expire at the present moment.

-- After updating the points
SELECT SCENECARD.SceneCardID, SCENECARD.UserID, [USER].LastName,
    [USER].FirstName, SCENECARD.SceneCardNum, SCENECARD.ExpirationDate,
    SCENECARD.ScenePoints AS NEW_SCENE_POINTS
FROM SCENECARD
    INNER JOIN [USER] ON SCENECARD.UserID = [USER].UserID
ORDER BY SCENECARD.SceneCardID;

-- Query 5 --
-- Delete a user given their email address (unique attribute)
DELETE FROM [USER]
WHERE Email = 'doejohn@gmail.com';
SELECT * FROM [USER];

-- Query 6 --
-- Delete movies whose every showing is older than 30 days
DELETE FROM MOVIE
WHERE MovieID IN (
   SELECT MovieID
   FROM SHOWING
   GROUP BY MovieID
   HAVING MAX(StartTime) < DATEADD(DAY, -30, GETDATE())
);
SELECT * FROM MOVIE;

-- Query 7 --
-- Measure a theatre’s performance by tickets sold, concession items sold, ticket revenue, concession revenue, and total revenue
WITH OrderConcessions AS (
   SELECT
       co.OrderID,
       SUM(co.Quantity) AS TotalItems,
       SUM(ci.ItemPrice * co.Quantity) AS TotalConcessionRevenue
   FROM CONCESSIONORDER co
   JOIN CONCESSIONITEM ci ON ci.ItemID = co.ItemID
   GROUP BY co.OrderID
)
SELECT
   t.TheatreName,
   COUNT(tk.TicketID) AS TicketsSold,
   SUM(oc.TotalItems) AS ConcessionItemsSold,
   SUM(ad.AdmissionPrice) AS TicketRevenue,
   SUM(oc.TotalConcessionRevenue) AS ConcessionRevenue,
   SUM(ad.AdmissionPrice) + SUM(oc.TotalConcessionRevenue) AS TotalRevenue
FROM THEATRE t
LEFT JOIN AUDITORIUM a ON a.TheatreID = t.TheatreID
LEFT JOIN SHOWING s ON s.AudID = a.AudID
LEFT JOIN TICKET tk ON tk.ShowingID = s.ShowingID
                   AND tk.TicketStatus NOT IN ('REFUNDED', 'CANCELLED')
LEFT JOIN ADMISSION ad ON ad.AdmissionID = tk.AdmissionID
LEFT JOIN [ORDER] o ON o.OrderID = tk.OrderID
LEFT JOIN OrderConcessions oc ON oc.OrderID = o.OrderID
GROUP BY t.TheatreName
ORDER BY TotalRevenue DESC;

-- Query 8 --
-- Retrieve all tickets belonging to a user (ticket history)
SELECT
   tk.TicketID, tk.TicketStatus, m.MovieName, s.StartTime,
   t.TheatreName, aud.AudCode, seat.SeatCode,
   ad.AdmissionType, ad.AdmissionPrice
FROM [USER] u
JOIN [ORDER] o ON o.UserID = u.UserID
JOIN TICKET tk ON tk.OrderID = o.OrderID
JOIN SHOWING s ON s.ShowingID = tk.ShowingID
JOIN MOVIE m ON m.MovieID = s.MovieID
JOIN AUDITORIUM aud ON aud.AudID = s.AudID
JOIN THEATRE t ON t.TheatreID = aud.TheatreID
JOIN SEAT seat ON seat.SeatID = tk.SeatID
JOIN ADMISSION ad ON ad.AdmissionID = tk.AdmissionID
WHERE u.UserID = 10002
ORDER BY s.StartTime DESC;