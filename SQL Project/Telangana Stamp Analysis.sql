# Stamp Registration
# 1. How does the revenue generated from document registration vary across districts 
# in Telangana? List down the top 5 districts that showed the highest document 
# registration revenue growth between FY 2019 and 2022.

select 
    d.district, 
    round(sum(documents_registered_rev)/10000000, 1) as doc_rev_in_cr
from fact_stamps s
join dim_districts d
using (dist_code)
group by d.district
order by doc_rev_in_cr desc
limit 5;


# 2. How does the revenue generated from document registration compare to the revenue 
# generated from e-stamp challans across districts? List down the top 5 districts where
# e-stamps revenue contributes significantly more to the revenue than the documents 
# in FY 2022?

select 
    di.district, 
    (sum(estamps_challans_rev) * 1.0) / 
    round(sum(documents_registered_rev + estamps_challans_rev), 0) 
	as e_stamps_ratio
from fact_stamps s
join dim_districts di
    on di.dist_code = s.dist_code
join dim_date d
    on d.month = s.month
where d.fiscal_year = "2022"
group by di.district
order by e_stamps_ratio desc
limit 5;


# 3. Is there any alteration of e-Stamp challan count and document registration count 
# pattern since the implementation of e-Stamp challan? If so, what suggestions would 
# you propose to the government?

select
    case 
         when month < '2020-12-01' then 'Before'
         else 'After' 
    end as implementation_period,
    round(avg(estamps_challans_cnt), 2) as avg_estamps_challans_count,
    round(avg(documents_registered_cnt), 2) as avg_documents_registered_count
from fact_stamps
group by implementation_period;


# 4. Categorize districts into three segments based on their stamp registration 
# revenue generation during the fiscal year 2021 to 2022.

# I Have solved this in another File 
