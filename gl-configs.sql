SELECT
    -- Txn Details
    txn.serial_num,
    txn.entry_plaza_id,
    txn.entry_timestamp,
    txn.exit_plaza_id,
    txn.exit_timestamp,
    txn.transaction_status,
    txnType.t_type,
    txn.tran_amt,
    txn.original_amt,
    txn.received_timestamp,
    txn.tc_response_timestamp,
    txn.posted_date,
    txn.response_code,
    txn.response_description,
    txn.error_code_id,
    txn.error_description,

    -- Payment Details
    paymentNotification.payment_id,
    paymentNotification.payment_status,
    paymentOption.payment_method,
    paymentOption.ewallet_id,
    paymentOption.card_num,
    paymentNotification.payment_datetime,
    datediff(coalesce(paymentNotification.payment_datetime, now()), txn.created_date) AS day_late,
    0 AS interest_rate,
    0 AS interest_charge,
    txn.tran_amt AS total_charge,

    -- Vehicle Registration Details
    txn.vehicle_plate_num,
    txn.tag_serial_num,
    txn.vehicle_class,

    -- Vehicle Recognition Details
    txn.vehicle_plate_num,
    txn.vehicle_class,
    vehiclerecognition.vehicle_weight,
    vehiclerecognition.vehicle_speed,
    txn.veh_speed,
    vehiclerecognition.id,
    pairing.pairing_status,
    txn.image_captured,

FROM mlff_transactions txn
INNER JOIN mlff_t_types txnType ON txnType.id = txn.t_type_fk
LEFT JOIN mlff_orders order ON order.transaction_id_fk = txn.id
LEFT JOIN mlff_payment_options paymentOption ON paymentOption.id = order.payment_option_id_fk
LEFT JOIN mlff_payment_notifications paymentNotification ON paymentNotification.order_id_fk = order.id
LEFT JOIN mlff_pairing pairing ON pairing.transaction_id_fk = txn.id
LEFT JOIN mlff_vehicle_recognition vehiclerecognition ON vehiclerecognition.id = pairing.vehicle_recognition_id_fk

WHERE txn.serial_num = :txnSerialNo;