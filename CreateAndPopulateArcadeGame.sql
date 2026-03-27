/* CSC6302 Database Principles
	Unit Two: Basic SQL
    Professor Minton
*/
DROP DATABASE IF EXISTS ArcadeGames;
CREATE DATABASE ArcadeGames;

USE ArcadeGames;

/* In thiis database creation script, we have foreign keys we need to worry about. We cannot insert data into a table if the data its foreign key references has
	not been inserted into its source table yet. It's often easier to look at your database design, and create your tables in this way. Start with the the tables that
    stand on their own (meaning they do not reference any other table) and build out from there. */

-- We are using ids in this tables for primary keys, and because we just want a way to uniquely identify a row, we are going to let the database engine
-- give us a unique id. Just incrementing the value of id with each insert is good for our purposes.
CREATE TABLE IF NOT EXISTS Game (
Id int not null auto_increment,
GameName varchar(200) not null,
DeveloperName varchar(200) not null,
ReleaseDate Date not null,
LastMaintenanceWindow DateTime,
PRIMARY KEY (Id)
);

-- Note that I am inserting into the Date column and the DateTime column with strings, even thought they are using the Date data type. The format here is important.
-- Date uses the format 'YYYY-MM-DD' 
-- DateTime uses the format 'YYYY-MM-DD hh:mm:ss:xxxxxx'
INSERT INTO Game (GameName, DeveloperName, ReleaseDate, LastMaintenanceWindow) VALUES ("Pac-man", "NAMCO", "1980-04-01", "2022-01-30 4:12:36" );
INSERT INTO Game (GameName, DeveloperName, ReleaseDate, LastMaintenanceWindow) VALUES ("Space Invaders", "Taiito", "1978-05-22", "2020-07-08 8:32:56" );
INSERT INTO Game (GameName, DeveloperName, ReleaseDate, LastMaintenanceWindow) VALUES ("Street Fighter", "Capcom", "1991-11-24", "2022-01-30 4:12:36" );
INSERT INTO Game (GameName, DeveloperName, ReleaseDate, LastMaintenanceWindow) VALUES ("Donkey Kong", "Nintendo", "1981-10-21", "2020-07-08 8:32:56" );
INSERT INTO Game (GameName, DeveloperName, ReleaseDate, LastMaintenanceWindow) VALUES ("Asteroids", "Atari", "1979-08-04", "2022-01-15 7:34:21" );
INSERT INTO Game (GameName, DeveloperName, ReleaseDate, LastMaintenanceWindow) VALUES ("Defender", "Taiito", "1981-06-23", "2022-01-15 7:34:21" );
INSERT INTO Game (GameName, DeveloperName, ReleaseDate, LastMaintenanceWindow) VALUES ("Centipede", "Atari", "1980-12-12", "2022-01-30 4:12:36" );

-- Note that this table is allowing nulls. A player does not have to configure their favorite game.
CREATE TABLE IF NOT EXISTS Player (
Id int not null auto_increment,
UserName varchar(200) not null,
FavoriteGame int,
PRIMARY KEY (Id)
);

INSERT INTO Player (UserName, FavoriteGame) VALUES ("WAM", 2);
INSERT INTO Player (UserName, FavoriteGame) VALUES ("ZAK", 4);
INSERT INTO Player (UserName, FavoriteGame) VALUES ("JJH", 3);
INSERT INTO Player (UserName, FavoriteGame) VALUES ("SAA", 5);
INSERT INTO Player (UserName, FavoriteGame) VALUES ("MJM", 6);
INSERT INTO Player (UserName, FavoriteGame) VALUES ("EAB", 7);
INSERT INTO Player (UserName) VALUES ("ROS");
INSERT INTO Player (UserName) VALUES ("MOM");
INSERT INTO Player (UserName) VALUES ("DAD");
INSERT INTO Player (UserName) VALUES ("LED");

/* The Score table has two foreign keys. One references data in the Game tabe, and the other references data in the Player data. This is why we:
 1. Created Game and Player before Score
 2. Instered data into Game and Player before inserting data into Score */
