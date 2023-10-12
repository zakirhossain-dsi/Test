select
	txn.serial_num,
	txn.exit_sp_id,
	entryLocation.loc_name as entryLocName,
	txn.entry_gantry_id,
	txn.entry_timestamp,
	txn.exit_plaza_id,
	txn.exit_gantry_id,
	txn.exit_timestamp,
	exitLocation.loc_name as exitLocName,
	txn.transaction_status,
	txn.tran_amt,
	txn.fare,
	txntype.t_type,
	txntype.t_type_desc,
	txn.received_timestamp,
	txn.tc_response_timestamp,
	txn.posted_date,
	txn.response_code,
	txn.response_description,
	txn.error_code_id,
	txn.error_description,
	txn.tag_serial_num,
	txn.vehicle_plate_num,
	txn.vehicle_class,
	txn.payment_datetime,
	paymentnotification.payment_status,
	paymentnotification.pay_method,
	paymentnotification.payment_id,
	pairing.pairing_status,
	pairing.vehicle_recognition_id_fk,
	txn.vehicle_class,
	txn.veh_speed,
	txn.is_pilot,
	vehiclerecognition.vehicle_weight,
	vehicleRecognition.recognition_no,
	violation.id as violationID,
	paymentnotification.pay_method,
	mlffOrder.payment_option_id_fk,
	mlffOrder.payment_option_name,
    CASE
        WHEN t.source_of_fund IN ('CC','DD') THEN t.account_no
        ELSE t.wallet_uuid
    END AS walletUUID
from rpt_transactions txn
inner join mlff_t_types txnType on txntype.t_type = txn.transaction_type
left join mlff_locations entryLocation on entrylocation.loc_id = txn.entry_plaza_id
left join mlff_locations exitLocation on exitLocation.loc_id = txn.exit_plaza_id
left join mlff_order_items orderItem on orderitem.transaction_id_fk = txn.id
left join rpt_orders mlffOrder on mlffOrder.id = orderitem.order_id_fk
left join rpt_payment_notifications paymentNotification on paymentnotification.order_id_fk = mlffOrder.id
left join mlff_pairing pairing on pairing.transaction_id_fk = txn.id
left join rpt_vehicle_recognition vehicleRecognition on vehiclerecognition.id  = pairing.vehicle_recognition_id_fk
left join rpt_violations violation on violation.mlff_transaction_id = txn.id
where txn.created_date BETWEEN :startDate AND :endDat
LIMIT ? OFFSET ?