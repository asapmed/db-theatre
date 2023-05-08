CREATE TABLE [person_general_information] (
	person_id int NOT NULL,
	first_name nvarchar(20) NOT NULL,
	last_name nvarchar(20) NOT NULL,
	sex_id int NOT NULL,
	date_of_birth date NOT NULL,
	location_of_birth_id int NOT NULL,
  CONSTRAINT PK_PERSON_GENERAL_INFORMATION PRIMARY KEY 
  (
  person_id
  ) 

)

CREATE TABLE [character] (
	character_id int NOT NULL,
	character_name nvarchar(max) NOT NULL,
	--amplua_of_character_id int NOT NULL,
	type_of_character_id int NOT NULL,
	performance_id int NOT NULL,
	sex_id int NOT NULL,
  CONSTRAINT [PK_CHARACTER] PRIMARY KEY 
  (
  character_id
  ) 

)

CREATE TABLE [show] (
	show_id int NOT NULL,
	show_date datetime2,
	show_attendance int NOT NULL,
	performance_id int NOT NULL,
  CONSTRAINT [PK_SHOW] PRIMARY KEY
  (
  show_id
  ) 

)

CREATE TABLE [theatre] (
	theatre_id int NOT NULL,
	theatre_name nvarchar(30) NOT NULL,
	theatre_capacity int NOT NULL,
	theatre_city_id int NOT NULL,
	theatre_address nvarchar(max) NOT NULL,
  CONSTRAINT [PK_THEATRE] PRIMARY KEY
  (
  theatre_id
  )

)

CREATE TABLE [actor_character_information] (
	actor_id int NOT NULL,
	character_id int NOT NULL,
	show_id int NOT NULL,
  CONSTRAINT [PK_ACTOR_CHARACTER_INFORMATION] PRIMARY KEY
  (
  actor_id,
  character_id,
  show_id
  ) 

)

CREATE TABLE [performance] (
	performance_id int NOT NULL,
	performance_name nvarchar(max) NOT NULL,
	theatre_id int,
	play_id int,
  CONSTRAINT [PK_PERFORMANCE] PRIMARY KEY
  (
  performance_id
  ) 

)

CREATE TABLE [achievement_actor] (
	actor_id int NOT NULL,
	nomination_id int NOT NULL,
	date_of_getting date NOT NULL,
	performance_id int NOT NULL,
  CONSTRAINT [PK_ACHIEVEMENT_ACTOR] PRIMARY KEY
  (
  actor_id,
  nomination_id,
  date_of_getting
  ) 

)

CREATE TABLE [sex] (
	sex_id int NOT NULL,
	sex nvarchar(10) NOT NULL,
  CONSTRAINT [PK_SEX] PRIMARY KEY 
  (
  sex_id
  ) 

)

CREATE TABLE [city] (
	city_id int NOT NULL,
	city_name nvarchar(30) NOT NULL,
	country_id int NOT NULL,
  CONSTRAINT [PK_CITY] PRIMARY KEY
  (
  city_id
  ) 

)

CREATE TABLE [country] (
	country_id int NOT NULL,
	country_name nvarchar(30) NOT NULL,
  CONSTRAINT [PK_COUNTRY] PRIMARY KEY
  (
  country_id
  ) 

)

CREATE TABLE [genres_performance] (
	genre_id int NOT NULL,
	performance_id int NOT NULL,
  CONSTRAINT [PK_GENRES_PERFORMANCE] PRIMARY KEY 
  (
 genre_id,
 performance_id
  ) 

)

CREATE TABLE [genres] (
	genre_id int NOT NULL,
	genre_name nvarchar(20) NOT NULL,
  CONSTRAINT [PK_GENRES] PRIMARY KEY
  (
  genre_id
  )

)

CREATE TABLE [creators_performance] (
	creator_id int NOT NULL,
	performance_id int NOT NULL,
  CONSTRAINT [PK_CREATORS_PERFORMANCE] PRIMARY KEY 
  (
  creator_id,
  performance_id
  ) 

)

CREATE TABLE [type_of_character] (
	type_of_character_id int NOT NULL,
	type_of_character_name nvarchar(20) NOT NULL,
  CONSTRAINT [PK_TYPE_OF_CHARACTER] PRIMARY KEY
  (
  type_of_character_id
  ) 

)

CREATE TABLE [nomination] (
	nomination_id int NOT NULL,
	nomination_name nvarchar(30) NOT NULL,
	achievement_id int NOT NULL,
  CONSTRAINT [PK_NOMINATION] PRIMARY KEY 
  (
  nomination_id
  ) 

)

CREATE TABLE [achievement] (
	achievement_id int NOT NULL,
	achievement_name nvarchar(30) NOT NULL,
  CONSTRAINT [PK_ACHIEVEMENT] PRIMARY KEY
  (
  achievement_id
  ) 

)

CREATE TABLE [play] (
	play_id int NOT NULL,
	play_name nvarchar(max) NOT NULL,
  CONSTRAINT [PK_PLAY] PRIMARY KEY 
  (
  play_id
  ) 

)

