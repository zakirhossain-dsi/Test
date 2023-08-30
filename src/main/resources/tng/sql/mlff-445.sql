select 
	txn.serial_num,
	txn.entry_sp_id,
	txn.entry_plaza_id,
	txn.entry_gantry_id,
	txn.entry_timestamp,
	txn.exit_plaza_id,
	txn.exit_gantry_id,
	txn.exit_timestamp,
	txn.transaction_status,
	txn.tran_amt,
	txn.fare
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
	paymentnotifications.payment_status,
	paymentnotifications.pay_method,
	paymentnotifications.payment_id,
	pairing.pairing_status,
	pairing.vehicle_recognition_id_fk,
	txn.vehicle_plate_num,
	txn.vehicle_class,
	txn.veh_speed,
	txn.is_pilot,
	vehiclerecognition.vehicle_weight,
	vehicleRecognition.recognition_no
	violation.id as violationID,
	CASE
	    WHEN txn.vehicle_plate_num = pairing.reg_veh_plate_num THEN 'Yes'
	    ELSE 'No'
	END AS plate_number_matched
from mlff_transactions txn
inner join mlff_t_types txnType on txntype.id = txn.t_type_fk
left join mlff_orders mlffOrder on mlfforder.transaction_id_fk = txn.id
left join mlff_payment_notifications paymentNotifications on paymentnotifications.order_id_fk = mlfforder.id
left join mlff_pairing pairing on pairing.transaction_id_fk = txn.id
left join mlff_vehicle_recognition vehicleRecognition on vehiclerecognition.id  = pairing.vehicle_recognition_id_fk
left join mlff_violations violation on violation.mlff_transaction_id = txn.id
where txn.created_date >= :beginningOfYesterDay and txn.created_date <= :endOfYesterDay;