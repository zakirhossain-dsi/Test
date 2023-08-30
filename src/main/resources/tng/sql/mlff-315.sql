SELECT
    -- Txn Details
    txn.serial_num as txnSerialNum,
    txn.entry_plaza_id as entryLocationId,
    entryLoc.loc_name as entryLocation,
    txn.entry_timestamp as entryTimestamp,
    txn.exit_plaza_id as exitLocationId,
    exitLoc.loc_name as exitLocation,
    txn.exit_timestamp as exitTimestamp,
    txn.transaction_status as transactionStatus,
    txnType.t_type as txnType,
    txn.tran_amt as tranAmt,
    txn.original_amt as originalAmt,
    txn.received_timestamp as receivedTimestamp,
    txn.tc_response_timestamp as tcResponseTimestamp,
    txn.posted_date as postedDate,
    txn.response_code as responseCode,
    txn.response_description as responseDescription,
    txn.error_code_id as errorCodeId,
    txn.error_description as errorDescription,

    -- Payment Details
    paymentNotification.payment_id as paymentRef,
    paymentNotification.payment_status as paymentStatus,
--    paymentOption.payment_option_name as paymentOptionName,
--    paymentOption.payment_method as paymentMethod,
--    paymentOption.ewallet_id as ewalletID,
--    paymentOption.card_num as cardNum,
    paymentNotification.payment_datetime as paymentDatetime,
    datediff(coalesce(paymentNotification.payment_datetime, now()), txn.created_date) AS dayLate,
    0 AS interestRate,
    0 AS interestCharge,
    order.txn_amount AS totaCharge,

    -- Vehicle Registration Details
    txn.vehicle_plate_num as regisVehiclePlateNum,
    txn.tag_serial_num as regisTagSerialNum,
    txn.vehicle_class s regisVehicleClass,

    -- Vehicle Recognition Details
    vehiclerecognition.vehicle_plate_num as detectVehiclePlateNum,
    vehiclerecognition.vehicle_class as detectVehicleClass,
    vehiclerecognition.vehicle_speed as detectVehicleSpeed,
    vehiclerecognition.id as recognitionId,
    vehiclerecognition.recognition_no as recognitionSerialNum,
    vehiclerecognition.anpr_image_file_path as anprImageFilePath,
    pairing.pairing_status as pairingStatus

FROM mlff_transactions txn
INNER JOIN mlff_t_types txnType ON txnType.id = txn.t_type_fk
LEFT JOIN mlff_order_items orderItem ON orderItem.transaction_id_fk = txn.id
LEFT JOIN mlff_orders mlffOrder ON order.id = orderItem.order_id_fk
LEFT JOIN mlff_payment_notifications paymentNotification ON paymentNotification.order_id_fk = mlffOrder.id
LEFT JOIN mlff_pairing pairing ON pairing.transaction_id_fk = txn.id
LEFT JOIN mlff_vehicle_recognition vehiclerecognition ON vehiclerecognition.id = pairing.vehicle_recognition_id_fk
LEFT JOIN mlff_location entryLoc ON entryLoc.id = txn.entry_plaza_id
LEFT JOIN mlff_location exitLoc ON exitLoc.id = txn.exit_plaza_id;

WHERE txn.serial_num = :txnSerialNo;