SELECT
    x.receivedDate,
    x.postedDate,
    x.businessSector,
    x.sourceOfFund,
    x.status,
    x.tType,
    x.debitOrCredit,
    x.tTypeDesc,
    x.tTypeCategory,
    x.totalTransactions,
    x.totalGross,
    x.totalComm,
    x.totalGst,
    x.totalNet,
    x.sourceOfFund
 FROM (
    SELECT
        date_format(t.sp_sent_timestamp, '%d-%m-%Y') AS receivedDate,
        date_format(t.posted_date, '%d-%m-%Y') AS postedDate,
        appsec.description AS businessSector,
        CASE
            WHEN t.account_type = 'GOVERNMENT' AND t.account_sub_type = 'EXEMPTED' AND t.transaction_status IN ('SUCCESS', 'ONHOLD_PAID', 'PENDING_PAID', 'PENDING','SUCCESS_ROP_PAID','PENDING_ROP_PAID','ONHOLD_ROP_PAID') THEN 'EXEMPTED'
            ELSE t.source_of_fund
        END AS sourceOfFund,
        CASE
            WHEN t.transaction_status = 'SUCCESS' THEN 'Payable'
            WHEN t.transaction_status = 'ONHOLD_PAID' THEN 'On-Hold Paid'
            WHEN t.transaction_status = 'PENDING_PAID' THEN 'Pending Paid'
            WHEN t.transaction_status = 'PENDING' THEN 'Pending'
            WHEN t.transaction_status = 'SUCCESS_ROP_PAID' THEN 'Success ROP Paid'
            WHEN t.transaction_status = 'SUCCESS_ROP_UNPAID' THEN 'Success ROP Unpaid'
            WHEN t.transaction_status = 'PENDING_ROP_UNPAID' THEN 'Pending ROP Unpaid'
            WHEN t.transaction_status = 'PENDING_ROP_PAID' THEN 'Pending ROP Paid'
            WHEN t.transaction_status = 'ONHOLD_ROP_UNPAID' THEN 'Onhold ROP Unpaid'
            WHEN t.transaction_status = 'ONHOLD_ROP_PAID' THEN 'Onhold ROP Paid'
        END AS status,
        tt.t_type AS tType,
        tt.debit_credit AS debitOrCredit,
        tt.t_type_desc AS tTypeDesc,
        '1' AS tTypeCategory,
        Count(*) AS totalTransactions,
        SUM(CAST((CASE WHEN t.transaction_status IN ('SUCCESS', 'ONHOLD_PAID', 'PENDING_PAID', 'SUCCESS_ROP_PAID', 'PENDING_ROP_PAID', 'ONHOLD_ROP_PAID') THEN (CASE WHEN tt.debit_credit = 'C' THEN tc.fare * -1 ELSE tc.fare END) ELSE 0 END) AS DECIMAL(12, 5))) AS totalGross,
        SUM(CAST((CASE WHEN t.transaction_status IN ('SUCCESS', 'ONHOLD_PAID', 'PENDING_PAID', 'SUCCESS_ROP_PAID', 'PENDING_ROP_PAID', 'ONHOLD_ROP_PAID') THEN (CASE WHEN tt.debit_credit = 'C' THEN tc.commission * -1 ELSE tc.commission END) ELSE 0 END) AS DECIMAL(12, 5))) AS totalComm,
        SUM(CAST((CASE WHEN t.transaction_status IN ('SUCCESS', 'ONHOLD_PAID', 'PENDING_PAID', 'SUCCESS_ROP_PAID', 'PENDING_ROP_PAID', 'ONHOLD_ROP_PAID') THEN (CASE WHEN tt.debit_credit = 'C' THEN tc.gst * -1 ELSE tc.gst END) ELSE 0 END) AS DECIMAL(12, 5))) AS totalGst,
        SUM(CAST((CASE WHEN t.transaction_status IN ('SUCCESS', 'ONHOLD_PAID', 'PENDING_PAID', 'SUCCESS_ROP_PAID', 'PENDING_ROP_PAID', 'ONHOLD_ROP_PAID') THEN (CASE WHEN tt.debit_credit = 'C' THEN tc.net * -1 ELSE tc.net END) ELSE 0 END) AS DECIMAL(12, 5))) AS totalNet
    FROM rpt_transactions t
    LEFT JOIN rpt_transaction_commissions tc ON tc.transaction_id_fk = t.transaction_id AND tc.cut_off_date BETWEEN :startDate AND  :endDate
    LEFT JOIN mdt_service_providers sp ON sp.sp_id = t.exit_sp_id AND sp.deleted = false AND sp.deleted = false
    LEFT JOIN mdt_app_sectors appsec ON sp.app_sector = appsec.code AND sp.deleted = false
    LEFT JOIN mdt_t_types tt ON tt.id = t.t_type_fk
    WHERE DATE(t.posted_date) BETWEEN :startDate AND  :endDate
    AND t.cut_off_date BETWEEN :startDate AND  :endDate
    AND t.transaction_status NOT IN ('ONHOLD', 'REJECT')
    GROUP BY  DATE(t.posted_date), appsec.description, sourceOfFund, t.transaction_status, tt.id
    UNION
    SELECT
      date_format(t.sp_sent_timestamp, '%d-%m-%Y') AS receivedDate,
      date_format(t.posted_date, '%d-%m-%Y') AS postedDate,
      appsec.description AS businessSector,
      CASE
        WHEN t.account_type = 'GOVERNMENT' AND t.account_sub_type = 'EXEMPTED' AND t.transaction_status IN ('SUCCESS', 'ONHOLD_PAID', 'PENDING_PAID', 'PENDING', 'SUCCESS_ROP_PAID', 'PENDING_ROP_PAID', 'ONHOLD_ROP_PAID') THEN 'EXEMPTED'
        ELSE t.source_of_fund
      END AS sourceOfFund,
      CASE
        WHEN t.transaction_status = 'REJECT' THEN 'Non-Payable'
        WHEN t.transaction_status = 'ONHOLD' THEN 'On-Hold'
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
    LEFT JOIN mdt_service_providers sp ON sp.sp_id = t.exit_sp_id AND sp.deleted = false
    LEFT JOIN mdt_app_sectors appsec ON sp.app_sector = appsec.code AND sp.deleted = false
    LEFT JOIN mdt_t_types tt ON tt.id = t.t_type_fk
    WHERE DATE(t.posted_date) BETWEEN :startDate AND  :endDate
    AND t.cut_off_date BETWEEN :startDate AND  :endDate
    AND t.transaction_status IN ('ONHOLD', 'REJECT')
    GROUP BY  DATE(t.posted_date), appsec.description, sourceOfFund, t.transaction_status, tt.id
) x
ORDER BY x.postedDate, sourceOfFund,
CASE
    WHEN x.status = 'Payable' THEN 1
    WHEN x.status = 'Pending Paid' THEN 2
    WHEN x.status = 'On-Hold Paid' THEN 3
    WHEN x.status = 'Pending' THEN 4
    WHEN x.status = 'On-Hold' THEN 5
    WHEN x.status = 'Non-Payable' THEN 6
END ASC;