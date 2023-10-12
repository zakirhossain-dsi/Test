select 
	date(violation.created_date) as violationDate,
	time(violation.created_date) as ViolationTime,
	violation.tag_serial_number as tagSerialNumber,
	regis_tag_status as regisTagStatus,
	mlff_status as mlffStatus,
	txn.serial_num as txnSerialNum,
	txn.exit_sp_id as exitSpId,
	entryLocation.loc_name as entryLocName,
	txn.entry_gantry_id as entryGantryId,
	txn.entry_timestamp,
	exitLocation.loc_name as exitLocName,
	txn.exit_gantry_id,
	txn.exit_timestamp,
	txn.tran_amt,
	txn.transaction_status,
	violation.violation_ref_id,
	violation.violation_status,
	violationDetail.violation_code,
	violationCode.violation_category,
	violationDetail.violation_subcode,
	violationSubcode.violation_description,
	violation.supplemental_info,
	violation.vehicle_number,
	violation.vehicle_class,
	vehicleRecognition.vehicle_weight,
	txn.veh_speed,
	violation.regis_vehicle_number,
	violation.regis_vehicle_class,
	mlffOrder.payment_option_id_fk,
	mlffOrder.payment_option_name,
	paymentNotification.payment_status,
	paymentNotification.pay_method,
	datediff(txn.created_date, txn.payment_datetime) as latePaymentDays,
	txn.tran_amt,
    txn.is_pilot
from rpt_violations violation
inner join mlff_violation_details violationDetail on violationDetail.violation_ref_id = violation.violation_ref_id
inner join mlff_violation_code violationCode on violationCode.violation_code = violationDetail.violation_code
inner join mlff_violation_subcode violationSubcode on violationSubcode.violation_subcode = violationDetail.violation_subcode
left join rpt_transactions txn on txn.id = violation.mlff_transaction_id
left join mlff_locations entryLocation on entrylocation.loc_id = txn.entry_plaza_id
left join mlff_locations exitLocation on exitLocation.loc_id = txn.exit_plaza_id
left join rpt_vehicle_recognition vehicleRecognition on vehicleRecognition.id = violation.vehicle_recognition_id
left join mlff_order_items orderItem on orderitem.transaction_id_fk = txn.id
left join rpt_orders mlffOrder on mlffOrder.id = orderitem.order_id_fk
left join rpt_payment_notifications paymentNotification on paymentnotification.order_id_fk = mlffOrder.id
where violation.created_date BETWEEN :startDate AND :endDat
LIMIT ? OFFSET ?