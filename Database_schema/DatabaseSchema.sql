-- Create Database
CREATE DATABASE NetflixDB;


-- Connect to Snowflake account
USE ROLE ACCOUNTADMIN;
USE WAREHOUSE COMPUTE_WH;
USE DATABASE NetflixDB;
USE SCHEMA PUBLIC;

-- Create Dimension Tables

-- Time Dimension
CREATE TABLE netflix_movie_added (
    time_id INT AUTOINCREMENT PRIMARY KEY,
    date_added DATE
);

-- Country Dimension
CREATE TABLE movie_origin (
    country_id INT AUTOINCREMENT PRIMARY KEY,
    country_name VARCHAR(100)
);

-- Create Product Dimension

CREATE TABLE netflix_titles (
    show_id INT AUTOINCREMENT PRIMARY KEY,
    title VARCHAR(255),
    type VARCHAR(20),
    director VARCHAR(255),
    cast VARCHAR(500),
    release_year INT,
    rating VARCHAR(20),
    duration VARCHAR(20),
    listed_in VARCHAR(255),
    description TEXT
);

-- Create Fact Table

CREATE TABLE netflix_trends (
    viewing_id INT AUTOINCREMENT PRIMARY KEY,
    show_id INT,
    time_id INT,
    country_id INT,
    FOREIGN KEY (show_id) REFERENCES netflix_titles(show_id),
    FOREIGN KEY (time_id) REFERENCES netflix_movie_added(time_id),
    FOREIGN KEY (country_id) REFERENCES movie_origin(country_id)
);