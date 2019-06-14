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
