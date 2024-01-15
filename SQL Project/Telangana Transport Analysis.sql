# Transportation
# 5. Investigate whether there is any correlation between vehicle sales and 
# specific months or seasons in different districts. Are there any months 
# or seasons that consistently show higher or lower sales rate, and if yes, 
# what could be the driving factors? (Consider Fuel-Type category only)

select 
	di.district,
    da.mmm as month, 
    round(avg(fuel_type_petrol), 2) as avg_petrol_sales, 
    round(avg(fuel_type_diesel), 2) as avg_diesel_sales, 
    round(avg(fuel_type_electric), 2) as avg_electric_sales, 
    round(avg(fuel_type_others), 2) as avg_others_sales
from fact_transport t
join dim_date da 
    on t.month = da.month
join dim_districts di 
    on di.dist_code = t.dist_code
group by di.district, month
order by di.district, month;


# 6. How does the distribution of vehicles vary by vehicle class (MotorCycle, 
# MotorCar, AutoRickshaw, Agriculture) across different districts? Are there any 
# districts with a predominant preference for a specific vehicle class? Consider 
# FY 2022 for analysis.

select 
	di.district, 
    sum(vehicleClass_MotorCar) as cnt_MotorCar, 
    sum(vehicleClass_MotorCycle) as cnt_MotorCycle, 
    sum(vehicleClass_AutoRickshaw) as cnt_AutoRickshaw, 
    sum(vehicleClass_Agriculture) as cnt_Agriculture, 
    sum(vehicleClass_others) as cnt_others
from fact_transport t 
join dim_districts di
	using (dist_code)
join dim_date ds 
    using (month)
where fiscal_year = "2022"
group by di.district;

# 7. List down the top 3 and bottom 3 districts that have shown the highest and 
# lowest vehicle sales growth during FY 2022 compared to FY 2021? (Consider and 
# compare categories: Petrol, Diesel and Electric)

# I Have solved this in another File 
