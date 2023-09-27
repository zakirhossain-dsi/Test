INSERT INTO mlff_gl_codes
(id, active, created_by, created_date, deleted, last_modified_by, last_modified_date, restricted, version, sof, payment_method, gp_gl_code, gp_gl_description, bc_gl_code, bc_gl_description, line_description, line_no)
VALUES
(1, 1, 'system', now(), 0, 'system', now(), 1, 0, null, null, null, 'CONTROL COMMISSION A/C - MLFF', null, 'CONTROL COMMISSION A/C - MLFF', 'MLFF-TOLL _COMMISSION', 1),
(2, 1, 'system', now(), 0, 'system', now(), 1, 0, null, null, null, 'CONTROL A/C - MLFF', null, 'CONTROL A/C - MLFF', 'MLFF-TOLL_NET', 2),
(3, 1, 'system', now(), 0, 'system', now(), 1, 0, '01', 'TNGD', null, 'INCOMING NETT - TNGD', null, 'INCOMING NETT - TNGD', 'MLFF-TOLL_GROSS-TNGD', 3),
(4, 1, 'system', now(), 0, 'system', now(), 1, 0, '01', 'TNGD', null, 'PROCESSING FEE - TNGD', null, 'PROCESSING FEE - TNGD', 'MLFF-TOLL_GROSS-TNGD', 4),
(5, 1, 'system', now(), 0, 'system', now(), 1, 0, '03',  null, null, 'INCOMING NETT - eGHL', null, 'INCOMING NETT - eGHL', 'MLFF-TOLL_GROSS-eGHL', 5),
(6, 1, 'system', now(), 0, 'system', now(), 1, 0, '03', 'CC', null, 'PROCESSING FEE - eGHL - CC', null, 'PROCESSING FEE - eGHL - CC', 'MLFF-TOLL_GROSS-eGHL', 6),
(7, 1, 'system', now(), 0, 'system', now(), 1, 0, '03', 'DD', null, 'PROCESSING FEE - eGHL - DD', null, 'PROCESSING FEE - eGHL - DD', 'MLFF-TOLL_GROSS-eGHL', 7),
(8, 1, 'system', now(), 0, 'system', now(), 1, 0, '03', 'WA', null, 'PROCESSING FEE - eGHL - WA', null, 'PROCESSING FEE - eGHL - WA', 'MLFF-TOLL_GROSS-eGHL', 8);








