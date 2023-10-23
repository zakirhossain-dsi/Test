SELECT
	txn.tag_serial_num,
	txn.vehicle_plate_num,
	txn.vehicle_class,
	txn.entry_plaza_id,
	txn.serial_num,
	entryloc.loc_name,
	txn.exit_plaza_id,
	exitloc.loc_name AS exitLocName,
	appSector.description AS appSectorName ,
	txn.id AS transactionId,
	date_format(txn.posted_date, '%d-%m-%Y %h:%m:%s') AS postedDate,
	txn.tran_amt,
	orderitem.order_id_fk,
	mlfforder.payment_option_id_fk,
	paymentnotification.payment_id,
	paymentnotification.pay_method
FROM mlff_transactions txn
INNER JOIN mlff_txn_data_recon recon ON (txn.id = recon.mlff_txn_id_fk AND recon.txn_recon_status = 'MLFF_ONLY')
LEFT JOIN mlff_locations entryLoc ON entryLoc.loc_id = txn.entry_plaza_id
LEFT JOIN mlff_locations exitLoc ON exitLoc.loc_id = txn.exit_plaza_id
LEFT JOIN mlff_t_types txnType ON txntype.t_type  = txn.transaction_type
LEFT JOIN mlff_app_sectors appSector ON appsector.id  = txntype.app_sector_id_fk
LEFT JOIN mlff_order_items orderItem ON orderitem.transaction_id_fk = txn.id
LEFT JOIN mlff_orders mlffOrder ON mlfforder.id = orderitem.order_id_fk
LEFT JOIN mlff_payment_notifications paymentNotification ON (paymentnotification.order_number = mlfforder.order_number AND paymentnotification.order_status = 'SUCCESS')
LIMIT :limit OFFSET :offset;
