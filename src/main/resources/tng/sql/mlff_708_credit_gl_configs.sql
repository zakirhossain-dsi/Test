select
  gsc.summarization_code
, gsc.category
, gsc.sub_category
, gm.module
, ttgroup.code
, ttgroup.document_type
, mgc.gp_gl_code
, mgc.gp_gl_description
, mgc.sof
, mgc.bc_gl_code
, mgc.bc_gl_description
, mgc.line_no
, mgc.line_description
, glc.cr_division
, glc.cr_department
, glc.cr_hoca
, glc.cr_acc_type
, glc.cr_project
, glc.cr_cashflow
, glc.cr_dept_cd
FROM mlff_gl_configs glc
INNER JOIN mlff_gp_config_mappings gcm ON gcm.id = glc.gp_config_mapping_id
INNER JOIN mlff_gp_summarization_codes gsc ON gsc.id = gcm.gp_summarization_code_id
INNER JOIN mlff_gp_modules gm ON gm.id = gcm.gp_module_id
INNER JOIN mlff_t_type_groups ttgroup ON ttgroup.id = gcm.transaction_type_group_id
INNER JOIN mlff_t_types ttype ON ttype.t_type_group_id_fk = ttgroup.id
INNER JOIN mlff_gl_codes mgc ON mgc.id = glc.crglcode_id
WHERE gm.module = 'MLFF-TOLL'
AND ttype.id = 1
and gcm.sof = '03'
-- and mgc.sof = '03'
-- and (mgc.payment_method  is null or mgc.payment_method = 'CC');