create database Academy;
go
use Academy;

--create tables
go
create table Groups
(
    Id int primary key identity (1,1) not null,
    Name nvarchar(10) NOT NULL UNIQUE check (LEN(Name) > 0),
    Rating int not null check (Rating >= 0 and Rating <= 5),
    Year int not null check (Year >= 1 and Year <= 5)
);

go
create table Departments
(
    Id int primary key identity (1,1) not null,
    Financing money not null check (Financing >= 0) default 0,
    Name nvarchar(100) NOT NULL UNIQUE check (LEN(Name) > 0),
);

go
create table Faculties(
                          Id int primary key identity (1,1) not null,
                          Dean nvarchar(max) NOT NULL check (LEN(Dean) > 0),
                          Name nvarchar(100) NOT NULL UNIQUE check (LEN(Name) > 0)
);

go
create table Teachers
(
    Id int primary key identity (1,1) not null,
    EmploymentDate date not null check (EmploymentDate <= '1990-01-01'),
    IsAssistant bit not null default 0,
    IsProfessor bit not null default 0,
    Name nvarchar(max) NOT NULL check (LEN(Name) > 0),
    Premium money not null check (Premium >= 0) default 0,
    Salary money not null check (Salary >= 0),
    Surname nvarchar(max) NOT NULL check (LEN(Surname) > 0),
);

--inserts
go
insert into Groups (Name, Rating, Year) values
                                            ('Group1', 3, 1),
                                            ('Group2', 4, 2),
                                            ('Group3', 2, 3),
                                            ('Group4', 5, 4),
                                            ('Group5', 4, 5);
go
insert into Departments (Financing, Name) values
                                              (10000, 'Department1'),
                                              (20000, 'Department2'),
                                              (15000, 'Department3'),
                                              (25000, 'Department4'),
                                              (30000, 'Department5');

go
insert into Faculties (Dean, Name) values
                                       ('Dean1', 'Faculty1'),
                                       ('Dean2', 'Faculty2'),
                                       ('Dean3', 'Faculty3'),
                                       ('Dean4', 'Faculty4'),
                                       ('Dean5', 'Faculty5');

go
insert into Teachers (EmploymentDate, IsAssistant, IsProfessor, Name, Premium, Salary, Surname) values
                                                                                                    ('1985-01-01', 1, 0, 'Teacher1', 199, 1000, 'Smith'),
                                                                                                    ('1987-01-01', 0, 1, 'Teacher2', 300, 1500, 'Johnson'),
                                                                                                    ('1989-01-01', 1, 0, 'Teacher3', 250, 1200, 'Williams'),
                                                                                                    ('1986-01-01', 0, 1, 'Teacher4', 400, 2000, 'Brown'),
                                                                                                    ('1988-01-01', 1, 0, 'Teacher5', 350, 1800, 'Jones');

--selects
go
select Name, Financing, Id
from Departments;--1


go
select Name as "Group Name", Rating as "Group Rating"
from Groups;--2

go
select Surname,
       (Premium / Salary) * 100 as "Premium Percentage",
       (Salary / (Salary + Premium)) * 100 as "Salary Percentage"
from Teachers;--3

go
select 'The dean of faculty ' + Name + ' is ' + Dean as "Faculty Info"
from Faculties;--4

go
select Surname
from Teachers
where IsProfessor = 1 and Salary > 1050;--5

go
select Name
from Departments
where Financing < 11000 or Financing > 25000;--6

go
select Name
from Faculties
where Name != 'Computer Science';--7

go
select Surname, 'Assistant' as Position
from Teachers
where IsProfessor = 0;--8

go
select Surname, 'Assistant' as Position, Salary, Premium
from Teachers
where IsAssistant = 1 and Premium between 160 and 550;--9

go
select Surname, Salary
from Teachers
where IsAssistant = 1;--10

go
select Surname, 'Assistant' as Position
from Teachers
where EmploymentDate < '2000-01-01';--11

go
select Name as "Name of Department"
from Departments
where Name < 'Software Development'
order by Name;--12

go
select Surname
from Teachers
where IsAssistant = 1 and (Salary + Premium) <= 1200;--13

go
select Name
from Groups
where Year = 5 and Rating between 2 and 4;--14

go
select Surname
from Teachers
where IsAssistant = 1 and (Salary < 550 or Premium < 200);--15

--deletes
go
drop table Teachers;
drop table Faculties;
drop table Departments;
drop table Groups;

use master;
drop database Academy;