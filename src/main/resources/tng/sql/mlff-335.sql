SELECT 
	vehicleType.name AS vehicleType,
	vehicleMake.name AS vehicleMake,
	vehicleModel.name AS vehicleModel,
	vehicle.vehicle_manufacturing_year AS vehicleYear,
	vehicle.plate_number AS vehiclePlateNumber,
	DATE(tag.start_active_datetime) AS rfidActivationDate,
	TIME(tag.start_active_datetime) AS rfidActivationTime,
	sof.mlff_status AS mlffStatus,
	DATE(sof.effective_date) AS mlffEnableDate,
	TIME(sof.effective_date) AS mlffEnableTime,
	tag.is_active AS isActiveTag,
	tag.last_modified_date
FROM tags tag
INNER JOIN vehicles vehicle ON vehicle.id  = tag.vehicle_id
INNER JOIN vehicle_types vehicleType ON vehicleType.id = vehicle.vehicle_type_id
INNER JOIN vehicle_makes vehicleMake ON vehicleMake.id = vehicle.vehicle_make_id
INNER JOIN vehicle_models vehicleModel ON vehicleModel.id = vehicle.vehicle_model_id
LEFT JOIN mlff_sof sof ON sof.tag_serial_num = tag.tag_serial_no
WHERE tag.tag_serial_no = :tagSerialNumber
ORDER BY tag.is_active DESC, tag.last_modified_date DESC;