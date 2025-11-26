
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE content (
    content_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    release_year INTEGER,
    duration_minutes INTEGER,
    content_type VARCHAR(20) CHECK (content_type IN ('movie', 'series')),
    age_rating VARCHAR(10),
    imdb_rating DECIMAL(3,1),
    kinopoisk_rating DECIMAL(3,1),
    average_rating DECIMAL(3,1),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE genres (
    genre_id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE actors (
    actor_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);


CREATE TABLE content_ratings (
    rating_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    content_id INTEGER NOT NULL,
    rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 10),
    review_text TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(user_id, content_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (content_id) REFERENCES content(content_id)
);


CREATE TABLE user_favorites (
    user_id INTEGER NOT NULL,
    content_id INTEGER NOT NULL,
    added_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, content_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (content_id) REFERENCES content(content_id)
);

CREATE TABLE user_history (
    user_id INTEGER NOT NULL,
    content_id INTEGER NOT NULL,
    watch_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    progress INTEGER DEFAULT 0,
    PRIMARY KEY (user_id, content_id, watch_date),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (content_id) REFERENCES content(content_id)
);

CREATE TABLE content_genres (
    content_id INTEGER NOT NULL,
    genre_id INTEGER NOT NULL,
    PRIMARY KEY (content_id, genre_id),
    FOREIGN KEY (content_id) REFERENCES content(content_id),
    FOREIGN KEY (genre_id) REFERENCES genres(genre_id)
);

CREATE TABLE content_actors (
    content_id INTEGER NOT NULL,
    actor_id INTEGER NOT NULL,
    role_name VARCHAR(100),
    PRIMARY KEY (content_id, actor_id),
    FOREIGN KEY (content_id) REFERENCES content(content_id),
    FOREIGN KEY (actor_id) REFERENCES actors(actor_id)
);