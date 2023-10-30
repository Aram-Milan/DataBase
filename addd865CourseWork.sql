/* Student name: Aram Gholikimilan */
/* Student username: addd865 */
/* SECTION 1 - CREATE TABLE STATEMENTS */
create table addd865_Staff
(
staff_ID integer primary key,
first_name char(15),
last_name char(15)
);
create table addd865_Doctor
(
doctor_ID integer primary key,
gmc_registration_no integer,
foreign key (doctor_ID) references addd865_Staff (staff_ID)
);
create table addd865_Secretary
(
secretary_ID integer primary key,
doctor_ID integer,
foreign key (doctor_ID) references addd865_Doctor (doctor_ID),
foreign key (secretary_ID) references addd865_Staff (staff_ID)
);
create table addd865_Patient
(
patient_ID integer primary key,
first_name char(15),
last_name char(15),
age integer,
sex char(10),
postcode char(15)
);
create table addd865_Appointment
(
appointment_date integer,
doctor_ID integer,
patient_ID integer,
appointment_fee decimal(6,2),
foreign key (doctor_ID) references addd865_Doctor (doctor_ID) on delete cascade,
foreign key (patient_ID) references addd865_Patient (patient_ID) on delete cascade,
primary key (appointment_date , doctor_ID , patient_ID)
);
/* SECTION 2 - INSERT STATEMENTS */
insert into addd865_Staff values (1001,'Mark','Croft'),
(1002,'Alice','Kentis'),
(1003,'Juliet','Smith'),
(1004,'Lily','Jones'),
(1005,'Oscar','Taylor'),
(1006,'William','Brown'),
(1007,'James','Davies'),
(1008,'Robert','Evans'),
(1009,'Patricia','Thomas'),
(1010,'George','Milan'),
(1011,'Leo','Clarke'),
(2001,'Brian','Matthews'),
(2002,'Timothy','Palmer'),
(2003,'Ronald','Holmes'),
(2004,'Edward','Mills'),
(2005,'Jason','Campbell'),
(2006,'Jeffrey','Russell'),
(2007,'Ryan','Stevens'),
(2008,'Jacob','Dixon'),
(2009,'Gary','Green'),
(2010,'Nicholas','Moore'),
(2011,'Eric','Stewart'),
(2012,'Jonathan','Brooks'),
(2013,'Stephen','Lawrence');
insert into addd865_Doctor values (1001,8064581),
(1002,8001082),
(1003,8001083),
(1004,80584),
(1005,8064585),
(1006,8064586),
(1007,8064587),
(1008,8064588),
(1009,8064589),
(1010,8064590),
(1011,8064591);
insert into addd865_Secretary values (2001,1001),
(2002,1002),
(2003,1003),
(2004,1004),
(2005,1005),
(2006,1006),
(2007,1007),
(2008,1008),
(2009,1009),
(2010,1010),
(2011,1011),
(2012,1001),
(2013,1001);
insert into addd865_Patient values (3001,'Scott','Lee',24,'male','EC3N 2OP'),
(3002,'Helen','Bell',44,'female','NW1 4NP'),
(3003,'Samuel','Ryan',25,'male','EC2A 1AA'),
(3004,'Frank','Arnold',28,'male','EC2A 1AB'),
(3005,'Rachel','Woods',33,'female','EC2A 1AQ'),
(3006,'Carolyn','Richards',55,'female','WC2B 4AA'),
(3007,'Maria','Begum',66,'female','WC2B 4AF'),
(3008,'Diane','Riley',16,'female',null),
(3009,'Julie','Woods',35,'female','EC2A 1AQ'),
(3010,'Adam','Stone',24,'male','WC2B 4AW'),
(3011,'Nathan','Hawkins',34,'male',null),
(3012,'Henry','Woods',46,'male','EC2A 1AQ'),
(3013,'Victoria','Reed',55,'female',null),
(3014,'Peter','Parker',54,'male',null);
insert into addd865_Appointment values (160105,1001,3001,69.99),
(160105,1001,3002,69.99),
(160105,1001,3008,69.99),
(160105,1001,3003,69.99),
(210707,1001,3012,69.99),
(170105,1001,3005,69.99),
(151230,1002,3002,49.99),
(210715,1002,3013,49.99),
(151230,1003,3003,119.99),
(180128,1003,3014,119.99),
(180106,1004,3004,149.99),
(161030,1004,3002,149.99),
(201122,1005,3005,99.99),
(220410,1006,3006,89.99),
(220415,1007,3008,209.99),
(201227,1007,3007,209.99),
(201227,1007,3001,209.99),
(201227,1007,3002,209.99),
(190404,1008,3002,99.99),
(201122,1008,3008,99.99),
(220404,1009,3007,99.99),
(220401,1009,3002,39.99),
(220415,1009,3002,49.99),
(220428,1009,3002,69.99),
(201122,1009,3009,89.99),
(171015,1010,3010,119.99),
(210726,1011,3001,159.99);
/* SECTION 3 - UPDATE STATEMENTS */
/*1*/
UPDATE addd865_Patient SET first_name = 'Aram', last_name = 'Gholikimilan',
age = 18 , sex = 'male' , postcode=null
WHERE patient_ID = 3003;
/*2*/
UPDATE addd865_Appointment SET doctor_ID = 1003
WHERE appointment_date = 180106;
/* SECTION 4 - SINGLE TABLE SELECT STATEMENTS */
/* 1) List the secretary ID(s) of all secretaries whose doctor_ID is 1003.*/
select secretary_ID
from addd865_Secretary
where doctor_ID = 1003;
/* 2) List the doctor_IDs for patients whose ID is 3001. List each doctor_ID only once.*/
select distinct(doctor_ID)
from addd865_Appointment
where patient_ID = 3001;
/* 3) List the names of all patients whose last name is Woods. */
select first_name
from addd865_Patient
where last_name like '%Woods';
/* 4) List the patient IDs, first names, and last names for patients who don't have addresses. */
select patient_ID,first_name,last_name
from addd865_Patient
where postcode is null;
/* 5) List all the details of appointments dated April 2022. */
select *
from addd865_Appointment
where appointment_date >= 220401 and appointment_date <= 220430;
/* 6) How much money did the clinic make in April 2022? Change the name of the output
column to 'April 2022 Income'. */
select sum(appointment_fee) as 'April 2022 Income'
from addd865_Appointment
where appointment_date >= 220401 and appointment_date <= 220430;
/* SECTION 5 MULTIPLE TABLE SELECT StATEMENTS */
/* 1) list of appointment dates, fees, doctors' names, patients' names, patients' ages, and patients' sex. */
select s.first_name as 'doctor name',s.last_name as 'doctor surname',
a.appointment_date,a.appointment_fee,
p.first_name as 'patient name',p.last_name as 'patient surname',p.age,p.sex
from addd865_Staff s
inner join addd865_Appointment a
on s.staff_ID=a.doctor_ID
inner join addd865_Patient p
on a.patient_ID=p.patient_ID
order by a.appointment_fee asc;
/* 2) On which dates in April 2022 did the doctor 'Patricia' had appointment with patient ID = 3002? You
may output dates in the format they are stored. */
select appointment_date
from addd865_Staff s, addd865_Appointment a
where s.staff_ID = a.doctor_ID
and s.first_name = 'Patricia'
and appointment_date between 220401 and 220430
and a.patient_ID = 3002;
/* 3) List the names of the secretaries who work for the same doctor as secretary ID = 2001.
*/
select first_name, last_name
from addd865_Staff
where staff_ID in
(select secretary_ID from addd865_Secretary
where doctor_ID in
(select doctor_ID from addd865_Secretary
where secretary_ID = 2001));
/* 4) List the patient IDs who spent greater than 50.00 pounds on a single appointment on occasions when 'Gary' was the secretary of their doctor. */
select distinct(a.patient_ID)
from addd865_Appointment a 
where appointment_fee > 50
and doctor_ID IN
(select doctor_ID
from addd865_Secretary
where secretary_ID IN
(select staff_ID
from addd865_Staff
where first_name = 'Gary'));
/* 5) Which doctors have had 2 or more appointments on a single date? List the doctor names, the
dates ,and the number of appointments they have had. */
select first_name, last_name, appointment_date, count(*) as 'number of appointments'
from addd865_Appointment,addd865_Staff
where addd865_Appointment.doctor_ID =addd865_Staff.staff_ID
group by first_name, last_name, appointment_date
having count(*) >= 2;
/* 6) List the secretaries' name sequence and the total amount of money they have made for the clinic.
Sort the list by total bill amount in descending order. */
select s.first_name, s.last_name, sum(appointment_fee)
from addd865_Appointment a, addd865_Staff s, addd865_Secretary secr
where secr.doctor_ID=a.doctor_ID
and secr.secretary_ID = s.staff_ID
group by s.first_name, s.last_name
order by sum(appointment_fee) desc;
/* SECTION 6 - DELETE ROWS (make sure the SQL is commented out in this section)
DELETE FROM addd865_Patient WHERE last_name = 'Lee';
DELETE FROM addd865_Appointment WHERE doctor_ID = 1007 AND patient_ID = 3002;
*/
/* SECTION 7 DROP TABLES (make sure the SQL is commented out in this section)
drop table addd865_Appointment;
drop table addd865_Secretary;
drop table addd865_Patient;
drop table addd865_Doctor;
drop table addd865_Staff;
*/