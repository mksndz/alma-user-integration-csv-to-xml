# Alma SIS Integration - Users CSV to XML

Scripts that will convert a standard CSV format to Alma XML v2

## Usage

##### With Included Sample Data

Will output to /data/sample_output.xml

`ruby run.rb`

##### With Your Own CSV File

`ruby run.rb '/path/to/csv_file.csv' 'path/to/output_file.xml'`

## Running Tests

Only User object has tests for now

`cd test`

`ruby user_test.rb`

