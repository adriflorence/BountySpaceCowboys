DROP TABLE IF EXISTS bounty_hunters;

CREATE TABLE bounty_hunters(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  species VARCHAR(255),
  bounty_value INT2,
  danger_level INT2,
  last_known_location VARCHAR(255)
);
