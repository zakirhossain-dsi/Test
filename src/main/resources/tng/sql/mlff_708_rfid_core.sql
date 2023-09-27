select * from mdt_gp_summarization_codes mgsc ;

select
	id,
	gp_module_id,
	sof,
	transaction_type_group_id,
	gp_summarization_code_id
from mdt_gp_config_mappings mgcm
where transaction_type_group_id = 1 and gp_module_id = 1
order by gp_summarization_code_id ;

select
	gp_config_mapping_id,
	cr_dept_cd,
	dr_dept_cd,
	crglcode_id,
	creditglcode.description as creditGLDescription,
	drglcode_id,
	debitglcode.description as debitGLDescription
from mdt_gl_configs glConfig
inner join mdt_gl_codes creditGlCode on creditGlCode.id  = glconfig.crglcode_id
inner join mdt_gl_codes debitGlCode on debitGlCode.id = glconfig.drglcode_id
where gp_config_mapping_id in (1, 2, 3, 4, 17, 18)
order by gp_config_mapping_id asc;

select id, description, gl_code, gl_code_old , description_old
from mdt_gl_codes
mgc where id in (1, 3);