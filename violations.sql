SELECT
  txn.image_captured AS anprImage
, violation.violation_ref_id AS violationId
, violation.created_date AS violationDate
, txn.id AS transactionSerialNumber
, violation.violationStatus
, txn.tran_amnt AS transactionAmount
, txn.transaction_status AS transactionStatus
, txn.entry_plaza_id
, txn.entry_timestamp AS entryTime
, txn.exit_plaza_id
, txn.exit_timestamp AS exitTime
, violation.vehicle_number AS detectedVehiclePlateNumber
-- detected vehicle model?
-- detected vehicle make?
, violation.vehicle_class AS detectedVehicleClass
, txn.veh_speed AS detectedVehicleSpeed
, vehicleRecognition.vehicle_weight AS detectedVehicleWeight
FROM mlff_violation violation
LEFT JOIN mlff_transactions txn ON txn.id  = violation.mlff_transaction_id
LEFT JOIN mlff_vehicle_recognitions vehicleRecognition ON vehicleRecognition.vehicle_recognition_id = violation.vehicle_recognition_id
WHERE violation.violation_ref_id = :violationId