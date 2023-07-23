SELECT
  mv.violation_ref_id
, mv.created_date
, mv.vehicle_number
, mt.account_no
, mv.mlff_transaction_id
, mt.tran_amt
, mv.violation_status
FROM mlff_violation mv
LEFT JOIN mlff_transactions mt ON mt.id  = mv.mlff_transaction_id
WHERE 1=1
AND mv.vehicle_number = :vehiclePlateNumber -- Optional: If not provided, ignore the filter
AND mv.violation_ref_id = :violationId -- Optional: If not provided, ignore the filter
AND mv.mlff_transaction_id = :transactionSerialNumber -- Optional: If not provided, ignore the filter
AND mt.entry_sp_id = :entrySpId -- Optional: If not provided, ignore the filter
AND mt.exit_sp_id  = :exitSpId -- Optional: If not provided, ignore the filter
-- AND mt.tag_serial_num  = :tagSerialNumber -- Optional: If not provided, ignore the filter
AND mv.created_date >= :startDate -- Optional: If not provided, ignore the filter
AND mv.created_date <= :endDate -- Optional: If not provided, ignore the filter
AND violationDetails.violation_subcode = :violationSubCode -- Optional: If not provided, ignore the filter
AND mt.account_no = :idNumber -- Optional: If not provided, ignore the filter
ORDER BY (mv.violation_status = 'OPEN') DESC, mv.violation_status, mv.create_date DESC