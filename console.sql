create database HospitalDB;
go
use HospitalDB;

go
create table Doctor
(
    DoctorID int primary key identity(1,1),
    DoctorName varchar(50) check(DoctorName like '[A-Z]%') not null,
    DoctorSpeciality varchar(50) check(DoctorSpeciality like '[A-Z]%'),
    DoctorSalary money check(DoctorSalary > 0) default 3500
);
go
create table CountryCode
(
    CountryCodeID int primary key identity(1,1),
    CountryCode varchar(50) check(CountryCode like '[0-9]%') not null,
    CountryName varchar(50) check(CountryName like '[A-Z]%') not null
);

go
create table Patient
(
    PatientID int primary key identity(1,1),
    PatientName varchar(50) check(PatientName like '[A-Z]%') not null,
    PatientAge int check(PatientAge > 0 and PatientAge < 120) not null,
    PatientGender varchar(50),
    PatientAddress varchar(100) check(PatientAddress like '[A-Z]%') not null,
    CountryCodeID int foreign key references CountryCode(CountryCodeID),
    PatientPhone varchar(50) check(PatientPhone like '[0-9]%') not null,
    PatientEmail nvarchar(50) check (PatientEmail like '%@%.%') not null
);
go
create table Appointment
(
    AppointmentID int primary key identity(1,1),
    AppointmentDate date not null default getdate() check (MONTH(AppointmentDate) = MONTH(getdate()) and YEAR(AppointmentDate) = YEAR(getdate()) or AppointmentDate > getdate()),
    AppointmentTime time not null,
    DoctorID int foreign key references Doctor(DoctorID) check (DoctorID > 0),
    PatientID int foreign key references Patient(PatientID) check (PatientID > 0)
);


go
create table Prescription
(
    PrescriptionID int primary key identity(1,1),
    PrescriptionDate date not null default getdate() check (MONTH(PrescriptionDate) = MONTH(getdate()) and YEAR(PrescriptionDate) = YEAR(getdate()) or PrescriptionDate > getdate()),
    PrescriptionTime time not null,
    DoctorID int foreign key references Doctor(DoctorID) check (DoctorID > 0),
    PatientID int foreign key references Patient(PatientID) check (PatientID > 0),
    PrescriptionDetails varchar(100) check(PrescriptionDetails like '[A-Z]%') not null
);
-- Insert into Doctor
insert into Doctor (DoctorName, DoctorSpeciality, DoctorSalary) values
                                                                    ('Dr. John', 'Cardiologist', 5000),
                                                                    ('Dr. Smith', 'Dentist', 4000),
                                                                    ('Dr. Alex', 'Pediatrician', 4500),
                                                                    ('Dr. Maria', 'Gynecologist', 5000),
                                                                    ('Dr. David', 'Orthopedic', 5500),
                                                                    ('Dr. Sarah', 'Dermatologist', 4500);

-- Insert into CountryCode
insert into CountryCode (CountryCode, CountryName) values
                                                       ('1', 'USA'),
                                                       ('44', 'UK'),
                                                       ('91', 'India'),
                                                       ('61', 'Australia'),
                                                       ('64', 'New Zealand'),
                                                       ('27', 'South Africa');

go
-- Insert into Patient
insert into Patient (PatientName, PatientAge, PatientGender, PatientAddress, CountryCodeID, PatientPhone, PatientEmail) values
                                                                                                                            ('Alice', 30, 'Female', 'Main St, 123', 1, '1234567890', 'alice@example.com'),
                                                                                                                            ('Bob', 45, 'Male', 'Elm St, 456', 2, '2345678901', 'bob@example.com'),
                                                                                                                            ('Charlie', 28, 'Male', 'Oak St, 789', 3, '3456789012', 'charlie@example.com'),
                                                                                                                            ('Diana', 35, 'Female', 'Pine St, 101', 4, '4567890123', 'diana@example.com'),
                                                                                                                            ('Eve', 40, 'Female', 'Maple St, 202', 5, '5678901234', 'eve@example.com');
-- Insert into Appointment
insert into Appointment (AppointmentDate, AppointmentTime, DoctorID, PatientID) values
                                                                                    ('2025-10-01', '10:00:00', 1, 1),
                                                                                    ('2025-10-02', '11:00:00', 2, 2),
                                                                                    ('2025-10-03', '12:00:00', 3, 3),
                                                                                    ('2025-10-04', '13:00:00', 4, 4),
                                                                                    ('2025-10-05', '14:00:00', 5, 5);

-- Insert into Prescription
insert into Prescription (PrescriptionDate, PrescriptionTime, DoctorID, PatientID, PrescriptionDetails) values
                                                                                                            ('2025-10-01', '10:00:00', 1, 1, 'Prescription for Alice'),
                                                                                                            ('2025-10-02', '11:00:00', 2, 2, 'Prescription for Bob'),
                                                                                                            ('2025-10-03', '12:00:00', 3, 3, 'Prescription for Charlie'),
                                                                                                            ('2025-10-04', '13:00:00', 4, 4, 'Prescription for Diana'),
                                                                                                            ('2025-10-05', '14:00:00', 5, 5, 'Prescription for Eve');
--select
go
select * from Doctor;
select * from CountryCode;
select * from Patient;
select * from Appointment;
select * from Prescription;

--drop
drop table Doctor;
drop table CountryCode;
drop table Patient;
drop table Appointment;
drop table Prescription;
use master;
drop database HospitalDB;