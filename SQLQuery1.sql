with hotels as(
select * from dbo.['2018$']
union
select * from dbo.['2019$']
union
select * from dbo.['2020$'])

select * from hotels
left join dbo.market_segment$
on market_segment$.market_segment = hotels.market_segment 
left join dbo.meal_cost$
on meal_cost$.meal = hotels.meal


