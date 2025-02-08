create database Hospital;
go
use Hospital;

--create tables
go
create table Departments
(
    ID int primary key identity (1,1) not null,
    Building int not null check (Building > 1 and Building < 5),
    Financing money not null check (Financing > 0) Default 0,
    Floor int not null check (Floor > 0),
    Name nvarchar(100) not null unique check (LEN(Name) > 0)
);
go
create table Diseases(
                         ID int primary key identity (1,1) not null,
                         Name nvarchar(100) not null unique check (LEN(Name) > 0),
                         Severity int not null check (Severity > 1) Default 1
);
go
create table Doctors(
                        ID int primary key identity (1,1) not null,
                        Name nvarchar(max) not null check (LEN(Name) > 0),
                        Phone nvarchar(10) not null,
                        Premium int not null check (Premium > 0) Default 0,
                        Salary money not null check (Salary > 0),
                        Surname nvarchar(max) not null check (LEN(Surname) > 0)
);

go
create table Examinations(
                             ID int primary key identity (1,1) not null,
                             DayOfWeek int not null check (DayOfWeek > 0 and DayOfWeek < 8),
                             EndTime time not null,--check (EndTime > StartTime) don`t work in SQL Server
                             Name nvarchar(100) not null check (LEN(Name) > 0),
                             StartTime time not null check (StartTime between '08:00' and '18:00'),
                             check (StartTime < EndTime)
);
go
create table Wards (
                       ID int primary key identity (1,1) not null,
                       Building int not null check (Building > 1 and Building < 5),
                       Floor int not null check (Floor > 0),
                       Name nvarchar(20) not null unique check (LEN(Name) > 0),
);

--inserts
go
insert into Departments (Building, Financing, Name, Floor) values
                                                               (2, 13000, 'Cardiology', 5),  -- Cardiology department in Building 2
                                                               (3, 14000, 'Neurology', 3),   -- Neurology department in Building 3
                                                               (4, 30000, 'Oncology', 2),    -- Oncology department in Building 4
                                                               (3, 26000, 'Pediatrics', 4);  -- Pediatrics department in Building 2

go
insert into Diseases (Name, Severity) values
                                          ('Heart attack', 5),  -- Severe disease
                                          ('Stroke', 5),        -- Severe disease
                                          ('Cancer', 5),        -- Severe disease
                                          ('Flu', 2),           -- Moderate disease
                                          ('Cold', 2),          -- Moderate disease
                                          ('Headache', 2);      -- Moderate disease

go
insert into Doctors (Name, Phone, Premium, Salary, Surname) values
                                                                ('John', '1234567890', 300, 2000, 'Doe'),    -- John Doe
                                                                ('Jane', '1234567890', 600, 2000, 'Doe'),    -- Jane Doe
                                                                ('Alice', '1234567890', 700, 3000, 'Smith'), -- Alice Smith
                                                                ('Bob', '1234567890', 800, 3000, 'Smith'),   -- Bob Smith
                                                                ('Charlie', '1234567890', 900, 1500, 'Brown'), -- Charlie Brown
                                                                ('Naisy', '1234567890', 400, 1500, 'Brown');  -- Daisy Brown


go
insert into Examinations (DayOfWeek, EndTime, Name, StartTime) values
                                                                   (1, '12:00', 'Cardiology', '08:00'),  -- Monday
                                                                   (2, '15:00', 'Neurology', '14:00'),   -- Tuesday
                                                                   (3, '12:00', 'Oncology', '08:00'),    -- Wednesday
                                                                   (4, '12:00', 'Pediatrics', '08:00'),  -- Thursday
                                                                   (5, '12:00', 'Cardiology', '08:00'),  -- Friday
                                                                   (6, '12:00', 'Neurology', '08:00'),   -- Saturday
                                                                   (7, '12:00', 'Oncology', '08:00');    -- Sunday


go
insert into Wards (Building, Floor, Name) values
                                              (2, 1, 'Cardiology'),  -- Cardiology ward in Building 2, Floor 1
                                              (3, 2, 'Neurology'),   -- Neurology ward in Building 3, Floor 2
                                              (4, 1, 'Oncology'),    -- Oncology ward in Building 4, Floor 3
                                              (2, 4, 'Pediatrics');  -- Pediatrics ward in Building 2, Floor 4


--selects
go
select * from Wards;--1

go
select Surname, Phone from Doctors;--2

go
SELECT DISTINCT Floor FROM Wards;--3

go
select Name AS "Name of Disease", Severity AS "Severity of Disease" FROM Diseases;--4

go
SELECT d.Name AS DepartmentName, dis.Name AS DiseaseName, doc.Name AS DoctorName
FROM Departments AS d
         JOIN Diseases AS dis ON d.ID = dis.ID
         JOIN Doctors AS doc ON d.ID = doc.ID;--5

go
select Name from Departments where Financing < 30000 and Floor = 5;--6

go
select Name from Departments where Floor = 3 and Financing BETWEEN 12000 and 15000 ;--7

go
select Name from Wards where Building IN (4,5) and Floor = 1;--8

go
SELECT Name, Building, Financing FROM Departments
WHERE Building IN (3, 6) AND (Financing < 11000 OR Financing > 25000);--9

go
select Surname from Doctors where Salary > 1500;--10

go
select Surname from Doctors where (Salary/2) > (3* Premium);--11

go
SELECT DISTINCT Name FROM Examinations
WHERE DayOfWeek BETWEEN 1 AND 3 AND StartTime BETWEEN '12:00' AND '15:00';--12

go
SELECT Name, Building FROM Departments WHERE Building IN (1, 3, 8, 10);--13

go
SELECT Name FROM Departments WHERE Building NOT IN (1, 3);--14

go
select Name from Departments where Building not in (1,3);--15


go
select Name from Departments where Building in (1,3);--15

go
select Surname from Doctors where Name like 'N%';--16

--deletes
go
drop table Examinations;
drop table Doctors;
drop table Diseases;
drop table Departments;
use master;
drop database Hospital;