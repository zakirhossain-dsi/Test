SELECT
    t.exit_timestamp,
    t.received_timestamp,
    t.posted_date,
    t.serial_num,
    entrySP.account_number AS entrySpAccountNo,
    entrySP.sp_id AS entrySpId,
    entrySP.sp_name AS entrySpName,
    exitSP.account_number AS exitSpAccountNo,
    exitSP.sp_id AS exitSpId,
    exitSP.sp_name AS exitSpName,
    entryLoc.loc_id AS entryLocId,
    entryLoc.loc_name AS entryLocName,
    exitLoc.loc_id AS exitLocId,
    exitLoc.loc_name AS exitLocName,
    t.tag_serial_num,
    t.vehicle_plate_num,
    t.vehicle_class,
    tt.t_type,
    tt.t_type_desc,
    ttg.category,
    ttg.sub_category,
    tt.debit_credit,
    rptOrder.order_number,
    t.id AS tranId,
    t.tran_amt,
    t.std_plan_id,
    paymentRequest.payment_id,
    paymentRequest.payment_method,
    rptOrder.payment_option_name,
    CASE
        WHEN  t.source_of_fund in ('CC','DD') THEN    t.account_no
        ELSE t.wallet_uuid
    END AS walletUUID,
    t.posted_date AS paymentResponseTime,
    t.error_code_id,
    t.response_code,
    t.error_description
FROM rpt_transactions t
LEFT JOIN mlff_t_types tt ON tt.id = t.t_type_fk AND tt.deleted = false
LEFT JOIN mlff_t_type_groups ttg ON ttg.id = tt.t_type_group_id_fk AND ttg.deleted = false
LEFT JOIN mlff_service_providers entrySP ON entrySP.sp_id = t.entry_sp_id AND entrySP.deleted = false
LEFT JOIN mlff_locations entryLoc ON entryLoc.loc_id = t.entry_plaza_id AND entryLoc.deleted = false
LEFT JOIN mlff_service_providers exitSP ON exitSP.sp_id = t.exit_sp_id AND exitSP.deleted = false
LEFT JOIN mlff_locations exitLoc ON exitLoc.loc_id = t.exit_plaza_id AND exitLoc.deleted = false
LEFT JOIN mlff_order_items orderItem ON orderitem.transaction_id_fk = t.id
LEFT JOIN rpt_orders rptOrder ON rptOrder.id = orderitem.order_id_fk
LEFT JOIN mlff_payment_request paymentRequest ON paymentRequest.order_number = rptOrder.order_number
WHERE t.posted_date BETWEEN :startDate AND :endDate
AND t.cut_off_date BETWEEN :startDate AND :endDate
AND t.transaction_status = 'ONHOLD'
ORDER BY t.exit_timestamp, t.received_timestamp, t.posted_date;