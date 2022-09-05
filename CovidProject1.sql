select * from covid_deaths
order by 3,4;

select * from covid_vaccinations
order by 3,4;

/* Select the data that we will be using */

select place, date, total_cases, new_cases, total_deaths, population
from covid_deaths
order by 1,2;

/* Looking at total_cases versus total_deaths */

/* I had to add the function "cast" before the calculation of the death rate since both
the total_cases and total_deaths are integers and give the result as an integer of 0.
Putting "cast" before the calculation convert the result death_rate from an integer to 
a float. */

select place, date, total_cases, total_deaths, 
cast(total_deaths as float)/total_cases * 100 as death_rate
from covid_deaths
order by 1,2;

/* Looking at total_cases versus total_deaths in Canada*/

/* Shows likelihood of dying if you contract Covid in Canada.*/

select place, date, total_cases, total_deaths, 
cast(total_deaths as float)/total_cases * 100 as death_rate
from covid_deaths
where place like 'Canada'
order by 1,2;

/* Looking at total_cases versus population. */
/* Shows the percentage of population that contracted Covid. */

select place, date, population, total_cases,  
cast(total_cases as float)/population * 100 as infection_rate
from covid_deaths
where place like 'Canada'
order by 1,2;

/* Countries with the highest infection rate compared to population. */

select place, population, max(total_cases) as highest_infection_count,  
max(cast(total_cases as float)/population) * 100 as infection_rate
from covid_deaths
group by place, population
order by infection_rate desc;

/* Countries with the highest eath count per population. */

select place, max(total_deaths) as total_death_count
from covid_deaths
where continent is not null and total_deaths is not null
group by place
order by total_death_count desc;

/* Continents with the highest infection rate compared to population. */

select continent, max(total_deaths) as total_death_count
from covid_deaths
where continent is not null and total_deaths is not null
group by continent
order by total_death_count desc;

/* Continents with the highest infection rate compared to population. */
/* Since "place" seems to include "continent", we can find the total number 
of infection by selecting "place" where the continent is null. */

select place, max(total_deaths) as total_death_count
from covid_deaths
where continent is null and total_deaths is not null
group by place
order by total_death_count desc;

/* Global total_cases, total_deaths and death_rate by day. */

select date, sum(new_cases) as total_cases, sum(new_deaths) as total_deaths, 
sum(cast(new_deaths as float))/sum(new_cases) * 100 as death_rate
from covid_deaths
where continent is not null
group by date
order by 1,2;

/* Global total_cases, total_deaths and death_rate. */

select sum(new_cases) as total_cases, sum(new_deaths) as total_deaths, 
sum(cast(new_deaths as float))/sum(new_cases) * 100 as death_rate
from covid_deaths
where continent is not null
order by 1,2;

/* 1.08 % of the total population who contracted COVID-19 has died. */



/* Looking at the total number of people vaccinated versus the world population. */
/* Joining the tables covid_deaths and covid_vaccination together. */

select dea.continent, dea.place, dea.date, dea.population, vac.new_vaccinations
from covid_deaths as dea
join covid_vaccinations as vac
	on dea.place = vac.place
	and dea.date = vac.date
order by 1,2,3;

/* Aggregating the number of people vaccinated by day. */

select dea.continent, dea.place, dea.date, dea.population, vac.new_vaccinations,
sum(vac.new_vaccinations) over (partition by dea.place order by dea.place, dea.date) as roll_vaccinated
from covid_deaths as dea
join covid_vaccinations as vac
	on dea.place = vac.place
	and dea.date = vac.date
where dea.continent is not null
order by 2,3;

/* Using CTE to create a temporary table. */

with popvsvac (continent, place, date, population, new_vaccinations, roll_vaccinated)
as
(
select dea.continent, dea.place, dea.date, dea.population, vac.new_vaccinations,
sum(vac.new_vaccinations) over (partition by dea.place order by dea.place, dea.date) as roll_vaccinated
from covid_deaths as dea
join covid_vaccinations as vac
	on dea.place = vac.place
	and dea.date = vac.date
where dea.continent is not null
)
select *, cast(roll_vaccinated as float)/population * 100
from popvsvac

/* Creating View to store data for Tableau visualization. */

create view percent_population_vaccinated as
select dea.continent, dea.place, dea.date, dea.population, vac.new_vaccinations,
sum(vac.new_vaccinations) over (partition by dea.place order by dea.place, dea.date) as roll_vaccinated
from covid_deaths as dea
join covid_vaccinations as vac
	on dea.place = vac.place
	and dea.date = vac.date
where dea.continent is not null;


