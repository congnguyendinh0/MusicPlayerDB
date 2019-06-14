/* SICHT 1: Top 5 meist gepielte Lieder */
ALTER VIEW "DBA"."5MostPlayedSongs"
AS
SELECT TOP 5 *
FROM SONGS
ORDER BY VIEWS DESC;


/* SICHT 2: Alle Alben im Jahr 2019 */
ALTER VIEW "DBA"."AlbumsInYear2019"
AS
SELECT *
FROM ALBUMS
WHERE YEAR(ALBUMYEAR) = 2019;


/* SICHT 3: Alle Pop-Lieder */
ALTER VIEW "DBA"."AllPopSongs"
AS
SELECT *
FROM SONGS
WHERE GENRE = 'Pop';


/* SICHT 4: Noch nie gepielte Lieder */
ALTER VIEW "DBA"."NeverPlayedSongs"
AS
SELECT *
FROM SONGS
WHERE VIEWS IS NULL OR VIEWS = 0;

/* SICHT 5: Alle Lieder mit bester Qualitaet (320 kbps) */
ALTER VIEW "DBA"."SongQuality320kbps"
AS
SELECT * FROM Songs WHERE Quality = '320';


/* SICHT 6: Kunden, die sich im letzten Jahr Bestellungen aufgeben */
ALTER VIEW "DBA"."UsersHaveOrdersLastYear"
AS
SELECT DISTINCT USERS.USERID, USERS.USERNAME
FROM USERS, ORDERS
WHERE USERS.USERID = ORDERS.USERID AND year(ORDERS.PURCHASEDATE) = (year(current date) - 1);


/* SICHT 7: Lieder, die noch nie gekauft sind */
ALTER VIEW "DBA"."SongNeverBought"
AS
SELECT SONGTITLE, SALES
FROM SONGS
WHERE SALES IS NULL OR SALES = 0;

