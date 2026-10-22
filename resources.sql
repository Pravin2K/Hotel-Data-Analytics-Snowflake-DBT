--Create file format
CREATE OR REPLACE FILE FORMAT csv_format
  TYPE = 'CSV' 
  FIELD_DELIMITER = ','
  SKIP_HEADER = 1
  ERROR_ON_COLUMN_COUNT_MISMATCH = FALSE;


--Create storage integration
CREATE OR REPLACE STORAGE INTEGRATION AIRBNB_STORAGE
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = 'S3'
  ENABLED = TRUE
  STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::984454382053:role/AWS_Storage_Integration'
  STORAGE_ALLOWED_LOCATIONS = ('s3://airbnb-snow/source/');
  
DESC STORAGE INTEGRATION AIRBNB_STORAGE;


--Create stage
CREATE OR REPLACE STAGE snowstage
FILE_FORMAT = csv_format
STORAGE_INTEGRATION = AIRBNB_STORAGE
URL='s3://airbnb-snow/source/';

LIST @snowstage

--Copy data from stage to table
COPY INTO HOSTS 
FROM @snowstage/hosts.csv;
SELECT * FROM HOSTS;


--Copy data from stage to table
COPY INTO LISTINGS 
FROM @snowstage/listings.csv;
SELECT * FROM LISTINGS

COPY INTO BOOKINGS 
FROM @snowstage/bookings.csv;
SELECT * FROM BOOKINGS