SELECT
*
FROM (
    SELECT
        date_format(t.sp_sent_timestamp, '%d-%m-%Y') AS receivedDate,
        date_format(t.posted_date, '%d-%m-%Y') AS postedDate,
        appsec.description AS businessSector,
        tc.spid AS spId,
        sp.account_number AS spAccNo,
        sp.sp_name AS spName,
        '' AS locId,
        '' AS locAcc,
        '' AS locName,
        CASE
            WHEN t.source_of_fund= 'WA' THEN 'CALI'
            ELSE t.source_of_fund
        END AS sourceOfPayment,
        CASE
            WHEN t.source_of_fund ='WA' THEN 'TNGD'
            ELSE t.source_of_fund
            END AS sourceOfPayment1,
        CASE t.transaction_status
            WHEN 'SUCCESS' THEN 'Payable'
            WHEN 'ONHOLD_PAID' THEN 'On-Hold Paid'
            WHEN 'PENDING_PAID' THEN 'Pending Paid'
            WHEN 'PENDING' THEN 'Pending'
            WHEN 'SUCCESS_ROP_PAID' THEN 'Success ROP Paid'
            WHEN 'SUCCESS_ROP_UNPAID' THEN 'Success ROP Unpaid'
            WHEN 'PENDING_ROP_UNPAID' THEN 'Pending ROP Unpaid'
            WHEN 'PENDING_ROP_PAID' THEN 'Pending ROP Paid'
            WHEN 'ONHOLD_ROP_UNPAID' THEN 'Onhold ROP Unpaid'
            WHEN 'ONHOLD_ROP_PAID' THEN 'Onhold ROP Paid'
        END AS status,
        tt.t_type AS tType,
        tt.debit_credit AS debitOrCredit,
        tt.t_type_desc AS tTypeDesc,
        '1' AS tTypeCategory,
        Count(*) AS totalTransactions,
        Sum(Cast((CASE WHEN t.transaction_status IN ('SUCCESS', 'ONHOLD_PAID', 'PENDING_PAID', 'SUCCESS_ROP_PAID', 'PENDING_ROP_PAID', 'ONHOLD_ROP_PAID') THEN (CASE WHEN tt.debit_credit = 'C' THEN tc.fare * -1 ELSE tc.fare END) ELSE 0 END) AS DECIMAL(12, 5))) AS totalGross,
        Sum(Cast((CASE WHEN t.transaction_status IN ('SUCCESS', 'ONHOLD_PAID', 'PENDING_PAID', 'SUCCESS_ROP_PAID', 'PENDING_ROP_PAID', 'ONHOLD_ROP_PAID') THEN (CASE WHEN tt.debit_credit = 'C' THEN tc.commission * -1 ELSE tc.commission END) ELSE 0 END) AS DECIMAL(12, 5))) AS totalComm,
        Sum(Cast((CASE WHEN t.transaction_status IN ('SUCCESS', 'ONHOLD_PAID', 'PENDING_PAID', 'SUCCESS_ROP_PAID', 'PENDING_ROP_PAID', 'ONHOLD_ROP_PAID') THEN (CASE WHEN tt.debit_credit = 'C' THEN tc.gst * -1 ELSE tc.gst END) ELSE 0 END) AS DECIMAL(12, 5))) AS totalGst,
        Sum(Cast((CASE WHEN t.transaction_status IN ('SUCCESS', 'ONHOLD_PAID', 'PENDING_PAID', 'SUCCESS_ROP_PAID', 'PENDING_ROP_PAID', 'ONHOLD_ROP_PAID') THEN(CASE WHEN tt.debit_credit = 'C' THEN tc.net * -1 ELSE tc.net END) ELSE 0 END) AS DECIMAL(12, 5))) AS totalNet
    FROM rpt_transactions t
    LEFT JOIN rpt_transaction_commissions tc ON tc.transaction_id_fk = t.transaction_id AND tc.cut_off_date BETWEEN :startDate AND :endDate
    LEFT JOIN mlff_service_providers sp ON sp.sp_id = tc.spid AND sp.deleted = false AND sp.deleted = false
    LEFT JOIN mlff_app_sectors appsec ON sp.app_sector = appsec.code AND sp.deleted = false
    LEFT JOIN mlff_t_types tt ON tt.id = t.t_type_fk
    WHERE t.posted_date BETWEEN  :startDate AND  :endDate
    AND t.cut_off_date BETWEEN  :startDate AND  :endDate
    AND t.transaction_status NOT IN ('ONHOLD', 'REJECT')
    GROUP BY tc.spid, DATE(t.posted_date), t.transaction_status, tt.id, sourceOfPayment
    UNION
    SELECT
        date_format(t.sp_sent_timestamp, '%d-%m-%Y') AS receivedDate,
        date_format(t.posted_date, '%d-%m-%Y') AS postedDate,
        appsec.description AS businessSector,
        sp.sp_id AS spId,
        sp.account_number AS spAccNo,
        sp.sp_name AS spName,
        '' AS locName,
        '' AS locAcc,
        '' AS locId,
        CASE t.source_of_fund
            WHEN 'WA' THEN 'CALI' ELSE t.source_of_fund
        END AS sourceOfPayment,
        CASE t.source_of_fund
            WHEN 'WA' THEN 'TNGD' ELSE t.source_of_fund
        END AS sourceOfPayment1,
        CASE t.transaction_status
            WHEN 'ONHOLD' THEN 'On-Hold'
            WHEN 'REJECT' THEN 'Non-Payable'
        END AS status,
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
    LEFT JOIN mlff_service_providers sp ON sp.sp_id = t.exit_sp_id AND sp.deleted = false
    LEFT JOIN mlff_app_sectors appsec ON sp.app_sector = appsec.code AND sp.deleted = false
    LEFT JOIN mlff_t_types tt ON tt.id = t.t_type_fk
    WHERE t.posted_date BETWEEN  :startDate AND  :endDate
    AND t.cut_off_date BETWEEN  :startDate AND  :endDate
    AND t.transaction_status IN ('ONHOLD', 'REJECT')
    GROUP BY sp.sp_id, DATE(t.posted_date), t.transaction_status, tt.id, sourceOfPayment
) x
ORDER BY x.postedDate, x.spId,
CASE x.status
    WHEN 'Payable' THEN 1
    WHEN 'Pending Paid' THEN 2
    WHEN 'On-Hold Paid' THEN 3
    WHEN 'Pending' THEN 4
    WHEN 'On-Hold' THEN 5
    WHEN 'Non-Payable' THEN 6
END ASC
LIMIT :limit OFFSET :offset