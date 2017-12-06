DROP TABLE IF EXISTS bounties;

CREATE TABLE bounties (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  species VARCHAR(255),
  bounty_value INT2,
  favourite_weapon VARCHAR(255)
);
