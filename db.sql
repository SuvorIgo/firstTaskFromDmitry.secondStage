CREATE TABLE Films(
	film_id SERIAL PRIMARY KEY NOT NULL,
	name VARCHAR(200) NOT NULL,
	short_description TEXT NOT NULL, -- короткое описание 
	description TEXT NOT NULL, -- описание
	year_production DATE NOT NULL,
	country VARCHAR(60) NOT NULL,
	viewing_age SMALLINT NOT NULL, -- разрешаемый возраст зрителя
	duration SMALLINT NOT NULL, -- длительность фильма
	movie_rating NUMERIC(2,1) NOT NULL CHECK(movie_rating > 0 AND movie_rating < 11)
);

CREATE TABLE Persons(
	person_id SERIAL PRIMARY KEY NOT NULL,
	role VARCHAR(20) NOT NULL -- роль в создании фильма
		CHECK(role IN ('Режиссер', 'Сценарий', 'Продюсер',
					   'Оператор', 'Композитор', 'Художник',
					   'Монтаж', 'В главных ролях', 'Роли дублировали')),
	name VARCHAR(30) NOT NULL,
	surname VARCHAR(30) NOT NULL,
	id_film INTEGER NOT NULL,
	FOREIGN KEY (id_film) REFERENCES Films(film_id) ON UPDATE CASCADE
);

CREATE TABLE Users(
	user_id SERIAL PRIMARY KEY NOT NULL,
	name VARCHAR(50),
	surname VARCHAR(50),
	profile_picture TEXT, -- информация с path до загружаемой картинки
	e_mail VARCHAR(256) NOT NULL UNIQUE
);

CREATE TABLE Films_additional_info(
	filmAdInfo_id SERIAL PRIMARY KEY NOT NULL REFERENCES Films(film_id),
	subtitles VARCHAR(50),
	video_quality VARCHAR(50) NOT NULL,
	slogan TEXT NOT NULL,
	budget MONEY NOT NULL,
	marketing MONEY,
	fees_in_country MONEY NOT NULL, -- сборы в стране продакшена
	fees_in_world MONEY,
	premiere_in_audiences_country DATE, -- премьера в стране зрителя
	premiere_world DATE NOT NULL,
	dvd_release DATE,
	rating_MPAA VARCHAR(5) NULL
);

CREATE TABLE Audio_tracks(
	audiotrack_id SERIAL PRIMARY KEY NOT NULL,
	name VARCHAR(60), -- наименование языка
	id_film INTEGER NOT NULL,
	FOREIGN KEY (id_film) REFERENCES Films(film_id) ON UPDATE CASCADE
);

CREATE TABLE Evaluations(
	evaluation_id SERIAL PRIMARY KEY NOT NULL,
	score SMALLINT NOT NULL CHECK(score > 0 AND score <= 10), -- оценка пользователя
	id_user INTEGER NOT NULL,
	id_film INTEGER NOT NULL,
	FOREIGN KEY (id_user) REFERENCES Users(user_id) ON UPDATE CASCADE,
	FOREIGN KEY (id_film) REFERENCES Films(film_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Genres(
	genre_id SERIAL PRIMARY KEY NOT NULL,
	name VARCHAR(20) NOT NULL,
	id_film INTEGER NOT NULL,
	FOREIGN KEY (id_film) REFERENCES Films(film_id) ON UPDATE CASCADE
);

CREATE TABLE Premieres(
	premiere_id SERIAL PRIMARY KEY NOT NULL,
	date DATE,
	country VARCHAR(60) NOT NULL,
	id_film INTEGER NOT NULL,
	FOREIGN KEY (id_film) REFERENCES Films(film_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Reviews(
	review_id SERIAL PRIMARY KEY NOT NULL,
	id_user INTEGER NOT NULL,
	date_publication DATE NOT NULL,
	title VARCHAR(100) NOT NULL,
	text_review TEXT NOT NULL,
	id_film INTEGER NOT NULL,
	FOREIGN KEY (id_user) REFERENCES Users(user_id) ON UPDATE CASCADE,
	FOREIGN KEY (id_film) REFERENCES Films(film_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Images(
	iamge_id SERIAL PRIMARY KEY NOT NULL,
	category VARCHAR(20) NOT NULL,
	image TEXT NOT NULL, -- информация с path до image на сервере
	id_film INTEGER NOT NULL,
	FOREIGN KEY (id_film) REFERENCES Films(film_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Rewards(
	reward_id SERIAL PRIMARY KEY NOT NULL,
	film_award VARCHAR(100) NOT NULL, -- наименование премии, например 'Оскар'
	nomination VARCHAR(200) NOT NULL,
	id_film INTEGER NOT NULL,
	FOREIGN KEY (id_film) REFERENCES Films(film_id) ON UPDATE CASCADE
);

CREATE TABLE Trailers(
	trailer_id SERIAL PRIMARY KEY NOT NULL,
	date_publication DATE NOT NULL,
	name VARCHAR(100) NOT NULL,
	video TEXT NOT NULL, -- информация с path до video на сервере
	id_film INTEGER NOT NULL,
	FOREIGN KEY (id_film) REFERENCES Films(film_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Viewers(
	viewer_id SERIAL PRIMARY KEY NOT NULL,
	country VARCHAR(60) NOT NULL,
	strength INTEGER,
	id_film INTEGER NOT NULL,
	FOREIGN KEY (id_film) REFERENCES Films(film_id) ON UPDATE CASCADE ON DELETE CASCADE
);