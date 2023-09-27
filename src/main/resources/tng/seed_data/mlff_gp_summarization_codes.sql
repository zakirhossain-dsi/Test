INSERT INTO mlff_gp_summarization_codes
(id, active, created_by, created_date, deleted, last_modified_by, last_modified_date, restricted, version, category, description, sub_category, summarization_code)
VALUES
(1, 1, 'system', now(), 0, 'system', now(), 1, 0, 'USAGE', 'Commission', 'COMMISSION', 'CM'),
(2, 1, 'system', now(), 0, 'system', now(), 1, 0, 'USAGE', 'Net Statement', 'NET', 'NS'),
(3, 1, 'system', now(), 0, 'system', now(), 1, 0, 'USAGE', 'Usage (Gross)', 'GROSS-TNGD', 'US'),
(4, 1, 'system', now(), 0, 'system', now(), 1, 0, 'USAGE', 'Usage (Gross)', 'GROSS-eGHL', 'US');