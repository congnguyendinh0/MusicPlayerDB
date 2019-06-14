/* FUER PROZEDUR 1: Hinzufuegen eines neuen Lied */
EXECUTE NewSongOnly
	@SongID = 37,
	@AlbumID  = 30,
	@ArtistID = 30,
	@SongTitle = 'wyz',
	@SongYear = '1988-01-01',
	@Genre  = 'Alt',
	@Quality = 320,
	@Price = 3,
	@Views = 1,
	@Sales = 2;


/* FUER PROZEDUR 2: Hinzufuegen eines neuen Lied mit einem neuen Album */
EXECUTE NewSongAndAlbum
	@AlbumID  = 30,
	@ArtistID = 30,
	@AlbumTitle = 'WYZ',
	@AlbumYear  = '2019-07-06',
	@SongID = 37,
	@SongTitle = 'wyz',
	@SongYear = '1988-01-01',
	@Genre  = 'Alt',
	@Quality = 320,
	@Price = 3,
	@Views = 1,
	@Sales = 2;


/* FUER PROZEDUR 3: Hinzufuegen eines neuen Lied mit einem neuen Album und einem(r) neuen Interpret(in) */
EXECUTE NewSongAndAlbumAndArtist
	@ArtistID = 30,
	@ArtistName = 'WYZ',
	@AlbumID  = 30,
	@AlbumTitle = 'WYZ',
	@AlbumYear  = '2019-07-06',
	@SongID = 37,
	@SongTitle = 'wyz',
	@SongYear = '1988-01-01',
	@Genre  = 'Alt',
	@Quality = 320,
	@Price = 3,
	@Views = 1,
	@Sales = 2;


/* FUER PROZEDUR 4: Aktualisierung des Preis eines Lieds */
EXECUTE UpdatePrice @SongID = 37, @Price = 1;


/* FUER PROZEDUR 5: Loeschen eines Lieds */
EXECUTE DeleteSong @SongID = 37;
    
    
/* FUER PROZEDUR 6: Fuer einen Song die Aufrufe ändern */
Execute UpdateViews @SongID = 11, @VIEWS = 2;


/* FUER PROZEDUR 7: Lieder in einer Playlist */
Execute SongsInPlaylists @PlaylistID = 1;


/* FUER PROZEDUR 8: Lieder in einer Bestellung */
Execute SongsInOrders @OrderID = 1;