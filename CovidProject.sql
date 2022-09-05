/* Creating the table of Covid Vaccinations and its columns in order to import the data. */

CREATE TABLE Public."CovidVaccinations"
	(iso_code character varying,
	 continent character varying,
	 place character varying,
	 "date" date,
	 total_tests integer,
	 new_tests integer,
	 total_tests_per_thousand numeric,
	 new_tests_per_thousand numeric,
	 new_tests_smoothed integer,
	 new_tests_smoothed_per_thousand numeric,
	 positive_rate numeric,
	 tests_per_case numeric,
	 tests_units character varying,
	 total_vaccinations bigint,
	 people_vaccinated bigint,
	 people_fully_vaccinated bigint,
	 total_boosters integer,
	 new_vaccinations integer,
	 new_vaccinations_smoothed integer,
	 total_vaccinations_per_hundred numeric,
	 people_vaccinated_per_hundred numeric,
	 people_fully_vaccinated_per_hundred numeric,
	 total_boosters_per_hundred numeric,
	 new_vaccinations_smoothed_per_million integer,
	 new_people_vaccinated_smoothed integer,
	 new_people_vaccinated_smoothed_per_hundred numeric,
	 stringency_index numeric,
	 population_density numeric,
	 median_age numeric,
	 aged_65_older numeric,
	 aged_70_older numeric,
	 gdp_per_capita numeric,
	 extreme_poverty numeric,
	 cardiovasc_death_rate numeric,
	 diabetes_prevalence numeric,
	 female_smokers numeric,
	 male_smokers numeric,
	 handwashing_facilities numeric,
	 hospital_beds_per_thousand numeric,
	 life_expectancy numeric,
	 human_development_index numeric,
	 excess_mortality_cumulative_absolute numeric,
	 excess_mortality_cumulative numeric,
	 excess_mortality numeric,
	 excess_mortality_cumulative_per_million numeric);
	 
SELECT * from Public."CovidVaccinations";

/* Modifying the data type of certain columns because of some data having a large number of characters. */

ALTER TABLE Public."CovidVaccinations"
ALTER COLUMN total_tests SET DATA TYPE bigint;

ALTER TABLE Public."CovidVaccinations"
ALTER COLUMN total_boosters SET DATA TYPE bigint;

/* Importing the data from excel file of Covid Vaccinations downloaded from the https://ourworldindata.org. */

COPY Public."CovidVaccinations" FROM 'C:\Users\Public\Documents\CovidVaccinations.csv' DELIMITER ',' CSV HEADER;

SELECT * from Public."CovidVaccinations";
