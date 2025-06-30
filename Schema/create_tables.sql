-- Users table
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Artists table
CREATE TABLE artists (
    artist_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    bio TEXT,
    country VARCHAR(50)
);

-- Albums table
CREATE TABLE albums (
    album_id SERIAL PRIMARY KEY,
    artist_id INTEGER REFERENCES artists(artist_id),
    title VARCHAR(100) NOT NULL,
    release_date DATE,
    cover_url VARCHAR(255)
);

-- Tracks table
CREATE TABLE tracks (
    track_id SERIAL PRIMARY KEY,
    album_id INTEGER REFERENCES albums(album_id),
    title VARCHAR(100) NOT NULL,
    duration INTEGER, -- in seconds
    track_number INTEGER,
    audio_url VARCHAR(255),
    play_count INTEGER DEFAULT 0
);

-- Genres table
CREATE TABLE genres (
    genre_id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL
);

-- Track-Genre many-to-many
CREATE TABLE track_genres (
    track_id INTEGER REFERENCES tracks(track_id),
    genre_id INTEGER REFERENCES genres(genre_id),
    PRIMARY KEY (track_id, genre_id)
);

-- Playlists table
CREATE TABLE playlists (
    playlist_id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(user_id),
    name VARCHAR(100) NOT NULL,
    is_collaborative BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Playlist-Tracks many-to-many
CREATE TABLE playlist_tracks (
    playlist_id INTEGER REFERENCES playlists(playlist_id),
    track_id INTEGER REFERENCES tracks(track_id),
    position INTEGER,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (playlist_id, track_id)
);

-- User follows artist
CREATE TABLE follows (
    user_id INTEGER REFERENCES users(user_id),
    artist_id INTEGER REFERENCES artists(artist_id),
    followed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, artist_id)
);

-- Listening history
CREATE TABLE listening_history (
    history_id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(user_id),
    track_id INTEGER REFERENCES tracks(track_id),
    listened_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Subscriptions (optional)
CREATE TABLE subscriptions (
    subscription_id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(user_id),
    plan VARCHAR(50) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE
);