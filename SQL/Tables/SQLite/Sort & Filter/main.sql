-- Create the GAMES table if it does not exist
CREATE TABLE IF NOT EXISTS GAMES (
    GAME_ID TEXT PRIMARY KEY,
    NAME TEXT,
    DEVELOPER_ID TEXT,
    RELEASE_YEAR INTEGER,
    PRICE INTEGER
);

-- Insert sample data into the GAMES table
INSERT INTO GAMES (GAME_ID, NAME, DEVELOPER_ID, RELEASE_YEAR, PRICE) VALUES
('G001', 'Super Mario Bros', 'NINTENDO', 1985, 59),
('G002', 'Sackboy Adventures', 'SONY PLAYSTATION', 2020, 49),
('G003', 'Club Penguin Atake for Windows', 'INDIE/PC', 2020, 10),
('G004', 'GEOMETRY DASH', 'INDIE/STEAM', 2013, 69),
('G005', 'Minecraft Triple Bundle', 'XBOX/PC', 2009, 29),
('G006', 'The Legend of Zelda: Breath of the Wild', 'NINTENDO', 2017, 59),
('G007', 'God of War', 'SONY PLAYSTATION', 2018, 49),
('G008', 'Stardew Valley', 'INDIE/PC', 2016, 15),
('G009', 'Hollow Knight', 'INDIE/STEAM', 2017, 20),
('G010', 'Halo Infinite', 'XBOX/PC', 2021, 59),
('G011', 'Roblox Bundle', 'INDIE/PC', 2006, 29),

-- Query to count the number of games in each developer
SELECT DEVELOPER_ID AS "Platform",
    COUNT(*) AS "No of Games"
FROM GAMES
GROUP BY DEVELOPER_ID;

-- Query to sum the price of each developer
SELECT DEVELOPER_ID AS "Platform",
    SUM(PRICE) AS "Total Price"
FROM GAMES
GROUP BY DEVELOPER_ID;

-- Query to count the number of employees and sum the salary in each department
SELECT DEVELOPER_ID AS "Platform",
    COUNT(*) AS "No of Games",
    SUM(PRICE) AS "Total Price"
FROM GAMES
GROUP BY DEVELOPER_ID;
