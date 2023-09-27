SELECT
  gm.module
, ttgroup.code
, gsc.summarization_code
, gsc.category
, gsc.sub_category
, debit.gp_gl_code AS dr_gp_gl_code
, debit.gp_gl_description AS dr_gp_gl_description
, glc.dr_dept_cd
, credit.gp_gl_code AS cr_gp_gl_code
, credit.gp_gl_description AS cr_gp_gl_code
, glc.cr_dept_cd
, ttgroup.document_type
, debit.sof
, gcm.advance_payment
, glc.dr_division
, glc.dr_department
, glc.dr_hoca
, glc.dr_acc_type
, glc.dr_project
, glc.dr_cashflow
, glc.cr_division
, glc.cr_department
, glc.cr_hoca
, glc.cr_acc_type
, glc.cr_project
, glc.cr_cashflow
, debit.bc_gl_code AS dr_bc_gl_code
, debit.bc_gl_description AS dr_bc_description
, credit.bc_gl_code AS cr_bc_gl_code
, credit.bc_gl_description AS cr_bc_gl_description
, debit.line_no AS debit_line_no
, credit.line_no AS credit_line_no
, debit.line_description AS debit_line_description
, credit.line_description AS credit_line_description
FROM mlff_gl_configs glc
INNER JOIN mlff_gp_config_mappings gcm ON gcm.id = glc.gp_config_mapping_id
INNER JOIN mlff_gp_summarization_codes gsc ON gsc.id = gcm.gp_summarization_code_id
INNER JOIN mlff_gp_modules gm ON gm.id = gcm.gp_module_id
INNER JOIN mlff_t_type_groups ttgroup ON ttgroup.id = gcm.transaction_type_group_id
INNER JOIN mlff_t_types ttype ON ttype.t_type_group_id_fk = ttgroup.id
INNER JOIN mlff_gl_codes debit ON debit.id = glc.drglcode_id
INNER JOIN mlff_gl_codes credit ON credit.id = glc.crglcode_id
LEFT JOIN mlff_app_sectors sector ON sector.id = glc.app_sector_id
WHERE gm.module = 'MLFF-TOLL' AND ttype.id = 1;