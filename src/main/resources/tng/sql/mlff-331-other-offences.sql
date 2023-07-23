SELECT 
	violation.violation_ref_id,
	violation.created_date,
	violation.vehicle_number,
	violation.violation_status,
	group_concat(violationSubCode.violation_subcode SEPARATOR ', ') AS sub_codes,
FROM mlff_violations violation
INNER JOIN mlff_violation_details violationDetail ON violationdetail.violation_ref_id = violation.violation_ref_id
INNER JOIN mlff_transactions txn ON txn.id = violation.mlff_transaction_id
WHERE txn.mx_account_id = :mxAccountId
AND violation.violation_ref_id != :violationId
GROUP BY restricted;