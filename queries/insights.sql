
--Monthly Active Users (MAU)
SELECT DATE_TRUNC('month', listened_at) AS month, COUNT(DISTINCT user_id) AS active_users
FROM listening_history
GROUP BY month
ORDER BY month DESC;

-- Playlist Popularity Score (Based on Track Plays)
SELECT p.name AS playlist_name, u.username, SUM(t.play_count) AS popularity_score
FROM playlists p
JOIN users u ON p.user_id = u.user_id
JOIN playlist_tracks pt ON p.playlist_id = pt.playlist_id
JOIN tracks t ON pt.track_id = t.track_id
GROUP BY p.name, u.username
ORDER BY popularity_score DESC;

--Tracks Never Played
SELECT t.title AS unplayed_track, a.title AS album_title, ar.name AS artist_name
FROM tracks t
JOIN albums a ON t.album_id = a.album_id
JOIN artists ar ON a.artist_id = ar.artist_id
LEFT JOIN listening_history lh ON t.track_id = lh.track_id
WHERE lh.track_id IS NULL;

--Daily Listening Trends
SELECT DATE(listened_at) AS day, COUNT(*) AS total_listens
FROM listening_history
GROUP BY day
ORDER BY day DESC;

--VIEW
CREATE VIEW top_5_tracks AS
SELECT t.title, ar.name AS artist, t.play_count
FROM tracks t
JOIN albums al ON t.album_id = al.album_id
JOIN artists ar ON al.artist_id = ar.artist_id
ORDER BY t.play_count DESC
LIMIT 5;

--User Engagement by Subscription Plan
SELECT s.plan, COUNT(DISTINCT lh.user_id) AS engaged_users, COUNT(lh.history_id) AS total_listens
FROM subscriptions s
JOIN listening_history lh ON s.user_id = lh.user_id
GROUP BY s.plan
ORDER BY total_listens DESC;

--Churn Risk Users (Inactive Recently)
SELECT u.username, MAX(lh.listened_at) AS last_listened
FROM users u
LEFT JOIN listening_history lh ON u.user_id = lh.user_id
GROUP BY u.user_id, u.username
HAVING MAX(lh.listened_at) < CURRENT_DATE - INTERVAL '30 days' OR MAX(lh.listened_at) IS NULL
ORDER BY last_listened;
