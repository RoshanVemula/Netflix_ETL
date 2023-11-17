-- create 3 schemas for landing, curated and consumption
create or replace schema landing_zone;
create or replace schema curated_zone;
create or replace schema consumption_zone;

-- snowflake has 3 sections Landing zone, Curated Zone and Consumption zone
-- landing zone is where the data lands from internal stage or external stage (AZURE BLOB< AWS s3 etc)
-- from landing data moves into curated then into consumtpion where actual tables are situated
-- create landing tables for tables in db
-- all landing tables are transient
-- all the columns are made varchar  to ensure data is being loaded for test. later the column datat types can be changed
USE SCHEMA landing_zone;
create or replace transient table landing_netflix_titles(
    SHOW_ID VARCHAR,
    TITLE VARCHAR,
    TYPE VARCHAR,
    DIRECTOR VARCHAR,
    CAST VARCHAR,
    RELEASE_YEAR VARCHAR ,
    RATING VARCHAR,
    DURATION VARCHAR,
    LISTED_IN VARCHAR,
    DESCRIPTION VARCHAR
)comment ='this is titles table with in landing schema';

-- transient table
create or replace transient table landing_movie_origin(
    COUNTRY_ID VARCHAR,
    COUNTRY_NAME VARCHAR
)comment ='this is movie origin table with in landing schema';

-- transient table
create or replace transient table landing_netflix_movie_added(
    TIME_ID VARCHAR,
    DATE_ADDED VARCHAR
)comment ='this is netflix movie added table with in landing schema';

-- transient table
create or replace transient table landing_netflix_trends(
    VIEWING_ID VARCHAR,
    SHOW_ID VARCHAR,
    TIME_ID VARCHAR,
    COUNTRY_ID VARCHAR
)comment ='this is netflix trends table with in landing schema';

-- display tables
--show tables

-- create a file format and load history data (input file in our case) as first time load to these landing tables
create or replace file format netflix_titles
type = 'csv' 
compression = 'auto' 
field_delimiter = ',' 
record_delimiter = '\n' 
skip_header = 1
field_optionally_enclosed_by = '\042' 
null_if = ('\\N');



-- create currated tables for tables in db
-- all currated tables are transient
-- all the columns are made varchar to ensure data is being loaded for test. later the column datat types can be changed
use schema curated_zone;
create or replace transient table curated_netflix_titles(
    SHOW_ID VARCHAR,
    TITLE VARCHAR,
    TYPE VARCHAR,
    DIRECTOR VARCHAR,
    CAST VARCHAR,
    RELEASE_YEAR VARCHAR ,
    RATING VARCHAR,
    DURATION VARCHAR,
    LISTED_IN VARCHAR,
    DESCRIPTION VARCHAR
)comment ='this is titles table with in curated schema';

-- transient table
create or replace transient table curated_movie_origin(
    COUNTRY_ID VARCHAR,
    COUNTRY_NAME VARCHAR
)comment ='this is movie origin table with in curatedschema';

-- transient table
create or replace transient table curated_netflix_movie_added(
    TIME_ID VARCHAR,
    DATE_ADDED VARCHAR
)comment ='this is netflix movie added table with in curated schema';

-- transient table
create or replace transient table curated_netflix_trends(
    VIEWING_ID VARCHAR,
    SHOW_ID VARCHAR,
    TIME_ID VARCHAR,
    COUNTRY_ID VARCHAR
)comment ='this is netflix trends table with in curated schema';

-- run insert statement to load data from landing zone to curated zone for all the curated tables
-- movie_origin table
insert into NetflixDB.curated_zone.curated_movie_origin(
    COUNTRY_ID,
    COUNTRY_NAME
)
select
    COUNTRY_ID,
    COUNTRY_NAME
from NetflixDB.landing_zone.landing_movie_origin;

-- netflix movie added table 
insert into NetflixDB.curated_zone.curated_netflix_movie_added(
    TIME_ID,
    DATE_ADDED
)
select
    TIME_ID,
    DATE_ADDED
from NetflixDB.landing_zone.landing_netflix_movie_added;

