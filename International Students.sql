-- Who are the Graduate students studying for more than 2 years
select *
from international
where Study_level = 'Graduate' and Tenur = 'More than 3 years'

-- Show undergraduate students who are not from South Asia
select Study_level, Region, Funding, GPA
from International
where region != 'South Asia'

-- Show students in order of timestamp
select Timestamp, Study_level, GPA, New_friends, Mental_Health, Stressed
from international
order by Timestamp asc

-- How many students participated
select count(*) as Total_Number
from International

--Which type of students were more likely to feel stressed out
select study_level, Tenur, count(*) as Count
from international
where stressed = 'Always'
group by study_level, tenur
order by 3 desc

-- Of the graduate students from South Asia, how did they classify their friends?
;with Grad_students as (
		select *
			
		from International
		where Study_level = 'Graduate' and Region = 'South Asia'
)
Select Study_level, Region, Type_of_Friends, count(type_of_friends) as [Count of Friend Type]
from Grad_students
group by Region, Type_Of_Friends, Study_level
order by [Count of Friend Type] desc

-- What regions had the highest GPA? Also show how many instances each region shows up
select region, count(region) as [Count of Region]
from International
group by Region
order by [Count of Region] desc

select Region, GPA, count(GPA) as [Count of GPA]
from International
group by region, GPA
order by [Count of GPA] desc

-- Group GPA into buckets 
Select Study_level, 
	Region, 
	GPA, 
	GPA_Group =
		Case
			When GPA = '2.0 - 2.49' then 'Low'
			when GPA = '2.50 - 2.99' then 'Average'
			when GPA = '3.00 - 3.49' then 'Good'
			when GPA = '3.50 - 4.00' then 'Great'
			else 'Terrible'
		End
from International
order by GPA


-- Did mental health contribute to higher GPA?
Select  GPA, Mental_Health, count(*) as [Number of Students]
from International
group by GPA,  Mental_Health 
order by Mental_Health desc


