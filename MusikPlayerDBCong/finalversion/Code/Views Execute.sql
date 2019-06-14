/* SICHT 1: Top 5 meist gepielte Lieder */
SELECT * FROM "DBA"."5MostPlayedSongs";


/* SICHT 2: Alle Alben im Jahr 2019 */
SELECT * FROM "DBA"."AlbumsInYear2019";


/* SICHT 3: Alle Pop-Lieder */
SELECT * FROM "DBA"."AllPopSongs";


/* SICHT 4: Noch nie gepielte Lieder */
SELECT * FROM "DBA"."NeverPlayedSongs";


/* SICHT 5: Alle Lieder mit bester Qualitaet (320 kbps) */
SELECT * FROM "DBA"."SongQuality320kbps";


/* SICHT 6: Kunden, die sich im letzten Jahr Bestellungen aufgeben */
SELECT * FROM "DBA"."UsersHaveOrdersLastYear";


/* SICHT 7: Lieder, die noch nie gekauft sind */
SELECT * FROM "DBA"."SongNeverBought";