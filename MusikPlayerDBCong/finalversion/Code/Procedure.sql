/* PROZEDUR 1: Hinzufuegen eines neuen Lied */
ALTER PROCEDURE "DBA"."NewSongOnly"(
    @SongID     integer,
    @AlbumID    integer,
    @ArtistID   integer,
    @SongTitle  char(256),
    @SongYear   date,
    @Genre      char(3),
    @Quality    smallint,
    @Price      money,
    @Views      integer,
    @Sales      integer)
AS
BEGIN
    /* Insert new song */
    INSERT INTO SONGS VALUES (@SongID, @AlbumID, @ArtistID, @SongTitle, @SongYear, @Genre, @Quality, @Price, @Views, @Sales)
    /* View the new song inserting data */
    SELECT * FROM SONGS WHERE SONGID = @SongID
END


/* PROZEDUR 2: Hinzufuegen eines neuen Lied mit einem neuen Album */
ALTER PROCEDURE "DBA"."NewSongAndAlbum"(
    @AlbumID    integer,
    @ArtistID   integer,
    @AlbumTitle char(256),
    @AlbumYear  date,
    @SongID     integer,
    @SongTitle  char(256),
    @SongYear   date,
    @Genre      char(3),
    @Quality    smallint,
    @Price      money,
    @Views      integer,
    @Sales      integer)
AS
BEGIN
    /* Insert new album */
    INSERT INTO ALBUMS VALUES(@AlbumID, @ArtistID, @AlbumTitle, @AlbumYear)
    /* Insert new song */
    INSERT INTO SONGS VALUES (@SongID, @AlbumID, @ArtistID, @SongTitle, @SongYear, @Genre, @Quality, @Price,@Views, @Sales)
    /* View the new album and song after inserting data */
    SELECT ALBUMS.ALBUMID, ALBUMS.ALBUMTITLE, SONGS.SONGID, SONGS.SONGTITLE, SONGS.SONGYEAR, SONGS.GENRE, SONGS.QUALITY, SONGS.PRICE
    FROM ALBUMS, SONGS
    WHERE ALBUMS.ALBUMID = @AlbumID AND SONGS.SONGID = @SongID
END


/* PROZEDUR 3: Hinzufuegen eines neuen Lied mit einem neuen Album und einem(r) neuen Interpret(in) */
ALTER PROCEDURE "DBA"."NewSongAndAlbumAndArtist"(
    @ArtistID   integer,
    @ArtistName char(40),
    @AlbumID    integer,
    @AlbumTitle char(256),
    @AlbumYear  date,
    @SongID     integer,
    @SongTitle  char(256),
    @SongYear   date,
    @Genre      char(3),
    @Quality    smallint,
    @Price      money,
    @Views      integer,
    @Sales      integer)
AS
BEGIN
    /* Insert new artist */
    INSERT INTO ARTISTS VALUES(@ArtistID, @ArtistName)
    /* Insert new album */
    INSERT INTO ALBUMS VALUES(@AlbumID, @ArtistID, @AlbumTitle, @AlbumYear)
    /* Insert new song */
    INSERT INTO SONGS VALUES (@SongID, @AlbumID, @ArtistID, @SongTitle, @SongYear, @Genre, @Quality, @Price, @Views, @Sales)
    /* View the new artist, album and song after inserting data */
    SELECT ARTISTS.ARTISTID, ARTISTS.NAME, ALBUMS.ALBUMID, ALBUMS.ALBUMTITLE, SONGS.SONGID, SONGS.SONGTITLE, SONGS.SONGYEAR, SONGS.GENRE, SONGS.QUALITY, SONGS.PRICE
    FROM ARTISTS, ALBUMS, SONGS
    WHERE ARTISTS.ARTISTID = @ArtistID AND ALBUMS.ALBUMID = @AlbumID AND SONGS.SONGID = @SongID
END


/* PROZEDUR 4: Aktualisierung des Preis eines Lieds */
ALTER PROCEDURE "DBA"."UpdatePrice"(
    @SongID     integer,
    @Price      money
)
AS
BEGIN
    /* Update song price */
    UPDATE SONGS
    SET PRICE = @price
    WHERE SONGID = @SongID

    /* View the updated songs */
    SELECT * FROM SONGS WHERE SONGID = @SongID
END


/* PROZEDUR 5: Loeschen eines Lieds */
ALTER PROCEDURE "DBA"."DeleteSong"(
    @SongID integer)
AS
BEGIN
    /* Delete selected song */
    DELETE FROM SONGS
    WHERE SONGID = @SongID

    /* View all songs */
    SELECT * FROM SONGS ORDER BY SONGID DESC
END



/* Prozedur 6: Update Views */
ALTER PROCEDURE "DBA"."UpdateViews"(
    @SongID     integer,
    @VIEWS      integer
)
AS
BEGIN
    /* Update song Views */
    UPDATE SONGS
    SET VIEWS = @VIEWS
    WHERE SONGID = @SongID

    /* View the updated songs */
    SELECT * FROM SONGS WHERE SONGID = @SongID
END



/* Prozedur 7:Lieder in einer Playlist */
ALTER PROCEDURE "DBA"."SongsInPlaylists"( @PlaylistID integer)
AS 
BEGIN
	SELECT SONGS.SONGTITLE,APPEAR_IN.PLAYLISTID
    FROM APPEAR_IN,SONGS
    WHERE APPEAR_IN.PLAYLISTID = @PlaylistID  AND APPEAR_IN.SONGID = SONGS.SONGID
END



/* Prozedur 8 Lieder in einer Bestellung */
ALTER PROCEDURE "DBA"."SongsInOrders"( @OrderID integer)
AS 
BEGIN
	SELECT SONGS.SONGTITLE,INCLUDE.ORDERID
    FROM INCLUDE,SONGS
    WHERE INCLUDE.ORDERID = @OrderID AND INCLUDE.SONGID = SONGS.SONGID
END