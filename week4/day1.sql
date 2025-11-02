/*1.Revising the Select Query I*/
    SELECT * FROM CITY 
    WHERE POPULATION > 100000 AND COUNTRYCODE = 'USA';

/*2.Revising the Select Query II*/
    SELECT NAME From CITY
    WHERE POPULATION > 120000 AND COUNTRYCODE = 'USA';

/*3.Select All*/
    SELECT * From CITY;

/*4.Select By ID*/
    SELECT * From CITY 
    WHERE ID = 1661;

/*5.Japanese Cities' Attributes*/
    SELECT * From CITY 
    WHERE COUNTRYCODE = 'JPN';

/*6.Weather Observation Station 1*/
    SELECT CITY, STATE 
    From STATION;