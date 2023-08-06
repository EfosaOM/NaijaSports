CREATE TABLE ATHLETE_T
  ( AthleteID		  NUMERIC(12)        NOT NULL,
    FirstName		  VARCHAR(25)        NOT NULL,
    LastName		  VARCHAR(25)        NOT NULL,
    Gender		    CHAR(1)            NOT NULL,
    YearOfBirth		NUMERIC(4)         NOT NULL,
    Street        VARCHAR(40),
    City          VARCHAR(30)        NOT NULL,
    State         VARCHAR(2)         NOT NULL,
    PostalCode    VARCHAR(10),     
    Phone         CHAR(10)           NOT NULL,
    Email         VARCHAR(50)        NOT NULL,
    Height        INTEGER,
    Weight        INTEGER,
    Rating        INTEGER,
    Notes         TEXT,
    CONSTRAINT PK_ATHLETE_T PRIMARY KEY (AthleteID));

CREATE TABLE SCHOOL_T
  ( SchoolID		  NUMERIC(12)        NOT NULL,
    Name		      VARCHAR(100)       NOT NULL,
    Street        VARCHAR(40),
    City          VARCHAR(30)        NOT NULL,
    State         VARCHAR(2)         NOT NULL,
    PostalCode    VARCHAR(10),       
    Phone         CHAR(10)           NOT NULL,
    Email         VARCHAR(50)        NOT NULL,
    CONSTRAINT PK_SCHOOL_T PRIMARY KEY (SchoolID));    

CREATE TABLE SPORT_T
  ( SportID		    NUMERIC(12)        NOT NULL,
    Name		      VARCHAR(50)        NOT NULL,
    CONSTRAINT PK_SPORT_T PRIMARY KEY (SportID));   

CREATE TABLE COACH_T
  ( CoachID		    NUMERIC(12)        NOT NULL,
    FirstName		  VARCHAR(25)        NOT NULL,
    LastName		  VARCHAR(25)        NOT NULL,
    Gender		    CHAR(1)            NOT NULL,
    YearOfBirth		NUMERIC(4)         NOT NULL,
    Street        VARCHAR(40),
    City          VARCHAR(30)        NOT NULL,
    State         VARCHAR(2)         NOT NULL,
    PostalCode    VARCHAR(10),
    Phone         CHAR(10)           NOT NULL,
    Email         VARCHAR(50)        NOT NULL,
    Height        VARCHAR(3),
    Weight        VARCHAR(3),
    Notes         TEXT,
    TeamID        NUMERIC(12),       
    CONSTRAINT PK_ATHLETE_T PRIMARY KEY (CoachID));


CREATE TABLE TEAM_T
  ( TeamID		    NUMERIC(12)        NOT NULL,
    Name		      VARCHAR(50)        NOT NULL,
    SchoolID      NUMERIC(12)        NOT NULL,
    CONSTRAINT PK_TEAM_T PRIMARY KEY (TeamID));   


CREATE TABLE COMPETITION_T
  ( CompetitionID		NUMERIC(12)      NOT NULL,
    Name		        VARCHAR(100)     NOT NULL,
    Description     VARCHAR(255),
    StartDate       DATETIME,
    EndDate         DATETIME,  
    OrganizerID     NUMERIC(12)      NOT NULL,
    CONSTRAINT PK_COMPETITION_T PRIMARY KEY (CompetitionID));   


CREATE TABLE GAME_T
  ( GameID		      NUMERIC(12)            NOT NULL,
    Name		        VARCHAR(100)     NOT NULL,
    Description     VARCHAR(1000),
    StartDate       DATETIME,
    EndDate         DATETIME,
    CompetitionID   NUMERIC(12), 
    CONSTRAINT PK_GAME_T PRIMARY KEY (GameID));   

CREATE TABLE ORGANIZER_T
  ( OrganizerID		NUMERIC(12)          NOT NULL,
    Name		      VARCHAR(100)        NOT NULL,
    Street        VARCHAR(40),
    City          VARCHAR(30)        NOT NULL,
    State         VARCHAR(2)         NOT NULL,
    PostalCode    VARCHAR(10),
    Phone         CHAR(10)            NOT NULL,
    Email         VARCHAR(50)        NOT NULL,
    CONSTRAINT PK_ORGANIZER_T PRIMARY KEY (OrganizerID));

CREATE TABLE SPONSOR_T
  ( SponsorID		  NUMERIC(12)          NOT NULL,
    Name		      VARCHAR(100)        NOT NULL,
    Street        VARCHAR(40),
    City          VARCHAR(30)        NOT NULL,
    State         VARCHAR(2)         NOT NULL,
    PostalCode    VARCHAR(10),
    Phone         CHAR(10)            NOT NULL,
    Email         VARCHAR(50)        NOT NULL,
    CONSTRAINT PK_SPONSOR_T PRIMARY KEY (SponsorID));

CREATE TABLE SPONSOR_ORGANIZER_T
  ( SponsorID		  NUMERIC(12)        NOT NULL,
    OrganizerID		NUMERIC(12)        NOT NULL,
    CONSTRAINT PK_SPONSOR_ORGANIZER_T PRIMARY KEY (SponsorID, OrganizerID)); 

CREATE TABLE TEAM_ATHLETE_T
  ( TeamID		    NUMERIC(12)          NOT NULL,
    AthleteID		  NUMERIC(12)        NOT NULL,
    CONSTRAINT PK_TEAM_ATHLETE_T PRIMARY KEY (TeamID, AthleteID)); 

CREATE TABLE TEAM_SPORT_T
  ( TeamID		    NUMERIC(12)        NOT NULL,
    SportID	      NUMERIC(12)        NOT NULL,
    CONSTRAINT PK_TEAM_SPORT_T PRIMARY KEY (TeamID, SportID)); 

CREATE TABLE TEAM_GAME_T
  ( TeamID		    NUMERIC(12)        NOT NULL,
    GameID	      NUMERIC(12)        NOT NULL,
    CONSTRAINT PK_TEAM_GAME_T PRIMARY KEY (TeamID, GameID)); 


ALTER TABLE COACH_T
  ADD CONSTRAINT FK_COACH_TeamID FOREIGN KEY (TeamID)
    REFERENCES TEAM_T (TeamID);

ALTER TABLE TEAM_T
  ADD CONSTRAINT FK_TEAM_SchoolID FOREIGN KEY (SchoolID)
    REFERENCES SCHOOL_T (SchoolID);

ALTER TABLE COMPETITION_T
  ADD CONSTRAINT FK_COMPETITION_OrganizerID FOREIGN KEY (OrganizerID)
    REFERENCES ORGANIZER_T (OrganizerID);

ALTER TABLE GAME_T
  ADD CONSTRAINT FK_GAME_CompetitionID FOREIGN KEY (CompetitionID)
    REFERENCES COMPETITION_T (CompetitionID);