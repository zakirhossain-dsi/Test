select
	id,
	category,
	description,
	sub_category,
	summarization_code
from mlff_gp_summarization_codes mgsc ;

select
	id,
	gp_module_id,
	sof,
	transaction_type_group_id,
	gp_summarization_code_id
from mlff_gp_config_mappings mgcm
order by gp_module_id, sof, transaction_type_group_id;

select
	id,
	sof,
	payment_method,
	gp_gl_code,
	gp_gl_description,
	bc_gl_code,
	bc_gl_description,
	line_description,
	line_no
from mlff_gl_codes mgc ;

select
	gp_config_mapping_id,
	cr_dept_cd,
	dr_dept_cd,
	crglcode_id,
	drglcode_id
from mlff_gl_configs mgc;