CREATE TABLE IF NOT EXISTS Score (
Id int not null auto_increment,
GameId int not null,
PlayerId int not null,
Score int not null,
GameDate DateTime not null,
PRIMARY KEY(Id),
 Foreign Key (GameId) references Game (Id),
 Foreign Key (PlayerId) references Player (Id)
);

-- To get the correct data from the Game and Player tables, I used the two commened out SQL queries below. There
-- are more advanced SQL options we will get into later in the course to simplify what is a tedious process. 
-- Using an application is also another great way to speed up this sort of data insertion, and we will talk about that as well.
-- For now, its tedious.

SELECT *
FROM Game;

SELECT *
FROM Player;

INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (1,1,10035,"2022-01-30 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (2,1,363456,"2022-02-03 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (3,1,10345675,"2022-01-22 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (4,1,10124035,"2022-01-21 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (5,1,576767,"2022-01-15 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (6,1,23540035,"2022-01-19 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (7,1,13563635,"2022-01-30 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (1,2,879,"2022-01-02 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (2,2,1090035,"2022-01-04 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (3,2,1234124,"2022-01-18 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (4,2,98045634,"2022-01-21 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (5,2,3245457,"2022-01-18 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (6,2,4574567,"2022-01-04 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (7,2,10435,"2022-01-19 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (1,3,7589769,"2022-01-22 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (2,3,345345,"2022-01-22 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (3,3,10054635,"2022-01-23 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (4,3,457658,"2022-01-07 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (5,3,4567457,"2022-01-11 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (6,3,46575678,"2022-01-12 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (7,3,1023035,"2022-01-13 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (1,4,1035465,"2022-01-13 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (2,4,5678679,"2022-01-14 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (3,4,234325,"2022-01-05 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (4,4,65836,"2022-01-14 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (5,4,234523576,"2022-01-15 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (6,4,45734,"2022-01-16 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (7,4,2635035,"2022-01-17 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (1,5,24645767,"2022-01-04 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (2,5,235432,"2022-01-01 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (3,5,4570035,"2022-01-26 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (4,5,898790,"2022-01-17 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (5,5,456354,"2022-01-16 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (6,5,894567547,"2022-01-04 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (7,5,3545767,"2022-01-05 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (1,6,45766457,"2022-01-06 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (2,6,356546546,"2022-01-07 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (3,6,2352345,"2022-01-08 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (4,6,4567658,"2022-01-09 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (5,6,5789769,"2022-01-10 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (6,6,7698769,"2022-01-11 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (7,6,4467645,"2022-01-12 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (1,7,103455,"2022-01-13 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (2,7,12341,"2022-01-14 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (3,7,13456767,"2022-01-15 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (4,7,68758,"2022-01-16 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (5,7,45675678,"2022-01-17 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (6,7,134250035,"2022-01-18 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (7,7,325325,"2022-01-19 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (1,8,123523035,"2022-01-20 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (2,8,1234123,"2022-01-21 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (3,8,12412,"2022-01-22 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (4,8,7877698,"2022-01-23 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (5,8,4567456,"2022-01-24 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (6,8,345345,"2022-01-25 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (7,8,1454035,"2022-01-26 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (1,9,245435435,"2022-01-27 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (2,9,345435345,"2022-01-28 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (3,9,345241,"2022-01-29 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (4,9,123124,"2022-01-20 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (5,9,1243153,"2022-01-29 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (6,9,1354325,"2022-01-29 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (7,9,235325,"2022-01-15 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (1,10,12351463,"2022-01-16 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (2,10,5678758,"2022-01-02 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (3,10,568567,"2022-01-03 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (4,10,325674,"2022-01-04 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (5,10,43661241,"2022-01-05 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (6,10,14235,"2022-01-06 4:12:36");
INSERT INTO SCORE(GameId,PlayerId, Score, GameDate) VALUES (7,10,3463456,"2022-01-07 4:12:36");
