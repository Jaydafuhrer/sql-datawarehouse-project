-- =====================================================
-- 5. START BRONZE LOAD TIMER
-- =====================================================

SET @load_start_time = NOW(6);

SELECT CONCAT(
    'Bronze load started at: ',
    DATE_FORMAT(@load_start_time, '%Y-%m-%d %H:%i:%s.%f')
) AS message;


-- =====================================================
-- 6. EMPTY TABLES BEFORE RELOADING
-- =====================================================

TRUNCATE TABLE crm_sale_details;
TRUNCATE TABLE crm_prd_info;
TRUNCATE TABLE crm_cust_info;

TRUNCATE TABLE erp_cust_az12;
TRUNCATE TABLE erp_loc_a101;
TRUNCATE TABLE erp_px_cat_g1v2;


-- =====================================================
-- 7. LOAD CRM DATA
-- =====================================================

LOAD DATA LOCAL INFILE
'/Users/owner/Desktop/sql-data-warehouse-project/datasets/source_crm/cust_info.csv'
INTO TABLE crm_cust_info
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    cst_id,
    cst_key,
    cst_first_name,
    cst_last_name,
    cst_marital_status,
    cst_gender,
    cst_create_date
);


LOAD DATA LOCAL INFILE
'/Users/owner/Desktop/sql-data-warehouse-project/datasets/source_crm/prd_info.csv'
INTO TABLE crm_prd_info
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    prd_id,
    prd_key,
    prd_name,
    prd_cost,
    prd_line,
    prd_start_date,
    prd_end_date
);


LOAD DATA LOCAL INFILE
'/Users/owner/Desktop/sql-data-warehouse-project/datasets/source_crm/sales_details.csv'
INTO TABLE crm_sale_details
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    sls_order_num,
    sls_prod_key,
    sls_cust_id,
    sls_order_date,
    sls_ship_date,
    sls_due_date,
    sls_sales,
    sls_quantity,
    sls_price
);


-- =====================================================
-- 8. LOAD ERP DATA
-- =====================================================

LOAD DATA LOCAL INFILE
'/Users/owner/Desktop/sql-data-warehouse-project/datasets/source_erp/CUST_AZ12.csv'
INTO TABLE erp_cust_az12
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    CID,
    birth_date,
    gender
);


LOAD DATA LOCAL INFILE
'/Users/owner/Desktop/sql-data-warehouse-project/datasets/source_erp/LOC_A101.csv'
INTO TABLE erp_loc_a101
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    CID,
    country
);


LOAD DATA LOCAL INFILE
'/Users/owner/Desktop/sql-data-warehouse-project/datasets/source_erp/PX_CAT_G1V2.csv'
INTO TABLE erp_px_cat_g1v2
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    ID,
    category,
    sub_category,
    maintenance
);


-- =====================================================
-- 9. STOP BRONZE LOAD TIMER
-- =====================================================

SET @load_end_time = NOW(6);

SET @load_duration_seconds =
    TIMESTAMPDIFF(
        MICROSECOND,
        @load_start_time,
        @load_end_time
    ) / 1000000;


-- =====================================================
-- 10. VERIFY IMPORTED DATA
-- =====================================================

SELECT 'crm_cust_info' AS table_name, COUNT(*) AS row_count
FROM crm_cust_info

UNION ALL

SELECT 'crm_prd_info', COUNT(*)
FROM crm_prd_info

UNION ALL

SELECT 'crm_sale_details', COUNT(*)
FROM crm_sale_details

UNION ALL

SELECT 'erp_cust_az12', COUNT(*)
FROM erp_cust_az12

UNION ALL

SELECT 'erp_loc_a101', COUNT(*)
FROM erp_loc_a101

UNION ALL

SELECT 'erp_px_cat_g1v2', COUNT(*)
FROM erp_px_cat_g1v2;


-- =====================================================
-- 11. DISPLAY LOAD TIME
-- =====================================================

SELECT
    @load_start_time AS load_start_time,
    @load_end_time AS load_end_time,
    ROUND(@load_duration_seconds, 3) AS load_duration_seconds;

SELECT CONCAT(
    'Bronze data loaded successfully in ',
    ROUND(@load_duration_seconds, 3),
    ' seconds.'
) AS load_message;
