-- Drop Staging Tables if they exist
DROP TABLE IF EXISTS staging_events;
DROP TABLE IF EXISTS staging_songs;

-- Drop Fact Table if it exists
DROP TABLE IF EXISTS songplays;

-- Drop Dimension Tables if they exist
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS songs;
DROP TABLE IF EXISTS artists;
DROP TABLE IF EXISTS time;

-- Staging Events Table
CREATE TABLE IF NOT EXISTS staging_events (
    event_id       SERIAL PRIMARY KEY,
    artist         VARCHAR,
    auth           VARCHAR,
    first_name     VARCHAR,
    gender         VARCHAR(1),
    item_in_session INT,
    last_name      VARCHAR,
    length         FLOAT,
    level          VARCHAR,
    location       VARCHAR,
    method         VARCHAR,
    page           VARCHAR,
    registration   BIGINT,
    session_id     INT,
    song           VARCHAR,
    status         INT,
    ts             BIGINT,
    user_agent     VARCHAR,
    user_id        INT
);

-- Staging Songs Table
CREATE TABLE IF NOT EXISTS staging_songs (
    num_songs         INT,
    artist_id         VARCHAR,
    artist_latitude   FLOAT,
    artist_longitude  FLOAT,
    artist_location   VARCHAR,
    artist_name       VARCHAR,
    song_id           VARCHAR,
    title             VARCHAR,
    duration          FLOAT,
    year              INT
);

-- Fact Table: songplays
CREATE TABLE IF NOT EXISTS songplays (
    songplay_id   SERIAL PRIMARY KEY,
    start_time    TIMESTAMP NOT NULL,
    user_id       INT NOT NULL,
    level         VARCHAR,
    song_id       VARCHAR,
    artist_id     VARCHAR,
    session_id    INT,
    location      VARCHAR,
    user_agent    VARCHAR
);

-- users dimension
CREATE TABLE IF NOT EXISTS users (
    user_id      INT PRIMARY KEY,
    first_name   VARCHAR,
    last_name    VARCHAR,
    gender       VARCHAR(1),
    level        VARCHAR
);

-- songs dimension
CREATE TABLE IF NOT EXISTS songs (
    song_id     VARCHAR PRIMARY KEY,
    title       VARCHAR,
    artist_id   VARCHAR,
    year        INT,
    duration    FLOAT
);

-- artists dimension
CREATE TABLE IF NOT EXISTS artists (
    artist_id   VARCHAR PRIMARY KEY,
    name        VARCHAR,
    location    VARCHAR,
    latitude    FLOAT,
    longitude   FLOAT
);

-- time dimension
CREATE TABLE IF NOT EXISTS time (
    start_time  TIMESTAMP PRIMARY KEY,
    hour        INT,
    day         INT,
    week        INT,
    month       INT,
    year        INT,
    weekday     INT
);
