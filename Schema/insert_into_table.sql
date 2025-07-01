-- Insert Genres
INSERT INTO genres (name) VALUES
('Pop'),
('Rock'),
('Hip-Hop'),
('Jazz'),
('Classical');

-- Insert Users 
INSERT INTO users (username, email, password_hash) VALUES
('musicfan1', 'musicfan1@example.com', 'hash_pw1'),
('beatlover', 'beatlover@example.com', 'hash_pw2'),
('jazzcat', 'jazzcat@example.com', 'hash_pw3');

-- Insert Artists 
INSERT INTO artists (name, bio, country) VALUES
('Taylor Swift', 'American singer-songwriter.', 'USA'),
('The Beatles', 'Legendary English rock band.', 'UK'),
('Drake', 'Canadian rapper and singer.', 'Canada'),
('Adele', 'English singer-songwriter.', 'UK'),
('Miles Davis', 'Influential jazz trumpeter.', 'USA');

-- Insert Albums 
INSERT INTO albums (artist_id, title, release_date, cover_url) VALUES
(1, '1989', '2014-10-27', 'https://example.com/1989.jpg'),
(2, 'Abbey Road', '1969-09-26', 'https://example.com/abbeyroad.jpg'),
(3, 'Scorpion', '2018-06-29', 'https://example.com/scorpion.jpg'),
(4, '25', '2015-11-20', 'https://example.com/25.jpg'),
(5, 'Kind of Blue', '1959-08-17', 'https://example.com/kindofblue.jpg');

-- Insert Tracks 
INSERT INTO tracks (album_id, title, duration, track_number, audio_url, play_count) VALUES
(1, 'Blank Space', 231, 2, 'https://example.com/blankspace.mp3', 1000),
(1, 'Style', 231, 3, 'https://example.com/style.mp3', 900),
(2, 'Come Together', 259, 1, 'https://example.com/cometogether.mp3', 1200),
(2, 'Something', 182, 2, 'https://example.com/something.mp3', 1100),
(3, 'God\s Plan', 198, 1, 'https://example.com/godsplan.mp3', 1500),
(4, 'Hello', 295, 1, 'https://example.com/hello.mp3', 1300),
(5, 'So What', 545, 1, 'https://example.com/sowhat.mp3', 800);

-- Insert Track Genres
INSERT INTO track_genres (track_id, genre_id) VALUES
(1, 1), -- Blank Space: Pop
(2, 1), -- Style: Pop
(3, 2), -- Come Together: Rock
(4, 2), -- Something: Rock
(5, 3), -- God's Plan: Hip-Hop
(6, 1), -- Hello: Pop
(7, 4); -- So What: Jazz

-- Insert Playlists
INSERT INTO playlists (user_id, name, is_collaborative) VALUES
(1, 'Top Pop Hits', FALSE),
(2, 'Classic Rock', FALSE),
(3, 'Jazz Essentials', FALSE);

-- Insert Playlist Tracks
INSERT INTO playlist_tracks (playlist_id, track_id, position) VALUES
(1, 1, 1),
(1, 2, 2),
(1, 6, 3),
(2, 3, 1),
(2, 4, 2),
(3, 7, 1);

-- Insert Follows
INSERT INTO follows (user_id, artist_id) VALUES
(1, 1), -- musicfan1 follows Taylor Swift
(2, 2), -- beatlover follows The Beatles
(3, 5); -- jazzcat follows Miles Davis

-- Insert Listening History
INSERT INTO listening_history (user_id, track_id, listened_at) VALUES
(1, 1, '2024-06-01 09:00:00'),
(1, 2, '2024-06-01 09:05:00'),
(2, 3, '2024-06-01 10:00:00'),
(2, 4, '2024-06-01 10:10:00'),
(3, 7, '2024-06-01 11:00:00');

-- Insert Subscriptions
INSERT INTO subscriptions (user_id, plan, start_date, end_date) VALUES
(1, 'Premium', '2024-06-01', NULL),
(2, 'Free', '2024-06-01', NULL),
(3, 'Premium', '2024-06-01', NULL);
