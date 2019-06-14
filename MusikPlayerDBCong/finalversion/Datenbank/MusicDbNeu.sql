/*==============================================================*/
/* DBMS name:      SAP SQL Anywhere 17                          */
/* Created on:     13.06.2019 01:39:20                          */
/*==============================================================*/


if exists(select 1 from sys.sysforeignkey where role='FK_ALBUMS_OWN_ARTISTS') then
    alter table ALBUMS
       delete foreign key FK_ALBUMS_OWN_ARTISTS
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_APPEAR_I_APPEAR_IN_SONGS') then
    alter table APPEAR_IN
       delete foreign key FK_APPEAR_I_APPEAR_IN_SONGS
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_APPEAR_I_APPEAR_IN_PLAYLIST') then
    alter table APPEAR_IN
       delete foreign key FK_APPEAR_I_APPEAR_IN_PLAYLIST
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_INCLUDE_INCLUDE_ORDERS') then
    alter table INCLUDE
       delete foreign key FK_INCLUDE_INCLUDE_ORDERS
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_INCLUDE_INCLUDE2_SONGS') then
    alter table INCLUDE
       delete foreign key FK_INCLUDE_INCLUDE2_SONGS
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_ORDERS_PLACE_USERS') then
    alter table ORDERS
       delete foreign key FK_ORDERS_PLACE_USERS
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_PLAYLIST_CREATE_USERS') then
    alter table PLAYLISTS
       delete foreign key FK_PLAYLIST_CREATE_USERS
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_SONGS_BELONG_TO_ARTISTS') then
    alter table SONGS
       delete foreign key FK_SONGS_BELONG_TO_ARTISTS
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_SONGS_CONTAIN_ALBUMS') then
    alter table SONGS
       delete foreign key FK_SONGS_CONTAIN_ALBUMS
end if;

drop index if exists ALBUMS.OWN_FK;

drop index if exists ALBUMS.ALBUMS_PK;

drop table if exists ALBUMS;

drop index if exists APPEAR_IN.APPEAR_IN2_FK;

drop index if exists APPEAR_IN.APPEAR_IN_FK;

drop index if exists APPEAR_IN.APPEAR_IN_PK;

drop table if exists APPEAR_IN;

drop index if exists ARTISTS.ARTISTS_PK;

drop table if exists ARTISTS;

drop index if exists INCLUDE.INCLUDE2_FK;

drop index if exists INCLUDE.INCLUDE_FK;

drop index if exists INCLUDE.INCLUDE_PK;

drop table if exists INCLUDE;

drop index if exists ORDERS.PLACE_FK;

drop index if exists ORDERS.ORDERS_PK;

drop table if exists ORDERS;

drop index if exists PLAYLISTS.CREATE_FK;

drop index if exists PLAYLISTS.PLAYLISTS_PK;

drop table if exists PLAYLISTS;

drop index if exists SONGS.CONTAIN_FK;

drop index if exists SONGS.BELONG_TO_FK;

drop index if exists SONGS.SONGS_PK;

drop table if exists SONGS;

drop index if exists USERS.USERS_PK;

drop table if exists USERS;

if exists(select 1 from sys.sysusertype where type_name='GENRE') then
   drop domain GENRE
end if;

if exists(select 1 from sys.sysusertype where type_name='QUALITY') then
   drop domain QUALITY
end if;

/*==============================================================*/
/* Domain: GENRE                                                */
/*==============================================================*/
create domain GENRE as char(3) 
     check (@column is null or (@column in ('Pop','Rap','Rck','Rnb','Bld','Alt')));

/*==============================================================*/
/* Domain: QUALITY                                              */
/*==============================================================*/
create domain QUALITY as smallint 
     check (@column is null or (@column in (128,320,192)));

/*==============================================================*/
/* Table: ALBUMS                                                */
/*==============================================================*/
create or replace table ALBUMS 
(
   ALBUMID              integer                        not null,
   ARTISTID             integer                        null,
   ALBUMTITLE           char(256)                      not null,
   ALBUMYEAR            date                           not null,
   constraint PK_ALBUMS primary key clustered (ALBUMID)
);

