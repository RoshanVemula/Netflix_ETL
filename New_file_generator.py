import csv
from faker import Faker
import random

# Function to generate fake data
def generate_fake_data():
    fake = Faker()
    return [
        fake.show_id(),
        fake.type(),
        fake.Title(),
        fake.Director(),
        fake.Cast(),
        fake.Country(),
        fake.Date_added(),
        fake.Released_year(),
        fake.Rating(),
        fake.Duration(),
        fake.listed_in(),
        fake.description(),
    ]

# Function to check for duplicate records
def is_duplicate(record, existing_records):
    return record in existing_records

# File paths
# I have give m local path but we can use os.path for universal path
input_file = 'C:/Users/roshan/Desktop/test/netflix_titles.csv'
output_file = 'C:/Users/roshan/Desktop/test/new_netlfix_files_data.csv'

# Read existing data
existing_records = []
with open(input_file, 'r', newline='') as csvfile:
    reader = csv.reader(csvfile)
    # Skip header if exists
    next(reader, None)
    for row in reader:
        existing_records.append(row)

# Generate new records
new_records = []
for _ in range(100):
    new_record = generate_fake_data()

    # Check for duplicates
    while is_duplicate(new_record, existing_records + new_records):
        new_record = generate_fake_data()

    new_records.append(new_record)

# Append new records to the existing data
with open(output_file, 'a', newline='') as csvfile:
    writer = csv.writer(csvfile)
    writer.writerows(new_records)

print("New records added successfully.")