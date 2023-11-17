# Netflix ETL pipeline and data analysis Test

## Introduction

This project focuses on analyzing Netflix title data using Snowflake. The project involves creating a Snowflake database, setting up a dimensional model, building ETL pipelines for data transformation from S3 buckets, generating random source files using Python, and creating SQL views to answer specific questions about the data.

## Files and Directory Structure

- databaseSchema.sql: Contains the SQL script for creating the Snowflake database and defining the dimensional model.

- etl_s3_Netflix.sql: ETL pipeline script that handles the extraction, transformation, and loading of data from S3 buckets into the Snowflake database.

- new_file_generator.py: Python script to generate a random source file for testing purposes.

- sql_views/: Directory containing SQL view scripts to answer specific analytical questions about the Netflix data.

## Instructions

1. **Database Setup:**
   - Run the databaseSchema.sql script to create the Snowflake database and define the dimensional model.

2. **ETL Pipeline:**
   - Execute the etl_s3_Netflix.sql script to perform the ETL process, transforming data from S3 buckets into the Snowflake database.

3. **Random File Generation:**
   - Run the new_file_generator.py script to generate a random source file for testing the ETL pipeline.

4. **SQL Views:**
   - Explore the sql_views/ directory to find SQL scripts for creating views to answer specific analytical questions about the Netflix data.

## Usage

- Modify the scripts based on your specific environment, file paths, and Snowflake account details.

- Ensure you have the necessary permissions and configurations for accessing S3 buckets.

## Dependencies

- Snowflake account with appropriate permissions.

- Python with the required packages for running the generator script.
