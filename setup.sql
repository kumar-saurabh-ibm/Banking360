-- =====================================================
-- 1. CREATE WAREHOUSE
-- =====================================================

CREATE WAREHOUSE BANK_WH;

-- =====================================================
-- 2. CREATE USER
-- =====================================================

CREATE USER DBT_USER;

-- Set password for the user
ALTER USER DBT_USER SET PASSWORD = 'dbt@password';

-- =====================================================
-- 3. CREATE ROLE
-- =====================================================

CREATE ROLE BANK360_ROLE;

-- Grant role to user
GRANT ROLE BANK360_ROLE TO USER DBT_USER;

-- =====================================================
-- 4. CREATE DATABASE
-- =====================================================

CREATE DATABASE BANK360_PROJECT;

-- =====================================================
-- 5. CREATE SCHEMAS
-- =====================================================

CREATE SCHEMA BANK360_PROJECT.RAW;
CREATE SCHEMA BANK360_PROJECT.STAGING;
CREATE SCHEMA BANK360_PROJECT.INTERMEDIATE;
CREATE SCHEMA BANK360_PROJECT.MARTS;
CREATE SCHEMA BANK360_PROJECT.RISK;

-- =====================================================
-- 6. WAREHOUSE ACCESS
-- =====================================================

-- Allow role to use the warehouse
GRANT USAGE ON WAREHOUSE BANK_WH
TO ROLE BANK360_ROLE;

-- =====================================================
-- 7. DATABASE ACCESS
-- =====================================================

-- Allow role to access the database
GRANT USAGE ON DATABASE BANK360_PROJECT
TO ROLE BANK360_ROLE;

-- =====================================================
-- 8. SCHEMA ACCESS
-- =====================================================

GRANT USAGE ON SCHEMA BANK360_PROJECT.RAW
TO ROLE BANK360_ROLE;

GRANT USAGE ON SCHEMA BANK360_PROJECT.STAGING
TO ROLE BANK360_ROLE;

GRANT USAGE ON SCHEMA BANK360_PROJECT.INTERMEDIATE
TO ROLE BANK360_ROLE;

GRANT USAGE ON SCHEMA BANK360_PROJECT.MARTS
TO ROLE BANK360_ROLE;

GRANT USAGE ON SCHEMA BANK360_PROJECT.RISK
TO ROLE BANK360_ROLE;

-- =====================================================
-- 9. RAW SCHEMA PERMISSIONS
-- =====================================================

-- Create raw ingestion tables
GRANT CREATE TABLE
ON SCHEMA BANK360_PROJECT.RAW
TO ROLE BANK360_ROLE;

-- Create stages for loading files
GRANT CREATE STAGE
ON SCHEMA BANK360_PROJECT.RAW
TO ROLE BANK360_ROLE;

-- Create file formats for ingestion
GRANT CREATE FILE FORMAT
ON SCHEMA BANK360_PROJECT.RAW
TO ROLE BANK360_ROLE;

-- =====================================================
-- 10. STAGING SCHEMA PERMISSIONS
-- =====================================================

GRANT CREATE TABLE
ON SCHEMA BANK360_PROJECT.STAGING
TO ROLE BANK360_ROLE;

GRANT CREATE VIEW
ON SCHEMA BANK360_PROJECT.STAGING
TO ROLE BANK360_ROLE;

-- =====================================================
-- 11. INTERMEDIATE SCHEMA PERMISSIONS
-- =====================================================

GRANT CREATE TABLE
ON SCHEMA BANK360_PROJECT.INTERMEDIATE
TO ROLE BANK360_ROLE;

GRANT CREATE VIEW
ON SCHEMA BANK360_PROJECT.INTERMEDIATE
TO ROLE BANK360_ROLE;

-- =====================================================
-- 12. MARTS SCHEMA PERMISSIONS
-- =====================================================

GRANT CREATE TABLE
ON SCHEMA BANK360_PROJECT.MARTS
TO ROLE BANK360_ROLE;

GRANT CREATE VIEW
ON SCHEMA BANK360_PROJECT.MARTS
TO ROLE BANK360_ROLE;

-- ================