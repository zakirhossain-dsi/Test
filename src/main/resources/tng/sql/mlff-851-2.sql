SELECT
    pgTxn.cust_name AS custName,
    pgTxn.cust_phone AS custPhone,
    pgTxn.cust_email AS custEmail,
    pgTxn.cust_method AS pymtMethod,
    pgTxn.cust_holder AS cardHolder,
    pgTxn.card_pan AS cardPan,
    pgTxn.issuing_bank AS issuingBank,
    pgTxn.amount AS amount,
    pgTxn.tot_refund_amt AS totRefundAmt
FROM mlff_pg_settlement_transactions pgTxn
INNER JOIN mlff_txn_data_recon recon ON pgTxn.id = recon.pg_settlement_txn_id_fk
WHERE recon.txn_recon_status = 'PG_ONLY'
LIMIT :limit OFFSET :offset;