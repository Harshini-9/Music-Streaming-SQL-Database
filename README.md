# Music-Streaming-SQL-Database
This project is a fully normalized SQL database design for a Music Streaming Platform, modeled for use in a real-world, production-grade application. It was built to demonstrate database architecture, normalization, relational modeling, and analytics using SQL. This backend database captures users, tracks, artists, albums, playlists, genres, subscriptions, and listening history, and supports advanced queries for business insights such as top tracks, most-followed artists, and genre analytics.
# Stack Used
- Database Engine: PostgreSQL 16 
- Schema Language: Standard SQL
- ER Diagram Tool: dbdiagram.io
- DBML Format: Used for visual schema modeling
- Tools Used: VS Code, pgAdmin Git, GitHub
# Features Implemented
1. Complete database schema with 13+ normalized tables
2. Many-to-many relationships handled via junction tables
3. ER Diagram designed in DBML and exported as PNG
4. Sample data insertions for artists, users, tracks, and genres
5. Advanced SQL queries to extract business insights
6. Subscription model with Free and Premium support
7. Listening history table for trend analysis
8. DBML schema file and ER diagram image included
# How to use project locally
1. Clone the repo:
   ```
clone https://github.com/Harshini-9/Music-Streaming-SQL-Database.git
cd Music-Streaming-SQL-Database
```
2. Load the schema:
- Use DBeaver, pgAdmin, or any SQL tool
- Open and run schema/create_tables.sql
- Run queries from queries/insights.sql for reports
# queries/insights.sql – Analytical Queries
1. Top 5 Most Played Tracks (All Time)
   ```bash
    SELECT t.title AS track_title, a.title AS album_title, ar.name AS artist_name, t.play_count
FROM tracks t
JOIN albums a ON t.album_id = a.album_id
JOIN artists ar ON a.artist_id = ar.artist_id
ORDER BY t.play_count DESC
LIMIT 5;
```
Insight: Understand which tracks have been most played historically for royalty distribution or recommendations.
2. Recent Listening Activity by a User
``` SELECT u.username, t.title AS track_title, ar.name AS artist_name, lh.listened_at
FROM listening_history lh
JOIN users u ON lh.user_id = u.user_id
JOIN tracks t ON lh.track_id = t.track_id
JOIN albums al ON t.album_id = al.album_id
JOIN artists ar ON al.artist_id = ar.artist_id
WHERE u.username = 'musicfan1'
ORDER BY lh.listened_at DESC
LIMIT 10;
```
Insight: View recent engagement for personalization or user-specific dashboard.
3.  Most Followed Artists 
```SELECT ar.name AS artist_name, COUNT(f.user_id) AS follower_count
FROM follows f
JOIN artists ar ON f.artist_id = ar.artist_id
GROUP BY ar.artist_id, ar.name
ORDER BY follower_count DESC
LIMIT 5;
 ```
Insight: Identify top artists by follower count to prioritize for homepage visibility, promotional deals, etc.
4. Top Genres by Number of Tracks
SELECT g.name AS genre, COUNT(tg.track_id) AS num_tracks
FROM genres g
JOIN track_genres tg ON g.genre_id = tg.genre_id
GROUP BY g.genre_id, g.name
ORDER BY num_tracks DESC;
Insight: Discover dominant genres in your catalog for genre-based curation or playlist strategy.
5.  Most Popular Albums (by Total Plays)
```SELECT a.title AS album_title, ar.name AS artist_name, SUM(t.play_count) AS total_album_plays
FROM albums a
JOIN tracks t ON a.album_id = t.album_id
JOIN artists ar ON a.artist_id = ar.artist_id
GROUP BY a.album_id, a.title, ar.name
ORDER BY total_album_plays DESC
LIMIT 5;
 ```
Insight: Reveal which albums are resonating most with users.
6.  Subscribed vs Free Users Count
``` SELECT plan, COUNT(*) AS user_count
FROM subscriptions
GROUP BY plan;
```
Report: Measure adoption rate of premium plans vs free-tier users.
7. Active Users by Listening History Count
```SELECT u.username, COUNT(lh.track_id) AS tracks_played
FROM users u
JOIN listening_history lh ON u.user_id = lh.user_id
GROUP BY u.user_id, u.username
ORDER BY tracks_played DESC;
```
Report: Evaluate user engagement levels and identify your power users.
8. Most Recent Album by Each Artist
```SELECT ar.name AS artist_name, al.title AS album_title, al.release_date
FROM (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY artist_id ORDER BY release_date DESC) AS rn
    FROM albums
) al
JOIN artists ar ON al.artist_id = ar.artist_id
WHERE al.rn = 1
ORDER BY ar.name;
 ```
Report: Lists latest album releases per artist, useful for newsletters or home banners.
#  Business Value
- Helps understand user listening patterns and track popularity
- Assists in targeted marketing based on most followed artists
- Provides data for subscription management and plan optimization
- Enables genre-specific curation and playlist personalization
