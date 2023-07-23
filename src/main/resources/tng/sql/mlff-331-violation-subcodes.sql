SELECT 
  violationCode.violation_category,
  violationSubCode.violation_subcode,
  violationSubCode.violation_description
FROM mlff_violation_details violationDetails
INNER JOIN mlff_violation_code violationCode ON violationcode.violation_code = violationdetails.violation_code
INNER JOIN mlff_violation_subcode violationSubCode ON violationsubcode.violation_code = violationcode.violation_code
WHERE violationdetails.violation_ref_id = :violationId