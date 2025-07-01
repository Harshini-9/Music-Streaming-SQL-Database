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
   ```git clone https://github.com/Harshini-9/Music-Streaming-SQL-Database.git
cd Music-Streaming-SQL-Database```

3. Load the schema:
Use DBeaver, pgAdmin, or any SQL tool
Open and run schema/create_tables.sql
Run queries from queries/insights.sql for reports
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
3. 
