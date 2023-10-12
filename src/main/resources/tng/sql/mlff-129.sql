SELECT
    tmp.id,
    tmp.postedDate,
    tmp.businessSector,
    tmp.paymentType,
    tmp.sourceOfFund,
    CASE
        WHEN tmp.sourceOfFund = 'WA' THEN 'N'
        WHEN tmp.t_advancePayment = 'true' THEN 'Y'
        WHEN tmp.t_advancePayment IS NULL OR tmp.t_advancePayment = 'false' THEN 'N'
    END AS advancePayment,
    tmp.paymentId,
    tmp.paymentDatetime,
    tmp.status,
    tmp.tType,
    tmp.tTypeDesc,
    tmp.has_apportionment,
    tmp.fare,
    0 AS interestCharge,
    CASE
        WHEN tmp.tType = 'BR' AND tmp.grossAmount <> 0 THEN tmp.grossAmount * -1
        ELSE tmp.grossAmount
    END AS amt,
    CASE
        WHEN tmp.tType = 'BR' AND tmp.commissionAmount <> 0 THEN tmp.commissionAmount * -1
        ELSE tmp.commissionAmount
    END AS comm,
    CASE
        WHEN tmp.tType = 'BR' AND tmp.gstAmount <> 0 THEN tmp.gstAmount * -1
        ELSE tmp.gstAmount
    END AS tax,
    CASE
        WHEN tType = 'BR' AND tmp.net <> 0 THEN tmp.net * -1.0
        ELSE tmp.net
    END AS netAmount,
    tmp.accountType,
    tmp.deviceNo,
    tmp.vehicleRegNo,
    tmp.walletUUID,
    tmp.entrySpId,
    tmp.entrySpName,
    tmp.entryLocationId,
    tmp.entryLocationName,
    tmp.exitSpId,
    tmp.exitSpName,
    tmp.exitLocationId,
    tmp.exitLocationName,
    tmp.tranDateTime,
    tmp.tc_serial_no,
    tmp.tranSerialNum,
    tmp.ageingReceived,
    tmp.tcReceivedDate,
    tmp.tpmsReceivedDate,
    tmp.exceptionCode,
    tmp.exceptionDescription,
    tmp.riskLevel,
    tmp.categoryException,
    tmp.priority,
    tmp.ageingReportedDate,
    tmp.tp_reason_code,
    tmp.fareSource,
    tmp.vehicleClass,
    MAX(CASE WHEN no = 1 THEN tmp.appt_sp_name END) AS sp_name_1,
    MAX(CASE WHEN no = 1 THEN tmp.appt_sp_acc_no END) AS account_number_1,
    MAX(
        CASE no WHEN 1 THEN
            CASE tmp.tType WHEN 'BR' AND tcFare <> 0 THEN tcFare * -1 ELSE tcFare END
        END
    ) AS fare_1,
    MAX(
        CASE no WHEN 1 THEN
            CASE tmp.tType WHEN 'BR' AND tmp.commissionAmount <> 0 THEN tmp.commissionAmount * -1 ELSE tmp.commissionAmount END
        END
    ) AS commission_1,
    MAX(CASE no WHEN 2 THEN tmp.appt_sp_name END) AS sp_name_2,
    MAX(CASE no WHEN 2 THEN appt_sp_acc_no END) AS account_number_2,
    MAX(
        CASE no WHEN 2 THEN
            CASE tmp.tType WHEN 'BR' AND tcFare <> 0 THEN tcFare * -1 ELSE tcFare END
        END
    ) AS fare_2,
    MAX(
        CASE no WHEN 2 THEN
            CASE tmp.tType WHEN 'BR' AND tmp.commissionAmount <> 0 THEN tmp.commissionAmount * -1 ELSE tmp.commissionAmount END
        END
    ) AS commission_2,
    MAX(CASE no WHEN 3 THEN tmp.appt_sp_name END) AS sp_name_3,
    MAX(CASE no WHEN 3 THEN appt_sp_acc_no END) AS account_number_3,
    MAX(
       CASE no WHEN 3 THEN
           CASE tmp.tType WHEN 'BR' AND tcFare <> 0 THEN tcFare * -1 ELSE tcFare END
       END
    ) AS fare_3,
    MAX(
       CASE no WHEN 3 THEN
           CASE tmp.tType WHEN 'BR' AND tmp.commissionAmount <> 0 THEN tmp.commissionAmount * -1 ELSE tmp.commissionAmount END
       END
    ) AS commission_3,
    MAX(CASE no WHEN 4 THEN tmp.appt_sp_name END) AS sp_name_4,
    MAX(CASE no WHEN 4 THEN appt_sp_acc_no END) AS account_number_4,
    MAX(CASE no WHEN 4 THEN
            CASE tmp.tType WHEN 'BR' AND tcFare <> 0 THEN tcFare * -1 ELSE tcFare END
        END
    ) AS fare_4,
    MAX(CASE no WHEN 4 THEN
            CASE tmp.tType WHEN 'BR' AND tmp.commissionAmount <> 0 THEN tmp.commissionAmount * -1 ELSE tmp.commissionAmount END
        END
    ) AS commission_4,
    MAX(CASE no WHEN 5 THEN tmp.appt_sp_name END) AS sp_name_5,
    MAX(CASE no WHEN 5 THEN appt_sp_acc_no END) AS account_number_5,
    MAX(CASE no WHEN 5 THEN
            CASE tmp.tType WHEN 'BR' AND tcFare <> 0 THEN tcFare * -1 ELSE tcFare END
        END
    ) AS fare_5,
    MAX(CASE no WHEN 5 THEN
            CASE tmp.tType WHEN 'BR' AND tmp.commissionAmount <> 0 THEN tmp.commissionAmount * -1 ELSE tmp.commissionAmount END
        END
    ) AS commission_5,
    tmp.orderId,
    tmp.paymentOptionName,
    tmp.paymentMethod,
    tmp.violationCode,
    tmp.violationSubcode,
    tmp.violationDescription
