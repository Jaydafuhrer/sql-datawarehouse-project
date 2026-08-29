-- =====================================================
-- CREATE BRONZE DATABASE
-- =====================================================

CREATE DATABASE IF NOT EXISTS data_warehouse_bronze
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE data_warehouse_bronze;


-- =====================================================
-- CREATE CRM TABLES
-- =====================================================

CREATE TABLE IF NOT EXISTS crm_cust_info (
    cst_id INT NOT NULL PRIMARY KEY,
    cst_key VARCHAR(50),
    cst_first_name VARCHAR(50),
    cst_last_name VARCHAR(50),
    cst_marital_status VARCHAR(20),
    cst_gender VARCHAR(10),
    cst_create_date DATE
);


CREATE TABLE IF NOT EXISTS crm_prd_info (
    prd_id INT NOT NULL PRIMARY KEY,
    prd_key VARCHAR(50),
    prd_name VARCHAR(50),
    prd_cost VARCHAR(50),
    prd_line VARCHAR(20),
    prd_start_date DATE,
    prd_end_date DATE
);


CREATE TABLE IF NOT EXISTS crm_sale_details (
    sls_order_num VARCHAR(50),
    sls_prod_key VARCHAR(50),
    sls_cust_id VARCHAR(50),
    sls_order_date DATE,
    sls_ship_date DATE,
    sls_due_date DATE,
    sls_sales FLOAT,
    sls_quantity INT,
    sls_price FLOAT
);


-- =====================================================
-- CREATE ERP TABLES
-- =====================================================

CREATE TABLE IF NOT EXISTS erp_cust_az12 (
    CID VARCHAR(50),
    birth_date DATE,
    gender VARCHAR(50)
);


CREATE TABLE IF NOT EXISTS erp_loc_a101 (
    CID VARCHAR(50) NOT NULL PRIMARY KEY,
    country VARCHAR(50)
);


CREATE TABLE IF NOT EXISTS erp_px_cat_g1v2 (
    ID VARCHAR(50) NOT NULL PRIMARY KEY,
    category VARCHAR(50),
    sub_category VARCHAR(50),
    maintenance VARCHAR(50)
);