CREATE TABLE [creators_play] (
	person_id int NOT NULL,
	play_id int NOT NULL,
  CONSTRAINT [PK_CREATORS_PLAY] PRIMARY KEY 
  (
  person_id,
  play_id
  ) 

)

ALTER TABLE person_general_information
   ADD CONSTRAINT FK_sex_id FOREIGN KEY (sex_id)
      REFERENCES sex (sex_id)
      ON DELETE NO ACTION
;

ALTER TABLE achievement_actor
   ADD CONSTRAINT FK_actor_id FOREIGN KEY (actor_id)
      REFERENCES person_general_information (person_id)
      ON DELETE NO ACTION
;

ALTER TABLE achievement_actor
   ADD CONSTRAINT FK_nomination_id FOREIGN KEY (nomination_id)
      REFERENCES nomination (nomination_id)
      ON DELETE NO ACTION
;

ALTER TABLE nomination
   ADD CONSTRAINT FK_achievement_id FOREIGN KEY (achievement_id)
      REFERENCES achievement (achievement_id)
      ON DELETE NO ACTION
;

ALTER TABLE achievement_actor
   ADD CONSTRAINT FK_performance_id FOREIGN KEY (performance_id)
      REFERENCES performance (performance_id)
      ON DELETE NO ACTION
;

ALTER TABLE person_general_information
   ADD CONSTRAINT FK_location_of_birth_id FOREIGN KEY (location_of_birth_id)
      REFERENCES city (city_id)
      ON DELETE NO ACTION
;

ALTER TABLE actor_character_information
   ADD CONSTRAINT FK_actor2_id FOREIGN KEY (actor_id)
      REFERENCES person_general_information (person_id)
      ON DELETE NO ACTION
;

ALTER TABLE actor_character_information
   ADD CONSTRAINT FK_character2_id FOREIGN KEY (character_id)
      REFERENCES character (character_id)
      ON DELETE CASCADE
;

ALTER TABLE actor_character_information
   ADD CONSTRAINT FK_show2_id FOREIGN KEY (show_id)
      REFERENCES show (show_id)
      ON DELETE CASCADE
;

ALTER TABLE creators_performance
   ADD CONSTRAINT FK_creator_id FOREIGN KEY (creator_id)
      REFERENCES person_general_information (person_id)
      ON DELETE NO ACTION
;

ALTER TABLE creators_performance
   ADD CONSTRAINT FK_performance2_id FOREIGN KEY (performance_id)
      REFERENCES performance (performance_id)
      ON DELETE NO ACTION
;

ALTER TABLE creators_play
   ADD CONSTRAINT FK_person_id FOREIGN KEY (person_id)
      REFERENCES person_general_information (person_id)
      ON DELETE NO ACTION
;

ALTER TABLE creators_play
   ADD CONSTRAINT FK_play_id FOREIGN KEY (play_id)
      REFERENCES play (play_id)
      ON DELETE NO ACTION
;

ALTER TABLE theatre
   ADD CONSTRAINT FK_theatre_city_id FOREIGN KEY (theatre_city_id)
      REFERENCES city (city_id)
      ON DELETE NO ACTION
;

ALTER TABLE city
   ADD CONSTRAINT FK_country_id FOREIGN KEY (country_id)
      REFERENCES country (country_id)
      ON DELETE NO ACTION
;

ALTER TABLE character
   ADD CONSTRAINT FK_sex2_id FOREIGN KEY (sex_id)
      REFERENCES sex (sex_id)
      ON DELETE NO ACTION
;

ALTER TABLE character
   ADD CONSTRAINT FK_type_of_character_id FOREIGN KEY (type_of_character_id)
      REFERENCES type_of_character (type_of_character_id)
      ON DELETE NO ACTION
;

ALTER TABLE character
   ADD CONSTRAINT FK_performance3_id FOREIGN KEY (performance_id)
      REFERENCES performance (performance_id)
      ON DELETE NO ACTION
;

ALTER TABLE show
   ADD CONSTRAINT FK_performance4_id FOREIGN KEY (performance_id)
      REFERENCES performance (performance_id)
      ON DELETE NO ACTION
;

ALTER TABLE genres_performance
   ADD CONSTRAINT FK_genre_id FOREIGN KEY (genre_id)
      REFERENCES genres (genre_id)
      ON DELETE NO ACTION
;

ALTER TABLE genres_performance
   ADD CONSTRAINT FK_performance5_id FOREIGN KEY (performance_id)
      REFERENCES performance (performance_id)
      ON DELETE NO ACTION
;

ALTER TABLE performance
   ADD CONSTRAINT FK_theatre_id FOREIGN KEY (theatre_id)
      REFERENCES theatre (theatre_id)
      ON DELETE NO ACTION
;

ALTER TABLE performance
   ADD CONSTRAINT FK_play2_id FOREIGN KEY (play_id)
      REFERENCES play (play_id)
      ON DELETE NO ACTION
;