FROM (
    SELECT
        CASE grp.id
            WHEN @id THEN @row_number := @row_number + 1
            ELSE @row_number := 1
        END AS no,
        @id := grp.id,
        grp.*
    FROM (
        SELECT
            tc.id AS commId,
            t.transaction_id AS id,
            t.posted_date AS postedDate,
            appsec.description AS businessSector,
            t.payment_type AS paymentType,
            CASE
                WHEN t.account_type = 'GOVERNMENT' AND t.account_sub_type = 'EXEMPTED' AND t.transaction_status IN ('SUCCESS', 'ONHOLD_PAID', 'PENDING_PAID', 'PENDING', 'SUCCESS_ROP_PAID','PENDING_ROP_PAID','ONHOLD_ROP_PAID') THEN 'EXEMPTED'
                ELSE t.source_of_fund
            END AS sourceOfFund,
            t.payment_id AS paymentId,
            t.payment_datetime AS paymentDatetime,
            CASE t.transaction_status
                WHEN 'SUCCESS' THEN 'Payable'
                WHEN 'ONHOLD_PAID' THEN 'On-Hold Paid'
                WHEN 'PENDING_PAID' THEN 'Pending Paid'
                WHEN 'PENDING' THEN 'Pending'
                WHEN 'SUCCESS_ROP_PAID' THEN 'Success ROP Paid'
                WHEN 'SUCCESS_ROP_UNPAID' THEN 'Success ROP Unpaid'
                WHEN 'PENDING_ROP_UNPAID' THEN 'Pending ROP Unpaid'
                WHEN 'PENDING_ROP_PAID' THEN 'Pending ROP Paid'
                WHEN 'ONHOLD_ROP_UNPAID' THEN 'Onhold ROP Unpaid'
                WHEN 'ONHOLD_ROP_PAID' THEN 'Onhold ROP Paid'
            END AS status,
            tt.t_type AS tType,
            tt.t_type_desc AS tTypeDesc,
            CASE t.has_apportionment
                WHEN TRUE THEN 'Y'
                WHEN FALSE THEN 'N'
            END AS has_apportionment,
            CASE t.has_apportionment
                WHEN  FALSE THEN t.fare = null
                ELSE t.fare
            END AS fare,
            tc.fare AS tcFare,
            t.tran_amt AS grossAmount,
            tc.commission AS commissionAmount,
            tc.gst AS gstAmount,
            tc.net AS net,
            t.account_type AS accountType,
            t.tag_serial_num AS deviceNo,
            t.vehicle_plate_num AS vehicleRegNo,
            t.advance_payment AS t_advancePayment,
            CASE
                WHEN t.source_of_fund IN ('CC','DD') THEN t.account_no
                ELSE t.wallet_uuid
            END AS walletUUID,
            t.entry_sp_id AS entrySpId,
            esp.sp_name AS entrySpName,
            t.entry_plaza_id AS entryLocationId,
            eloc.loc_name AS entryLocationName,
            t.exit_sp_id AS exitSpId,
            sp.sp_name AS exitSpName,
            sp.account_number AS account_number,
            t.exit_plaza_id AS exitLocationId,
            loc.loc_name AS exitLocationName,
            t.exit_timestamp AS tranDateTime,
            t.tc_serial_num AS tc_serial_no,
            t.serial_num AS tranSerialNum,
            timestampdiff(hour, t.sp_sent_timestamp, received_timestamp) AS ageingReceived,
            t.sp_sent_timestamp AS tcReceivedDate,
            t.received_timestamp AS tpmsReceivedDate,
            rc.error_code_group AS exceptionCode,
            t.error_description AS exceptionDescription,
            "" AS riskLevel,
            rc.error_category AS categoryException,
            "" AS priority,
            timestampdiff(hour, t.received_timestamp, t.created_date) AS ageingReportedDate,
            t.tp_reason_code AS tp_reason_code,
            t.fare_source AS fareSource,
            t.tran_amt AS amount,
            appt_sp.sp_name AS appt_sp_name,
            appt_sp.account_number AS appt_sp_acc_no,
            t.vehicle_class_from_vector AS vehicleClass,
            orderItem.order_id_fk AS orderId,
            mlffOrder.payment_option_name AS paymentOptionName,
            mlffOrder.payment_method AS paymentMethod,
            mvd.violation_code AS violationCode,
            mvd.violation_subcode AS violationSubcode,
            mvs.violation_description AS violationDescription
        FROM rpt_transactions t
        LEFT JOIN mlff_t_types tt ON tt.id = t.t_type_fk AND tt.deleted = false
        LEFT JOIN rpt_transaction_commissions tc ON tc.transaction_id_fk = t.transaction_id AND tc.cut_off_date = t.cut_off_date
        LEFT JOIN mlff_service_providers appt_sp ON appt_sp.sp_id = tc.spid
        LEFT JOIN mlff_service_providers sp ON sp.sp_id = t.exit_sp_id AND sp.deleted = false
        LEFT JOIN mlff_service_providers esp ON esp.sp_id = t.entry_sp_id AND esp.deleted = false
        LEFT JOIN mlff_app_sectors appsec ON sp.app_sector = appsec.code AND appsec.deleted = false
        LEFT JOIN mlff_locations loc ON loc.sp_id = t.exit_sp_id AND loc.loc_id = t.exit_plaza_id AND loc.deleted = false
        LEFT JOIN mlff_locations eloc ON eloc.sp_id = t.entry_sp_id AND eloc.loc_id = t.entry_plaza_id AND eloc.deleted = false
        LEFT JOIN mlff_response_codes rc ON rc.error_code_id = t.error_code_id AND t.response_code = rc.error_code_group
        LEFT JOIN mlff_order_items orderItem ON orderItem.transaction_id_fk = t.id
        LEFT JOIN rpt_orders mlffOrder ON mlffOrder.id = orderItem.order_id_fk
        LEFT JOIN rpt_violations rv on rv.mlff_transaction_id = t.id
        LEFT JOIN mlff_violation_details mvd on mvd.violation_ref_id = rv.id
        LEFT JOIN mlff_violation_subcode mvs on mvs.violation_subcode = mvd.violation_subcode
        WHERE t.cut_off_date BETWEEN :startDate AND :endDate
        AND t.posted_date BETWEEN :startDate AND :endDate
        AND t.transaction_status NOT IN ('ONHOLD','REJECT')
        UNION
        SELECT
            tc.id AS commId,
            t.transaction_id AS id,
            t.posted_date AS postedDate,
            appsec.description AS businessSector,
            t.payment_type AS paymentType,
            CASE
                WHEN t.account_type = 'GOVERNMENT' AND t.account_sub_type = 'EXEMPTED' AND t.transaction_status IN ('SUCCESS', 'ONHOLD_PAID', 'PENDING_PAID', 'PENDING', 'SUCCESS_ROP_PAID','PENDING_ROP_PAID','ONHOLD_ROP_PAID') THEN 'EXEMPTED'
                WHEN t.transaction_status IN ('SUCCESS', 'ONHOLD_PAID', 'PENDING_PAID', 'PENDING', 'SUCCESS_ROP_PAID','PENDING_ROP_PAID','ONHOLD_ROP_PAID') THEN t.source_of_fund
                ELSE NULL
            END AS sourceOfFund,
            t.payment_id AS paymentId,
            t.payment_datetime AS paymentDatetime,
            CASE
                WHEN t.transaction_status = 'ONHOLD' THEN 'On-Hold'
                WHEN t.transaction_status = 'REJECT' THEN 'Non-Payable'
            END AS status,
            tt.t_type AS tType,
            tt.t_type_desc AS tTypeDesc,
            CASE t.has_apportionment
                WHEN TRUE THEN 'Y'
                WHEN FALSE THEN 'N'
            END AS has_apportionment,
            CASE t.has_apportionment
                WHEN  FALSE THEN t.fare = null
                ELSE t.fare
            END AS fare,
            0 AS tcFare,
            0 AS grossAmount,
            0 AS commissionAmount,
            0 AS gstAmount,
            0 AS net,
            t.account_type AS accountType,
            t.tag_serial_num AS deviceNo,
            t.vehicle_plate_num AS vehicleRegNo,
            t.advance_payment AS t_advancePayment,
            CASE
                WHEN t.source_of_fund IN ('CC','DD') THEN t.account_no
                ELSE t.wallet_uuid
            END AS walletUUID,
            t.entry_sp_id AS entrySpId,
            esp.sp_name AS entrySpName,
            t.entry_plaza_id AS entryLocationId,
            eloc.loc_name AS entryLocationName,
            t.exit_sp_id AS exitSpId,
            sp.sp_name AS exitSpName,
            sp.account_number AS account_number,
            t.exit_plaza_id AS exitLocationId,
            loc.loc_name AS exitLocationName,
            t.exit_timestamp AS tranDateTime,
            t.tc_serial_num AS tc_serial_no,
            t.serial_num AS tranSerialNum,
            timestampdiff(hour, t.sp_sent_timestamp, received_timestamp) AS ageingReceived,
            t.received_timestamp AS tcReceivedDate,
            t.received_timestamp AS tpmsReceivedDate,
            rc.error_code_group AS exceptionCode,
            t.error_description AS exceptionDescription,
            "" AS riskLevel,
            rc.error_category AS categoryException,
            "" AS priority,
            timestampdiff(hour, t.received_timestamp, t.created_date) AS ageingReportedDate,
            t.tp_reason_code AS tp_reason_code,
            t.fare_source AS fareSource,
            t.tran_amt AS amount,
            sp.sp_name AS appt_sp_name,
            sp.account_number AS appt_sp_acc_no,
            t.vehicle_class_from_vector AS vehicleClass,
            '' AS orderId,
            '' AS paymentOptionName
            '' AS paymentMethod
            mvd.violation_code AS violationCode,
            mvd.violation_subcode AS violationSubcode,
            mvs.violation_description AS violationDescription
        FROM rpt_transactions t
        LEFT JOIN mlff_t_types tt ON tt.id = t.t_type_fk AND tt.deleted = false
        LEFT JOIN rpt_transaction_commissions tc ON tc.transaction_id_fk = t.transaction_id AND tc.cut_off_date = t.cut_off_date
        LEFT JOIN mlff_service_providers sp ON sp.sp_id = t.exit_sp_id AND sp.deleted = false
        LEFT JOIN mlff_service_providers esp ON esp.sp_id = t.entry_sp_id AND esp.deleted = false
        LEFT JOIN mlff_app_sectors appsec ON sp.app_sector = appsec.code AND appsec.deleted = false
        LEFT JOIN mlff_locations loc ON loc.sp_id = t.exit_sp_id AND loc.loc_id = t.exit_plaza_id AND loc.deleted = false
        LEFT JOIN mlff_locations eloc ON eloc.sp_id = t.entry_sp_id AND eloc.loc_id = t.entry_plaza_id AND eloc.deleted = false
        LEFT JOIN mlff_response_codes rc ON rc.error_code_id = t.error_code_id AND t.response_code = rc.error_code_group
        LEFT JOIN rpt_violations rv on rv.mlff_transaction_id = t.id
        LEFT JOIN mlff_violation_details mvd on mvd.violation_ref_id = rv.id
        LEFT JOIN mlff_violation_subcode mvs on mvs.violation_subcode = mvd.violation_subcode
        WHERE t.cut_off_date BETWEEN :startDate AND :endDate
        AND t.posted_date BETWEEN :startDate AND :endDate
        AND t.transaction_status IN ('ONHOLD','REJECT')
    ) AS grp,
    (SELECT @row_number := 0, @id := '') r
    ORDER BY grp.id ASC
) AS tmp
GROUP BY tmp.id
ORDER BY tmp.tpmsReceivedDate, tmp.postedDate, tmp.businessSector, tmp.exitSpId, tmp.exitLocationId, tmp.status, tmp.tType
LIMIT :limit OFFSET :offset;