
--Top 5 Most Played Tracks-- All Time
SELECT t.title AS track_title, a.title AS album_title, ar.name AS artist_name, t.play_count
FROM tracks t
JOIN albums a ON t.album_id = a.album_id
JOIN artists ar ON a.artist_id = ar.artist_id
ORDER BY t.play_count DESC
LIMIT 5;

--Top 5 Most Played Tracks--Recent
SELECT u.username, t.title AS track_title, ar.name AS artist_name, lh.listened_at
FROM listening_history lh
JOIN users u ON lh.user_id = u.user_id
JOIN tracks t ON lh.track_id = t.track_id
JOIN albums al ON t.album_id = al.album_id
JOIN artists ar ON al.artist_id = ar.artist_id
WHERE u.username = 'musicfan1'
ORDER BY lh.listened_at DESC
LIMIT 10;

--Most Popular Artists by Total Track Plays
SELECT ar.name AS artist_name, SUM(t.play_count) AS total_plays
FROM artists ar
JOIN albums al ON ar.artist_id = al.artist_id
JOIN tracks t ON al.album_id = t.album_id
GROUP BY ar.artist_id, ar.name
ORDER BY total_plays DESC
LIMIT 5;

-- Playlists and Their Track Counts
SELECT p.name AS playlist_name, u.username, COUNT(pt.track_id) AS track_count
FROM playlists p
JOIN users u ON p.user_id = u.user_id
LEFT JOIN playlist_tracks pt ON p.playlist_id = pt.playlist_id
GROUP BY p.playlist_id, p.name, u.username
ORDER BY track_count DESC;

--Top Genres by Number of Tracks
SELECT g.name AS genre, COUNT(tg.track_id) AS num_tracks
FROM genres g
JOIN track_genres tg ON g.genre_id = tg.genre_id
GROUP BY g.genre_id, g.name
ORDER BY num_tracks DESC;

--Users Who Follow the Most Artists
SELECT u.username, COUNT(f.artist_id) AS followed_artists
FROM users u
JOIN follows f ON u.user_id = f.user_id
GROUP BY u.user_id, u.username
ORDER BY followed_artists DESC
LIMIT 5;

--Most Recent Albums by Each Artist (Window Function)
SELECT ar.name AS artist_name, al.title AS album_title, al.release_date
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY artist_id ORDER BY release_date DESC) AS rn
    FROM albums
) al
JOIN artists ar ON al.artist_id = ar.artist_id
WHERE al.rn = 1
ORDER BY ar.name;

--User’s Most Played Genre
SELECT u.username, g.name AS favorite_genre, COUNT(*) AS listens
FROM listening_history lh
JOIN users u ON lh.user_id = u.user_id
JOIN tracks t ON lh.track_id = t.track_id
JOIN track_genres tg ON t.track_id = tg.track_id
JOIN genres g ON tg.genre_id = g.genre_id
WHERE u.username = 'musicfan1'
GROUP BY u.username, g.name
ORDER BY listens DESC
LIMIT 1;
