select * from rop_app_sector;
select * from rop_appsector_mid;
select * from rop_directroute_mid;
select * from rop_mx_tpms_response;
select * from rop_tpms_order_and_input_info;
select * from rop_reason;
select * from rop_mid_ref;
select * from rop_transactions;
select * from rop_transaction_types;
select * from rop_t_type_group;
select * from rop_bank;
select * from rop_balance_sheet;
select * from rop_balance_sheet_error;
select * from rop_transaction_card_error;
select * from rop_gl_code;
select * from rop_transaction_system_error;
select * from emails;
select * from email_configs;
select * from rop_gl_config;
select * from rop_gp_config_mapping;
select * from rop_crons;
select * from rop_cron_job_status;
select * from mdt_system_configs;
select * from bank_settlement_info;
select * from glo_crons;
select * from file_configs;
select * from payment_reconciliation;
select * from rpt_reports;
select * from mdt_reports;
select * from mdt_report_parameters;
select * from mdt_service_providers;
-- select * from rop_gl_summarization_code;
-- select * from mx_accounts_customers;
-- select * from rop_token_profile;

-- Titan table
select * from tags;
select * from vehicles;
select * from main_customer_account;
select * from rop_token_profile;
select * from mx_accounts;


-- rop_gp_staging doesn't exist


Notes:
--rop_mid_ref - What is purpose pg_mid
--rop_directroute_mid - what is the purpose of pg_mid


rop_transactions --> transaction_mid