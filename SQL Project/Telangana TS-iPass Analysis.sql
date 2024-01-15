# 8. List down the top 5 sectors that have witnessed the most significant 
# investments in FY 2022.

select 
	sector,  
    round(sum(investment_in_cr), 2) as investment_CR
from fact_ts_ipass ts
join dim_date_1 d1
	on d1.month = ts.month
where d1.fiscal_year = 2022
group by sector
order by investment_CR desc
limit 5;


# 9. List down the top 3 districts that have attracted the most significant sector 
# investments during FY 2019 to 2022? What factors could have led to the substantial 
# investments in these particular districts?

select 
	di.district,
    ts.sector, 
    round(sum(investment_in_cr), 2) as investment_CR
from fact_ts_ipass ts 
join dim_districts di 
    on di.dist_code = ts.dist_code
group by di.district, ts.sector 
order by investment_CR desc
limit 5; 


# 10. Is there any relationship between district investments, vehicles sales and 
# stamps revenue within the same district between FY 2021 and 2022?

# I Have solved this in another File 

# 11. Are there any particular sectors that have shown substantial investment in 
# multiple districts between FY 2021 and 2022?

select 
	ts.sector,
    di.district, 
    round(sum(investment_in_cr), 2) as Total_investment_CR
from fact_ts_ipass ts 
join dim_districts di 
    using (dist_code)
join dim_date_1 da 
    using (month)
where da.fiscal_year >= 2021 
group by ts.sector, di.district 
order by sector , Total_investment_CR desc; 

# 2 
select 
	sector, 
    count(di.district) as districts_with_substantial_investments
from fact_ts_ipass ts 
join dim_districts di 
	using (dist_code)
join dim_date_1 da 
	using (month)
where da.fiscal_year between '2021' and '2022'
group by sector 
having sum(investment_in_cr) > 1000
order by districts_with_substantial_investments desc; 
 

# 12. Can we identify any seasonal patterns or cyclicality in the investment trends 
# for specific sectors? Do certain sectors experience higher investments during 
# particular months?

select 
	mmm as month_name,
    sector, 
    round(avg(investment_in_cr), 2) as avg_invest_cr
from fact_ts_ipass ts 
join dim_date_1 da 
    using (month)
where fiscal_year = "2022"
group by month_name, sector 
order by avg_invest_cr desc
