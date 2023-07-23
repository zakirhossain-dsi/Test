select 
	date(violation.created_date) as violationDate,
	time(violation.created_date) as ViolationTime,
	tag_serial_number as tagSerialNumber,
	regis_tag_status as regisTagStatus,
	mlff_status as mlffStatus,
	mlff_transaction_id as txnSerialNum,
	txn.entry_sp_id as entrySpId -- spid means entry sp id?
	txn.entry_plaza_id as entryPlazaId -- Does it mean entry location/plaza?
	txn.entry_gantry_id as entryGantryId,
	txn.entry_timestamp,
	txn.exit_plaza_id,
	txn.exit_gantry_id,
	txn.exit_timestamp,
	txn.tran_amt,
	txn.transaction_status,
	violation.violation_ref_id,
	violation.violation_status,
	violationDetail.violation_code,
	violationCode.violation_category,
	violationDetail.violation_subcode,
	violationsubcode.violation_description,
	violation.supplemental_info,
	violation.vehicle_number,
	violation.vehicle_class,
	vehiclerecognition.vehicle_weight,
	txn.veh_speed,
	violation.regis_vehicle_number,
	violation.regis_vehicle_class,
	paymentnotification.payment_status,
	paymentnotification.pay_method,
	datediff(last_modified_date, created_date) as latePaymentDays,
	txn.tran_amt
from mlff_violations violation
inner join mlff_violation_details violationDetail on violationDetail.violation_ref_id = violation.violation_ref_id
inner join mlff_violation_code violationCode on violationCode.violation_code = violationDetail.violation_code
inner join mlff_violation_subcode violationSubcode on violationSubcode.violation_subcode = violationdetail.violation_subcode
left join mlff_transactions txn on txn.id = violation.mlff_transaction_id
left join mlff_vehicle_recognition vehicleRecognition on vehiclerecognition.id = violation.vehicle_recognition_id
left join mlff_orders mlffOrder on mlfforder.transaction_id_fk = txn.id
left join mlff_payment_notifications paymentNotification on paymentnotification.order_id_fk = mlfforder.id
where violation.created_date >= :beginningOfYesterDay and violation.created_date < :endOfYesterDay;