-- netflix titles tables
insert into NetflixDB.curated_zone.curated_netflix_titles(
    SHOW_ID,
    TITLE,
    TYPE,
    DIRECTOR,
    CAST,
    RELEASE_YEAR,
    RATING,
    DURATION,
    LISTED_IN,
    DESCRIPTION)
select
    SHOW_ID,
    TITLE,
    TYPE,
    DIRECTOR,
    'CAST',
    RELEASE_YEAR,
    RATING,
    DURATION,
    LISTED_IN,
    DESCRIPTION
from NetflixDB.landing_zone.landing_netflix_titles;

-- netflix trends table
insert into NetflixDB.curated_zone.curated_netflix_trends(
    VIEWING_ID,
    SHOW_ID,
    TIME_ID,
    COUNTRY_ID
)
select
    VIEWING_ID,
    SHOW_ID,
    TIME_ID,
    COUNTRY_ID
from NetflixDB.landing_zone.landing_netflix_trends;

-- final satge consumption where are tables are situated
-- create dim and fact tables
-- these are permanent tables and not transient tables
-- Time Dimension
USE schema consumption_zone;

CREATE or REPLACE TABLE netflix_movie_added (
    time_id INT AUTOINCREMENT PRIMARY KEY,
    date_added DATE
);

-- Country Dimension
CREATE or REPLACE TABLE movie_origin (
    country_id INT AUTOINCREMENT PRIMARY KEY,
    country_name VARCHAR(100)
);

-- Create Product Dimension

