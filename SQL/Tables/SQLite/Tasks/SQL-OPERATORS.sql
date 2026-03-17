CREATE TABLE Comidas (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    type TEXT NOT NULL,
    calories INTEGER,
    price REAL
);

INSERT INTO Comidas (name, type, calories, price)
VALUES ('Tacos', 'Mexican', 250, 35.50);

INSERT INTO Comidas (name, type, calories, price)
VALUES ('Pizza', 'Italian', 300, 80.00);

INSERT INTO Comidas (name, type, calories, price)
VALUES ('Sushi', 'Japanese', 200, 120.00);

SELECT * FROM Comidas;
