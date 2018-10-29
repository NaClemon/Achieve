use world;

-- Problem 1
select Name, LifeExpectancy
from country
where Continent='Asia' and Population >= 100000000;

-- Problem 2
select Name, Population
from country
order by Population desc
limit 10;

-- Problem 3
select country.Name, city.Name
from country
join city on city.ID = country.Capital
where city.Population >= 5000000;

-- Problem 4
select city.Name, city.Population
from city
join country on country.Name = 'South Korea'
				and country.Code = city.CountryCode
where city.Population >= 1000000;

-- Problem 5
select Name, Continent
from country
where Continent in ('Asia', 'Europe', 'Africa')
		and GNP >= 500000
order by GNP asc;

-- Problem 6
select Name, SurfaceArea/Population as PopulationDensity
from country
where SurfaceArea/Population is not NULL
order by PopulationDensity asc
limit 10;

-- Problem 7
select country.Name, count(city.CountryCode) as CityNum
from country
join city on country.Code = city.CountryCode
where country.Continent = 'Asia'
group by country.Code;

-- Problem 8
select country.Region, country.Name, count(city.CountryCode) as CityNum
from country
join city on country.Code = city.CountryCode
where country.Region in (select Region
				from country
				group by Region
                having avg(Population) >= 50000000)
group by country.Code
having count(city.CountryCode) <> 0
order by CityNum desc;