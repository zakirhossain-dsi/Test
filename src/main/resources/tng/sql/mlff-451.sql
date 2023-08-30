select 
	txn.created_date,
	txn.tag_serial_num,
	txn.vehicle_plate_num,
	txn.vehicle_class,
	paymentnotification.pay_method,
	appsector.code,
	txn.entry_plaza_id,
	txn.entry_gantry_id,
	txn.exit_plaza_id,
	txn.exit_gantry_id,
	txn.serial_num,
	paymentnotification.id as paymentReferenceNo,
	txn.processed_timestamp,
	txn.tran_amt
from mlff_transactions txn
inner join mlff_t_types txnType on txntype.id  = txn.t_type_fk
inner join mlff_app_sectors appSector on appsector.id  = txntype.app_sector_id_fk
left join mlff_orders mlffOrder on mlfforder.transaction_id_fk = txn.id
left join mlff_payment_notifications paymentNotification on paymentnotifications.order_id_fk = mlfforder.id
where txn.transaction_status in ('PENDING_PAID', 'ONHOLD_PAID', 'SUCCESS')
and txn.created_date >= :beginningOfLastMonth and txn.created_date <= :endOfLastMonth;