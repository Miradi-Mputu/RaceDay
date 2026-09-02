CREATE DATABASE RaceDay;
USE RaceDay;

CREATE TABLE UserAccount (
    UserID int Primary Key,
    FirstName varchar(50) not null,
    LastName varchar(50) not null,
    Email varchar(100) not null UNIQUE,
    PasswordHash varchar(255) not null,
    Phone varchar(20) not null,
    UserRole varchar(20) not null,
    CreatedDate datetime not null DEFAULT GETDATE()
);

CREATE TABLE Organiser (
    OrganiserID int Primary Key,
    UserID int not null UNIQUE,
    OrganiserName varchar(100) not null,
    OrganisationName varchar(100) not null,
    foreign key (UserID) references UserAccount(UserID)
);

CREATE TABLE Participant (
    ParticipantID int Primary Key,
    UserID int not null UNIQUE,
    ParticipantAge int not null,
    foreign key (UserID) references UserAccount(UserID)
);

CREATE TABLE Event (
    EventID int Primary Key,
    EventName varchar(50) not null,
    EventDescription varchar(100) not null,
    EventDate date not null,
    EventLocation varchar(100) not null,
    RouteInformation varchar(255) not null,
    OrganiserID int not null,
    foreign key (OrganiserID) references Organiser(OrganiserID)
);

CREATE TABLE Category (
    CategoryID int Primary Key,
    CategoryName varchar(50) not null,
    CategoryDescription varchar(100) not null
);

CREATE TABLE EventCategory (
    EventID int not null,
    CategoryID int not null,
    Primary Key (EventID, CategoryID),
    foreign key (EventID) references Event(EventID),
    foreign key (CategoryID) references Category(CategoryID)
);

CREATE TABLE Entry (
    EntryID int Primary Key,
    ParticipantID int not null,
    EventID int not null,
    EntryDate date not null DEFAULT GETDATE(),
    EntryStatus varchar(20) not null DEFAULT 'Entered',
    foreign key (ParticipantID) references Participant(ParticipantID),
    foreign key (EventID) references Event(EventID),
    UNIQUE (ParticipantID, EventID)
);

CREATE TABLE Result (
    ResultID int Primary Key,
    EntryID int not null UNIQUE,
    ResultTime varchar(20) not null,
    Position int not null,
    ResultStatus varchar(20) not null DEFAULT 'Completed',
    foreign key (EntryID) references Entry(EntryID)
);


INSERT INTO UserAccount
(UserID, FirstName, LastName, Email, PasswordHash, Phone, UserRole)
VALUES
(1, 'Thabo', 'Mokoena', 'thabo@raceday.co.za', 'hashedpassword1', '0821111111', 'Organiser'),
(2, 'Lerato', 'Nkosi', 'lerato@raceday.co.za', 'hashedpassword2', '0832222222', 'Organiser'),
(3, 'Sipho', 'Dlamini', 'sipho@email.com', 'hashedpassword3', '0843333333', 'Participant'),
(4, 'Nomsa', 'Mthembu', 'nomsa@email.com', 'hashedpassword4', '0854444444', 'Participant');

INSERT INTO Organiser
(OrganiserID, UserID, OrganiserName, OrganisationName)
VALUES
(1, 1, 'Thabo Mokoena', 'RaceDay Events'),
(2, 2, 'Lerato Nkosi', 'South African Running Club');

INSERT INTO Participant
(ParticipantID, UserID, ParticipantAge)
VALUES
(1, 3, 25),
(2, 4, 29);

INSERT INTO Event
(EventID, EventName, EventDescription, EventDate, EventLocation, RouteInformation, OrganiserID)
VALUES
(1, 'Johannesburg City Run', 'Annual road running event', '2026-10-10', 'Johannesburg', '10km city route', 1),
(2, 'Cape Town Charity Cycle', 'Community charity cycling event', '2026-11-15', 'Cape Town', '50km coastal route', 2),
(3, 'Soweto Community Walk', 'Community health and fitness walk', '2026-12-05', 'Soweto', '5km community route', 1);

INSERT INTO Category
(CategoryID, CategoryName, CategoryDescription)
VALUES
(1, '10km Open', '10 kilometre open running category'),
(2, '10km Veterans', '10 kilometre veterans running category'),
(3, '50km Cycling', '50 kilometre cycling category'),
(4, '25km Cycling', '25 kilometre cycling category'),
(5, '5km Community Walk', '5 kilometre community walking category');

INSERT INTO EventCategory
(EventID, CategoryID)
VALUES
(1, 1),
(1, 2),
(2, 3),
(2, 4),
(3, 5);

INSERT INTO Entry
(EntryID, ParticipantID, EventID, EntryDate, EntryStatus)
VALUES
(1, 1, 1, '2026-08-20', 'Entered'),
(2, 2, 1, '2026-08-20', 'Entered'),
(3, 1, 2, '2026-08-20', 'Entered'),
(4, 2, 3, '2026-08-20', 'Entered');

INSERT INTO Result
(ResultID, EntryID, ResultTime, Position, ResultStatus)
VALUES
(1, 1, '00:48:32', 1, 'Completed'),
(2, 2, '00:52:15', 2, 'Completed'),
(3, 3, '01:45:20', 1, 'Completed');


SELECT * FROM UserAccount;
SELECT * FROM Organiser;
SELECT * FROM Participant;
SELECT * FROM Event;
SELECT * FROM Category;
SELECT * FROM EventCategory;
SELECT * FROM Entry;
SELECT * FROM Result;

