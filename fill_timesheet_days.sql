PROMPT Use hint: export as Delimited (tab) without headline!

WITH magic as (
  select 0 as adjust_by_months
    , 7 - to_char( add_months( trunc( sysdate, 'year'), 0), 'd'  ) + 1 as days_in_week1
  from dual
),
cal1 as (
	select add_months( trunc(sysdate, 'mon') , adjust_by_months ) 
    + rownum - 1 as day
  , magic.adjust_by_months
  , magic.days_in_week1
from dual 
cross join magic 
	connect by level <= 31
), cal2 as (
select day
  , to_char( day, 'w?') ora_kw  -- not what I expect!
  , to_char( day, 'd') day_of_week
  , to_char( day, 'ddd') day_of_year
  , adjust_by_months
  , days_in_week1
from cal1
where 1=1
--  and day <= add_months( trunc( sysdate, 'mon') , 1 )-1
  and day <= add_months( trunc( sysdate, 'mon') , adjust_by_months + 1 )
),  cal3 as (
  select cal2.*
    , trunc ( to_number( to_char( day, 'ddd') + (7 - days_In_week1 ) ) / 7  ) + 1 my_week_no 
  from cal2
)
select 
  to_char(day, 'dd.mm.yyyy') as "Tag"
--, day_of_year, days_in_week1, my_week_No, ora_kw
, case when to_char(day, 'd') in ('6', '7') then null
  else 
    case 
    when days_in_week1 < 4 -- Thursday is not in the first week, adjust week number 
    then decode (my_week_no , 1 , 53 , my_week_no -1 )
    else my_week_no -- no adjustment needed 
    end 
  end as "kalWo"
from cal3
where 1=1 
--  and day_of_week between 1 and 5
order by day asc  
;