INSERT INTO mlff_pg_processing_fee
(id, active, created_by, created_date, deleted, last_modified_by, last_modified_date, restricted, version, sof, payment_method_code, processing_fee, processing_fee_type_flag, pg_name, payment_method)
VALUES
(1, 1, 'system', now(), 0, 'system', now(), 0, 0, '01', 'TNGD', 0, 'P', 'TNG Ewallet', 'TNGD'),
(2, 1, 'system', now(), 0, 'system', now(), 0, 0, '03', 'CC', 0.8, 'P', 'eGHL', 'Credit Card'),
(3, 1, 'system', now(), 0, 'system', now(), 0, 0, '03', 'DD', 0.35, 'P', 'eGHL', 'Debit Card'),
(4, 1, 'system', now(), 0, 'system', now(), 0, 0, '03', 'WA', 0.9, 'P', 'eGHL', 'Ewallet');