DROP TABLE food;
DROP TABLE squirrels;

CREATE TABLE squirrels(
    id  SERIAL PRIMARY KEY,
    name VARCHAR(255),
    hibernate BOOLEAN,
    age INT
);

CREATE TABLE food(
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    type VARCHAR(255) NOT NULL,
    squirrel_id INT REFERENCES squirrels(id)
);

INSERT INTO squirrels(name,hibernate,age)VALUES('Rocco',false,5);
INSERT INTO squirrels(name,hibernate,age)VALUES('Luna',false,3);
INSERT INTO squirrels(name,hibernate,age)VALUES('Hunter',true,4);

-- UPDATE squirrels SET (name,hibernate) = ('Roccolette',true )WHERE id = 1;
-- DELETE FROM squirrels WHERE name ='Hunter'  OR name='Luna'

INSERT INTO squirrels (name, hibernate, age) VALUES ('Scrat', true, 2);
INSERT INTO squirrels (name, hibernate, age) VALUES ('Scrat', true, 2);
INSERT INTO squirrels (name, hibernate, age) VALUES ('Scrat', true, 2);
INSERT INTO squirrels (name, hibernate, age) VALUES ('Scrat', true, 2);
INSERT INTO squirrels (name, hibernate, age) VALUES ('Scrat', true, 2);

INSERT INTO food(name,type,squirrel_id) VALUES('brazil','nut',2);
INSERT INTO food(name,type,squirrel_id)VALUES('pumpkin', 'seed',2);

SELECT * FROM food;
SELECT * FROM squirrels WHERE  squirrel_id=2; 