CREATE or REPLACE TABLE netflix_titles (
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

CREATE or REPLACE TABLE netflix_trends (
    viewing_id INT AUTOINCREMENT PRIMARY KEY,
    show_id INT,
    time_id INT,
    country_id INT,
    FOREIGN KEY (show_id) REFERENCES netflix_titles(show_id),
    FOREIGN KEY (time_id) REFERENCES netflix_movie_added(time_id),
    FOREIGN KEY (country_id) REFERENCES movie_origin(country_id)
);

-- insert data from curated zone to consumption zone
-- if any transformations required can be performed here

-- movie_origin table
insert into NetflixDB.curated_zone.curated_movie_origin(
    COUNTRY_ID,
    COUNTRY_NAME
)
select
    COUNTRY_ID,
    COUNTRY_NAME
from NetflixDB.landing_zone.landing_movie_origin;

-- netflix movie added table 
insert into NetflixDB.curated_zone.curated_netflix_movie_added(
    TIME_ID,
    DATE_ADDED
)
select
    TIME_ID,
    DATE_ADDED
from NetflixDB.curated_zone.curated_netflix_movie_added;

-- netflix titles tables
insert into NetflixDB.consumption_zone.netflix_titles(
    SHOW_ID,
    TITLE,
    TYPE,
    DIRECTOR,
    CAST,
    RELEASE_YEAR,
    RATING,
    DURATION,
    LISTED_IN,
    DESCRIPTION)
select
    SHOW_ID,
    TITLE,
    TYPE,
    DIRECTOR,
    'CAST',
    RELEASE_YEAR,
    RATING,
    DURATION,
    LISTED_IN,
    DESCRIPTION
from NetflixDB.curated_zone.curated_netflix_titles;

-- netflix trends table
insert into NetflixDB.consumption_zone.netflix_trends(
    VIEWING_ID,
    SHOW_ID,
    TIME_ID,
    COUNTRY_ID
)
select
    VIEWING_ID,
    SHOW_ID,
    TIME_ID,
    COUNTRY_ID
from NetflixDB.curated_zone.curated_netflix_trends;

-- create stages and pipes to enable continously data loading (the ELT funtion)
-- since I dont have the s3 credentials i'm using example url which is not the exact
USE Schema landing_zone
-- movie_origin stage
create stage delta_movie_origin_s3
url = 's3://example/movie_origin' 
comment = 'feed delta movie_origin files';

-- netflix_movie_added stage
create stage delta_netflix_movie_added_s3
url = 's3://example/netflix-movie-added'  
comment = 'feed delta netflix-movie-added files';

-- netflix_titles stage
create stage delta_netflix_titles_s3
url = 's3://toppertips/delta/netflix_titles' 
comment = 'feed delta netflix_titles files';

-- netflix_trends stage
create stage delta_netflix_trends_s3
url = 's3://example/netflix_trends' 
comment = 'feed delta netflix_trends files';

-- create pipe obkject to push delta loads via copy
-- make sure to have auto-ingest = true, else it wont ingest automatically upon change
-- and the instance should be running in AWS snowflake env
-- else the ARN will not be displayed

-- movie_origin pipe
-- here the csv file name is abritary and based on the file name we get

create or replace pipe movie_origin_pipe
    auto_ingest = true
    as 
        copy into landing_movie_origin from @delta_movie_origin_s3
        file_format = (type=csv COMPRESSION=none)
        pattern='.movie_origin.[.]csv'
        ON_ERROR = 'CONTINUE';

-- netflix_movie_added pipe
create or replace pipe netflix_movie_added_pipe
    auto_ingest = true
    as 
        copy into landing_netflix_movie_added from @delta_netflix_movie_added_s3
        file_format = (type=csv COMPRESSION=none)
        pattern='.netflix_movie_added.[.]csv'
        ON_ERROR = 'CONTINUE';

-- netflix_titles pipe
create or replace pipe netflix_titles_pipe
    auto_ingest = true
    as 
        copy into landing_netflix_titles from @delta_netflix_titles_s3
        file_format = (type=csv COMPRESSION=none)
        pattern='.netflix_titles.[.]csv'
        ON_ERROR = 'CONTINUE';

-- netflix_trends pipe
create or replace pipe netflix_trends_pipe
    auto_ingest = true
    as 
        copy into landing_netflix_trends from @delta_netflix_trends_s3
        file_format = (type=csv COMPRESSION=none)
        pattern='.netflix_trends.[.]csv'
        ON_ERROR = 'CONTINUE';

-- review pipe status
-- the pipes should be in running state
select system$pipe_status('movie_origin_pipe');
select system$pipe_status('netflix_movie_added_pipe');
select system$pipe_status('netflix_titles_pipe');
select system$pipe_status('netflix_trends_pipe');

-- create streams on appedn only mode
Use Schema landing_zone

create or replace stream landing_movie_origin on table landing_movie_origin
      append_only = true;

create or replace stream landing_netflix_movie_added on table landing_netflix_movie_added
      append_only = true;

create or replace stream landing_netflix_titles on table landing_netflix_titles
      append_only = true;

create or replace stream landing_netflix_trends on table landing_netflix_trends
      append_only = true;

-- creating curated tasks that run after for a particular time period
USe schema curated_zone

Create or replace task landing_movie_origin_tsk
wherehouse = compute_wh
schedule = '5 minute'
When 
 system$stream_has_data('NetflixDB.landing_zone.landind_movie_origin')
as
merge into curated_zone.curated_movie_origin cmo
using landing_zone.landing_movie_origin_stm lmos on
cmo.country_id = lmos.country_id
when matched
 then update 
     set cmo.country_id = lmos.country_id,
     cmo.country_name = lmos.country_name
when not matched then
insert(country_Id, country_Name) 
values(lmos.country_id, lmos.country_name)

-- repeating the same for all the other tables.

-- resume suspended tasks
alter task landing_movie_origin_tsk resume;

-- now when there is data change the s3 bucket pushes it to landing zone and streams pick them up
create or replace stream curated_movie_origin_stm on table curated_movie_origin;

USe schema consumption_zone

Create or replace task movie_origin_consumption_tsk
warehouse = compute_wh
schedule = '4 mintue'
when 
system$stream_has_data('curated_zone.curated_movie_origin_stm')
as
merge into consumption_zone.movie_origin_dim mo using curated_zone.curate_movie_orign_stm c
mo.country_id = c.country_id and mo.country_name = c.country_name
when matched
and curated_movie_origin_stm.Metadata$Action = 'Insert'
and curated_movie_origin_stm.Metadata$ISUPDATE = 'True'