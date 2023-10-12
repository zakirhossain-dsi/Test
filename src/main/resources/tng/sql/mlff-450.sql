SELECT
    entrySP.account_number AS entrySpAccountNo,
    exitSP.account_number AS exitSpAccountNo,
    t.tag_serial_num,
    t.vehicle_plate_num,
    t.payment_id,
    t.source_of_fund AS sourceOfFund,
     mlffOrder.payment_option_name,
    CASE
        WHEN  t.source_of_fund in ('CC','DD') THEN    t.account_no
        ELSE t.wallet_uuid
    END AS walletUUID,
    t.tc_serial_num,
    t.serial_num,
    mlffOrder.order_number,
    t.id AS tranId,
    t.entry_timestamp,
    t.exit_timestamp,
    t.posted_date,
    t.tran_amt,
    entrySP.sp_id AS entrySpId,
    entrySP.sp_name AS entrySpName,
    exitSP.sp_id AS exitSpId,
    exitSP.sp_name AS exitSpName,
    entryLoc.loc_id AS entryLocId,
    entryLoc.loc_name AS entryLocName,
    exitLoc.loc_id AS exitLocId,
    exitLoc.loc_name AS exitLocName,
    t.error_code_id,
    t.error_description,
    t.has_apportionment,
    t.has_settlement,
    t.processed_timestamp,
    t.received_timestamp,
    t.response_code,
    t.response_description,
    t.response_status,
    t.transaction_status,
    tt.t_type,
    t.revenue_type,
    t.sp_sent_timestamp,
    t.tc_response_timestamp,
    t.tc_transaction_id,
    t.vehicle_class,
    t.std_plan_id,
    t.std_plan_description,
    appsec.description
FROM rpt_transactions t
LEFT JOIN mlff_t_types tt ON tt.id = t.t_type_fk AND tt.deleted = false
LEFT JOIN mlff_service_providers entrySP ON entrySP.sp_id = t.entry_sp_id AND entrySP.deleted = false
LEFT JOIN mlff_locations entryLoc ON entryLoc.loc_id = t.entry_plaza_id AND entryLoc.deleted = false
LEFT JOIN mlff_service_providers exitSP ON exitSP.sp_id = t.exit_sp_id AND exitSP.deleted = false
LEFT JOIN mlff_locations exitLoc ON exitLoc.loc_id = t.exit_plaza_id AND exitLoc.deleted = false
LEFT JOIN mlff_app_sectors appsec ON exitSP.app_sector = appsec.code AND appsec.deleted = false
LEFT join mlff_order_items orderItem ON orderitem.transaction_id_fk = t.id
LEFT join rpt_orders mlffOrder ON mlffOrder.id = orderitem.order_id_fk
WHERE t.posted_date BETWEEN :startDate AND :endDate
AND t.cut_off_date BETWEEN :startDate AND :endDate
AND t.transaction_status = 'PENDING'
ORDER BY t.exit_timestamp, t.received_timestamp, t.posted_date;