/*==============================================================*/
/* Index: ALBUMS_PK                                             */
/*==============================================================*/
create unique clustered index ALBUMS_PK on ALBUMS (
ALBUMID ASC
);

/*==============================================================*/
/* Index: OWN_FK                                                */
/*==============================================================*/
create index OWN_FK on ALBUMS (
ARTISTID ASC
);

/*==============================================================*/
/* Table: APPEAR_IN                                             */
/*==============================================================*/
create or replace table APPEAR_IN 
(
   SONGID               integer                        not null,
   PLAYLISTID           integer                        not null,
   constraint PK_APPEAR_IN primary key clustered (SONGID, PLAYLISTID)
);

/*==============================================================*/
/* Index: APPEAR_IN_PK                                          */
/*==============================================================*/
create unique clustered index APPEAR_IN_PK on APPEAR_IN (
SONGID ASC,
PLAYLISTID ASC
);

/*==============================================================*/
/* Index: APPEAR_IN_FK                                          */
/*==============================================================*/
create index APPEAR_IN_FK on APPEAR_IN (
SONGID ASC
);

/*==============================================================*/
/* Index: APPEAR_IN2_FK                                         */
/*==============================================================*/
create index APPEAR_IN2_FK on APPEAR_IN (
PLAYLISTID ASC
);

/*==============================================================*/
/* Table: ARTISTS                                               */
/*==============================================================*/
create or replace table ARTISTS 
(
   ARTISTID             integer                        not null,
   NAME                 char(40)                       not null,
   constraint PK_ARTISTS primary key clustered (ARTISTID)
);

/*==============================================================*/
/* Index: ARTISTS_PK                                            */
/*==============================================================*/
create unique clustered index ARTISTS_PK on ARTISTS (
ARTISTID ASC
);

/*==============================================================*/
/* Table: INCLUDE                                               */
/*==============================================================*/
create or replace table INCLUDE 
(
   ORDERID              integer                        not null,
   SONGID               integer                        not null,
   constraint PK_INCLUDE primary key clustered (ORDERID, SONGID)
);

/*==============================================================*/
/* Index: INCLUDE_PK                                            */
/*==============================================================*/
create unique clustered index INCLUDE_PK on INCLUDE (
ORDERID ASC,
SONGID ASC
);

/*==============================================================*/
/* Index: INCLUDE_FK                                            */
/*==============================================================*/
create index INCLUDE_FK on INCLUDE (
ORDERID ASC
);

/*==============================================================*/
/* Index: INCLUDE2_FK                                           */
/*==============================================================*/
create index INCLUDE2_FK on INCLUDE (
SONGID ASC
);

/*==============================================================*/
/* Table: ORDERS                                                */
/*==============================================================*/
create or replace table ORDERS 
(
   ORDERID              integer                        not null,
   USERID               integer                        null,
   PURCHASEDATE         date                           not null,
   SUM                  numeric(8,2)                   not null,
   constraint PK_ORDERS primary key clustered (ORDERID)
);

/*==============================================================*/
/* Index: ORDERS_PK                                             */
/*==============================================================*/
create unique clustered index ORDERS_PK on ORDERS (
ORDERID ASC
);

/*==============================================================*/
/* Index: PLACE_FK                                              */
/*==============================================================*/
create index PLACE_FK on ORDERS (
USERID ASC
);

/*==============================================================*/
/* Table: PLAYLISTS                                             */
/*==============================================================*/
create or replace table PLAYLISTS 
(
   PLAYLISTID           integer                        not null,
   USERID               integer                        null,
   PLAYLISTTITLE        char(20)                       not null,
   constraint PK_PLAYLISTS primary key clustered (PLAYLISTID)
);

