SELECT
    t.transaction_id,
    date_format(t.exit_timestamp, '%d-%m-%Y-%T') AS tranDateTime,
    date_format(t.received_timestamp, '%d-%m-%Y-%T') AS receivedDate,
    date_format(t.posted_date, '%d-%m-%Y-%T') AS postedDate,
    t.serial_num AS tranSerialNum,
    t.exit_sp_id AS exitSpId,
    t.exit_plaza_id AS exitLocationID,
    t.exit_lane_id AS exitLaneID,
    t.entry_sp_id AS entrySPID,
    t.entry_plaza_id AS entryLocationId,
    t.account_type AS accountType,
    entrySp.account_number AS entrySpAccountNo,
    entrySp.sp_name AS entrySpName,
    entryLocation.loc_name AS entryLocName,
    exitSp.account_number AS exitSpAccountNo,
    exitSp.sp_name AS exitSpName,
    exitLocation.loc_name AS exitLocName,
    t.vehicle_plate_num AS vehiclePlateNo,
    t.vehicle_class AS vehicleClassInTxnMsg,
    t.vehicle_class_from_vector AS vehicleClassConfigured,
    t.tag_serial_num AS deviceNo,
    tt.t_type AS tType,
    tt.t_type_desc AS txTypeDescription,
    ttg.category AS type,
    ttg.sub_category AS subType,
    tt.debit_credit AS debitCreditIndicator,
    t.tran_amt AS tranAmt,
    t.fare_id AS tollSchdID,
    t.std_plan_id AS planID,
    t.response_code AS statusCode,
    t.error_code_id AS reasonCode,
    t.error_description AS reasonDescription,
    t.payment_type AS paymentType,
    t.source_of_fund AS sourceOfPayment,
    date_format(t.posted_date, '%d-%m-%Y-%T') AS paymentResponseTime,
    t.source_of_fund AS sourceOfPaymentUUID,
    t.payment_id AS paymentID,
    null AS priority,
    orderItem.order_id_fk,
    rptOrder.payment_option_id_fk,
    CASE error_category
        WHEN 'EXTERNAL' THEN '1'
        WHEN 'INTERNAL' THEN '2'
        WHEN 'SUCCESS' THEN '0'
    END AS category
FROM rpt_transactions t
LEFT JOIN mlff_t_types tt ON tt.id = t.t_type_fk AND tt.deleted = false
LEFT JOIN mlff_t_type_groups ttg ON ttg.id = tt.t_type_group_id_fk AND ttg.deleted = false
LEFT JOIN mlff_service_providers entrySp ON entrySp.sp_id = t.entry_sp_id AND entrySp.deleted = false
LEFT JOIN mlff_service_providers exitSp ON exitSp.sp_id = t.exit_sp_id AND exitSp.deleted = false
LEFT JOIN mlff_locations entryLocation ON entryLocation.loc_id = t.entry_plaza_id
LEFT JOIN mlff_locations exitLocation ON exitLocation.loc_id = t.exit_plaza_id
LEFT JOIN mlff_response_codes rc ON rc.error_code_id = t.error_code_id AND t.response_code = rc.error_code_group
LEFT JOIN mlff_order_items orderItem ON orderItem.transaction_id_fk = t.id
LEFT JOIN rpt_orders rptOrder ON rptOrder.id = orderItem.order_id_fk
WHERE t.posted_date BETWEEN :startDate AND :endDate
AND t.cut_off_date BETWEEN :startDate AND :endDate
AND t.transaction_status = 'PENDING'
ORDER BY t.exit_timestamp, t.received_timestamp, t.posted_date
LIMIT :limit OFFSET :offset