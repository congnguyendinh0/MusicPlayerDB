/* FUNKTION 1: Kunde mit der hoechsten Anzahl der Bestellung */
ALTER FUNCTION "DBA"."CustomerWithMostOrders"()
RETURNS CHAR(30)
BEGIN
	DECLARE CustomerName CHAR(30);

    SET CustomerName = (
        SELECT USERNAME
        FROM USERS
        WHERE USERID = (
            SELECT USERID
            FROM (SELECT USERID, COUNT(*) AS NumberOfOrders FROM ORDERS GROUP BY USERID) AS NewTable1
            WHERE NewTable1.NumberOfOrders = (SELECT MAX(n) FROM (SELECT USERID, COUNT(*) AS n FROM ORDERS GROUP BY USERID) AS NewTable2)
        )
    );

	RETURN CustomerName;
END


/* FUNKTION 2: Das meist gekaufte Lied */
ALTER FUNCTION "DBA"."SongBestSeller"()
RETURNS CHAR(256)
BEGIN
	DECLARE SongName CHAR(256);

    SET SongName = (SELECT SONGTITLE FROM SONGS WHERE SALES = (SELECT MAX(SALES) FROM SONGS));

	RETURN SongName;
END


/* FUNKTION 3: Summe aller Bestellung eines(r) ausgewaehlten Kunde(in) */
ALTER FUNCTION "DBA"."SumOfOrders"(@UserID INTEGER)
RETURNS MONEY
BEGIN
	DECLARE SumOrder MONEY;

	SET SumOrder = (
        SELECT SUM(ORDERS.SUM)
        FROM ORDERS 
        WHERE USERID = @UserID
    );

	RETURN SumOrder;
END


/* FUNKTION 4: Durchschnittliche Ausgabe eines(r) ausgewaehlten Kunde(in) */
ALTER FUNCTION "DBA"."AverageOrders"(@UserID INTEGER)
RETURNS MONEY
BEGIN
	DECLARE AvgOrder MONEY;
    
	SET AvgOrder = (
        (SELECT SUM(ORDERS.SUM) FROM ORDERS WHERE USERID = @UserID)
        /
        (SELECT COUNT(*) FROM ORDERS WHERE USERID = @UserID)
    );

	RETURN AvgOrder;
END