/*==============================================================*/
/* Index: PLAYLISTS_PK                                          */
/*==============================================================*/
create unique clustered index PLAYLISTS_PK on PLAYLISTS (
PLAYLISTID ASC
);

/*==============================================================*/
/* Index: CREATE_FK                                             */
/*==============================================================*/
create index CREATE_FK on PLAYLISTS (
USERID ASC
);

/*==============================================================*/
/* Table: SONGS                                                 */
/*==============================================================*/
create or replace table SONGS 
(
   SONGID               integer                        not null,
   ALBUMID              integer                        null,
   ARTISTID             integer                        null,
   SONGTITLE            char(256)                      not null,
   SONGYEAR             date                           not null,
   GENRE                GENRE                          not null,
   QUALITY              QUALITY                        not null,
   PRICE                numeric(8,2)                   not null default 0
   	constraint CKC_PRICE_SONGS check (PRICE >= 0),
   VIEWS                integer                        null default 0
   	constraint CKC_VIEWS_SONGS check (VIEWS is null or (VIEWS >= 0)),
   SALES                integer                        null default 0
   	constraint CKC_SALES_SONGS check (SALES is null or (SALES >= 0)),
   constraint PK_SONGS primary key clustered (SONGID)
);

/*==============================================================*/
/* Index: SONGS_PK                                              */
/*==============================================================*/
create unique clustered index SONGS_PK on SONGS (
SONGID ASC
);

/*==============================================================*/
/* Index: BELONG_TO_FK                                          */
/*==============================================================*/
create index BELONG_TO_FK on SONGS (
ARTISTID ASC
);

/*==============================================================*/
/* Index: CONTAIN_FK                                            */
/*==============================================================*/
create index CONTAIN_FK on SONGS (
ALBUMID ASC
);

/*==============================================================*/
/* Table: USERS                                                 */
/*==============================================================*/
create or replace table USERS 
(
   USERID               integer                        not null,
   USERNAME             char(30)                       not null,
   PAYMENTINFO          char(256)                      null,
   constraint PK_USERS primary key clustered (USERID)
);

/*==============================================================*/
/* Index: USERS_PK                                              */
/*==============================================================*/
create unique clustered index USERS_PK on USERS (
USERID ASC
);

alter table ALBUMS
   add constraint FK_ALBUMS_OWN_ARTISTS foreign key (ARTISTID)
      references ARTISTS (ARTISTID)
      on update restrict
      on delete restrict;

alter table APPEAR_IN
   add constraint FK_APPEAR_I_APPEAR_IN_SONGS foreign key (SONGID)
      references SONGS (SONGID)
      on update restrict
      on delete restrict;

alter table APPEAR_IN
   add constraint FK_APPEAR_I_APPEAR_IN_PLAYLIST foreign key (PLAYLISTID)
      references PLAYLISTS (PLAYLISTID)
      on update restrict
      on delete restrict;

alter table INCLUDE
   add constraint FK_INCLUDE_INCLUDE_ORDERS foreign key (ORDERID)
      references ORDERS (ORDERID)
      on update restrict
      on delete restrict;

alter table INCLUDE
   add constraint FK_INCLUDE_INCLUDE2_SONGS foreign key (SONGID)
      references SONGS (SONGID)
      on update restrict
      on delete restrict;

alter table ORDERS
   add constraint FK_ORDERS_PLACE_USERS foreign key (USERID)
      references USERS (USERID)
      on update restrict
      on delete restrict;

alter table PLAYLISTS
   add constraint FK_PLAYLIST_CREATE_USERS foreign key (USERID)
      references USERS (USERID)
      on update restrict
      on delete restrict;

alter table SONGS
   add constraint FK_SONGS_BELONG_TO_ARTISTS foreign key (ARTISTID)
      references ARTISTS (ARTISTID)
      on update restrict
      on delete restrict;

alter table SONGS
   add constraint FK_SONGS_CONTAIN_ALBUMS foreign key (ALBUMID)
      references ALBUMS (ALBUMID)
      on update restrict
      on delete restrict;

