SELECT
    Date(t.sp_sent_timestamp) AS receivedDate,
    Date(t.posted_date) AS postedDate,
    appsec.description AS businessSector,
    sp.sp_id AS spId,
    sp.account_number AS spAccNo,
    sp.sp_name AS spName,
    '' AS locName,
    '' AS locAcc,
    '' AS locId,
    CASE
        WHEN t.source_of_fund= 'EWALLET' THEN 'CALI'
    ELSE t.source_of_fund
    END AS sourceOfPayment,
    CASE
        WHEN t.source_of_fund ='ROP' THEN t.source_of_fund
        WHEN t.source_of_fund ='EWALLET' THEN 'TNGD'
    END AS sourceOfPayment1,
    CASE
        WHEN t.transaction_status = 'SUCCESS' THEN 'Payable'
        WHEN t.transaction_status = 'REJECT' THEN 'Non-Payable'
        WHEN t.transaction_status = 'ONHOLD_PAID' THEN 'On-Hold Paid'
        WHEN t.transaction_status = 'PENDING_PAID' THEN 'Pending Paid'
        WHEN t.transaction_status = 'ONHOLD' THEN 'On-Hold'
        WHEN t.transaction_status = 'PENDING' THEN 'Pending'
        WHEN t.transaction_status = 'SUCCESS_ROP_PAID' THEN 'Success ROP Paid'
        WHEN t.transaction_status = 'SUCCESS_ROP_UNPAID' THEN 'Success ROP Unpaid'
        WHEN t.transaction_status = 'PENDING_ROP_UNPAID' THEN 'Pending ROP Unpaid'
        WHEN t.transaction_status = 'PENDING_ROP_PAID' THEN 'Pending ROP Paid'
        WHEN t.transaction_status = 'ONHOLD_ROP_UNPAID' THEN 'Onhold ROP Unpaid'
        WHEN t.transaction_status = 'ONHOLD_ROP_PAID' THEN 'Onhold ROP Paid'
    end AS status,
    tt.t_type AS tType,
    tt.debit_credit AS debitOrCredit,
    tt.t_type_desc AS tTypeDesc,
    '1' AS tTypeCategory,
    Count(*) AS totalTransactions,
    0 AS totalGross,
    0 AS totalComm,
    0 AS totalGst,
    0 AS totalNet
FROM rpt_transactions t
LEFT JOIN mdt_service_providers sp ON sp.sp_id = t.exit_sp_id AND sp.deleted = false
LEFT JOIN mdt_app_sectors appsec ON sp.app_sector = appsec.code AND sp.deleted = false
LEFT JOIN mdt_t_types tt ON tt.id = t.t_type_fk
WHERE t.posted_date between  '2017-10-31 00:00:00' and  '2017-10-31 23:59:59'
and t.cut_off_date between  '2017-10-31 00:00:00' and  '2017-10-31 23:59:59'
and t.transaction_status IN ('ONHOLD', 'REJECT')
GROUP BY sp.sp_id, Date(t.posted_date), t.transaction_status, tt.id, sourceOfPayment
order by Date(x.postedDate), x.spId,
case
    when x.status = 'Payable' then 1
    when x.status = 'Pending Paid' then 2
    when x.status = 'On-Hold Paid' then 3
    when x.status = 'Pending' then 4
    when x.status = 'On-Hold' then 5
    when x.status = 'Non-Payable' then 6
end asc;