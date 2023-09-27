select

from mlff_summarized_balance_sheets
where posted_date = :yesterDay
and active = 1 and deleted = 0 and is_payable = 1
group by sp_id, desc_text
order by line_no