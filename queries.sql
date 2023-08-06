/*1. List all female athletes*/
SELECT  AthleteID, FirstName, LastName 
FROM    ATHLETE_T
WHERE   Gender = 'F';

/*2. List all schools in Virginia and Maryland*/
SELECT SchoolID, Name, State 
FROM SCHOOL_T 
WHERE State in ("VA", "MD");

/*3. List all teams with 'Soccer' or 'Football' in their name*/
SELECT TeamID, Name FROM TEAM_T
WHERE Name LIKE "%Soccer%" OR Name LIKE "%Football%";

/*4. List all athletes born before 2006*/
SELECT  AthleteID, FirstName, LastName, YearOfBirth 
FROM    ATHLETE_T
WHERE   YearOfBirth < 2006
ORDER BY YearOfBirth;

/*5. Calculate the average height and weight of all athletes*/
SELECT AVG (Height) AS AverageHeight, AVG (Weight) AS AverageWeight 
FROM ATHLETE_T;

/*6. List all organizers who are based in New York State*/
SELECT OrganizerID, Name, City FROM ORGANIZER_T
WHERE State = "NY";

/*7. List all sponsors who have worked with the organizer whose id is '2'*/
SELECT SponsorID
FROM SPONSOR_ORGANIZER_T
WHERE OrganizerID = 2;

/*8. List all teams that belong to the first 3 schools and the school name*/
SELECT TEAM_T.Name AS TeamName, SCHOOL_T.Name AS SchoolName
FROM TEAM_T, SCHOOL_T
WHERE SCHOOL_T.SCHOOLID = TEAM_T.SCHOOLID AND TEAM_T.SchoolID <= 3
ORDER BY SCHOOL_T.Name;

/*9. List all competitions held since the beginning of 2021 and their organizers*/
SELECT COMPETITION_T.CompetitionID, COMPETITION_T.Name AS CompetitionName, StartDate, ORGANIZER_T.Name AS OrganizerName
FROM COMPETITION_T INNER JOIN ORGANIZER_T 
ON COMPETITION_T.OrganizerID = ORGANIZER_T.OrganizerID
WHERE StartDate >= '2021-01-01'
ORDER BY StartDate;

/*10. List all male coaches and the teams they belong to. Note that some coaches do not currently belong to any team*/
SELECT COACH_T.CoachID, COACH_T.FirstName, COACH_T.LastName, TEAM_T.Name AS TeamName
FROM COACH_T LEFT OUTER JOIN TEAM_T 
ON COACH_T.TeamID = TEAM_T.TeamID 
WHERE Gender = 'M';