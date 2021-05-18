-- Create Database
create database if not exists healthcare;
use healthcare;
SET FOREIGN_KEY_CHECKS = 0;

-- Create Tables

create table if not exists center
(
center_id char(5) not null primary key,
full_name varchar(30),
nurse_id char(5) not null,
foreign key(nurse_id) references nurse(nurse_id)
);


create table if not exists nurse
(
nurse_id char(5) not null primary key,
full_name varchar(20),
center_id char(5)
);

create table if not exists patient_info
(
patient_medical_record char(5) not null primary key,
patient_name varchar(20),
bed_number char(5),
foreign key(bed_number) references bed(bed_number),
physician_id char(5)
);


create table if not exists bed
(
bed_number char(5) not null primary key,
room_number char(5),
room_type varchar(20),
block_floor char(2),
block_code char(2),
available varchar(5),
center_id char(5)
);


create table if not exists dx
(
dx_code varchar(5) not null primary key,
dx_name varchar(40)
);


create table if not exists physician
(
physician_id char(5) not null primary key,
physician_name varchar(20),
subspeciality varchar (50),
salary char (10)
);

create table if not exists physician_dx
(
diagnosis_time timestamp,
physician_id char(5),
patient_medical_record char(5),
dx_code varchar(5),
foreign key(physician_id) references physician(physician_id),
foreign key(dx_code) references dx(dx_code),
foreign key(patient_medical_record) references patient(patient_medical_record)
);


create table if not exists assessment
(
appointment_id char(5) not null primary key,
appointment_datetime  timestamp,
visit_notes varchar (100),
patient_weight char(5),
patient_height char(5),
patient_bp char(10),
patient_pulse char(5),
patient_temp char(5),
patient_medical_record char(5),
nurse_id char(5),
physician_id char(5),
foreign key(patient_medical_record) references patient(patient_medical_record),
foreign key(nurse_id) references nurse(nurse_id),
foreign key(physician_id) references physician(physician_id)
);


create table if not exists medication
(
med_number char(5) not null primary key,
med_name varchar(50),
med_totalcost char(10)
);


create table if not exists med_consumption
(
consume_date date,
dose char(50),
med_number char(10),
patient_medical_record char(5),
foreign key(patient_medical_record) references patient(patient_medical_record)
);


create table if not exists ordernote
(
order_id char(5) not null primary key,
order_datetime timestamp,
med_number char(10),
patient_medical_record char(5),
physician_id char(5),
treatment_id char (5), 
foreign key(patient_medical_record) references patient(patient_medical_record),
foreign key(med_number) references medication(med_number),
foreign key(physician_id) references physician(physician_id)
);


create table if not exists treatment
(
treatment_id char(5),
treatment_datetime timestamp,
treatment_name varchar(30),
result varchar(100),
patient_medical_record varchar(5),
physician_id varchar(5), 
foreign key(patient_medical_record) references patient(patient_medical_record),
foreign key(physician_id) references physician(physician_id)
);


-- Populate Tables

delete from center;
insert into center values('C-101', 'Women Care', 'N-201');
insert into center values('C-102', 'MAGOPSA', 'N-202');
insert into center values('C-201', 'Bristow OBGYN Associates', 'N-212');
insert into center values('C-215', 'INOVA OBGYN', 'N-230');
insert into center values('C-217', 'Women Health and Wellness', 'N-232');
insert into center values('C-222', 'VCU Medical Center', 'N-251');
insert into center values('C-225', 'Mary Washington OBGYN', 'N-350');
insert into center values('C-281', 'Novant Health', 'N-150');
insert into center values('C-232', 'Howard Univeristy OBGYN', 'N-009');


insert into nurse values('N-202', 'Sarah Kinsley', 'C-225');
insert into nurse values('N-201', 'Andrea Smith', 'C-281');
insert into nurse values('N-212', 'Martha Stewart', 'C-201');
insert into nurse values('N-009', 'Lauren Khols', 'C-232');
insert into nurse values('N-150', 'Monica Norton', 'C-281');
insert into nurse values('N-230', 'Drashty Mody', 'C-217');


insert into patient_info values('MR-12', 'Het Patel', '01', 'P-10');
insert into patient_info values('MR-14', 'Abeeha Malik',  '02', 'P-12');
insert into patient_info values('MR-22', 'Katie Hodgson', '03', 'P-13');
insert into patient_info values('MR-24', 'Hanan Ismail', 04, 'P-11');
insert into patient_info values('MR-41', 'Maria Ghafoor',  '08', 'P-15');
insert into patient_info values('MR-29', 'Lina Freedy','10', 'P-18');
insert into patient_info values('MR-31', 'Christina Ware', '16', 'P-24');
insert into patient_info values('MR-65', 'Victoria Lopez', '23', 'P-17');
insert into patient_info values('MR-86', 'Casandra Smith', '28', 'P-29');
insert into patient_info values('MR-91', 'Hadassa Rocha', '33', 'P-41');


insert into bed values('33', 'R-105', 'Single', '1', '1','true', 'C-232');
insert into bed values('28', 'R-102', 'Single', '1', '1', 'false', 'C-281');
insert into bed values('04', 'R-201', 'Single', '1', '2', 'false','C-217');
insert into bed values('16', 'R-217', 'Single', '1','2', 'true', 'C-215');
insert into bed values('08', 'R-222', 'Double','1', '3', 'true', 'C-102');
insert into bed values('03', 'R-215', 'Double', '1','3',  'true', 'C-101');



insert into dx values('D25.9', 'Leiomyoma');
insert into dx values('N92.0', 'Menorrhagia');
insert into dx values('N83.2', 'Ovarian Cyst');
insert into dx values('D06.9', 'Cervical Intraepithelial Neoplasia');
insert into dx values('N95.0', 'Postmenopausal bleeding');
insert into dx values('N76.4', 'Vulvar Abscess');
insert into dx values('R19.0', 'Pelvic Mass');
insert into dx values('N89.8', 'Vaginal Cyst');


insert into physician values('P-10', 'Brown', 'Reproductive Endocrinology', 258000);
insert into physician values('P-11', 'Rose', 'Urogynecology', 315034);
insert into physician values('P-12', 'Bicher', 'Gynecologic Oncology', 331000);
insert into physician values('P-13', 'Smith', 'Gynecologic Oncology', 328790);
insert into physician values('P-15', 'Anderson', 'Gynecologic Oncology', 335246);
insert into physician values('P-17', 'Osbert', 'Urogynecology', 348650);
insert into physician values('P-18', 'Barlow', 'Maternal-Fetal Medicine', 505610);
insert into physician values('P-19', 'Gandhi', 'Maternal-Fetal Medicine', 448789);
insert into physician values('P-20', 'Somoza', 'Reproductive Endocrinology', 250436);
insert into physician values('P-24', 'Kochi', 'Gynecologic Oncology', 397689);
insert into physician values('P-29', 'Grant', 'Maternal-Fetal Medicine', 567843);
insert into physician values('P-41', 'Desai', 'Gynecologic Oncology', 295550);



insert into physician_dx values('2021-04-17 11:45:50', 'P-13', 'MR-22', 'N92.0');
insert into physician_dx values('2021-01-21 10:45:51', 'P-12', 'MR-14', 'N83.2');
insert into physician_dx values('2018-06-15 1:05:15', 'P-15', 'MR-41', 'R19.0');
insert into physician_dx values('2020-03-08 09:05:30', 'P-24', 'MR-31', 'N95.0');
insert into physician_dx values('2019-02-24 01:15:00', 'P-41', 'MR-91', 'D25.9');
insert into physician_dx values('2018-08-21 03:30:25', 'P-29', 'MR-86', 'N89.8');

insert into assessment values('V-01', '2021-04-17 11:30:00', 'abnormal vaginal bleeding', '115.4', '5.1', '122/98', '98.6', '73', 'MR-22', 'N-201', 'P-41' );
insert into assessment values('V-02', '2021-04-17 11:30:00', 'right ovary pain', '138.5', '5.8', '135/90', '97.5', '65', 'MR-14', 'N-212', 'P-24');
insert into assessment values('V-10', '2018-06-15 12:43:06', 'pelvic pain', '120.7', '4.5', '110/71', '96.5', '90', 'MR-41', 'N-202', 'P-13');
insert into assessment values('V-12', '2019-08-21 03:15:23', 'bleeding after menopause', '145.4', '5.5', '128/83', '98.1', '84', 'MR-31', 'N-230', 'P-24');
insert into assessment values('V-31', '2019-02-24 12:15:10', 'pelvic pressure', '155.3', '5.8', '134/91', '97.6', '86', 'MR-91', 'N-150', 'P-12');
insert into assessment values('V-15', '2020-03-08 08:45:51', 'vaginal pain', '138.4', '5.3', '119/75', '97.4', '91', 'MR-86', 'N-009', 'P-18');

delete from medication;
insert into medication values('M-01', 'Provera', '24.19');
insert into medication values('M-04', 'Lysteda', '179.55');
insert into medication values('M-07', 'Lupron Depot', '1393.33');
insert into medication values('M-15', 'Progestrone', '26.00');
insert into medication values('M-19', 'Metformin', '12.88');


insert into med_consumption values('2021-04-21', '5mg', 'M-01', 'MR-22' );
insert into med_consumption values('2021-01-27', '500mg', 'M-19', 'MR-14');
insert into med_consumption values('2018-06-20', '11.25mg', 'M-07', 'MR-41');
insert into med_consumption values('2020-03-15', '200mg', 'M-15', 'MR-31');
insert into med_consumption values('2019-02-26', '3900mg', 'M-04', 'M-91');

insert into ordernote values('O-02', '2021-01-21 10:47:54', 'M-19', 'MR-14', 'P-12', 'T-01');
insert into ordernote values('O-05', '2020-03-08 09:07:41', 'M-15', 'MR-31', 'P-24', 'T-02');
insert into ordernote values('O-10', '2018-06-15 01:08:15', 'M-07', 'MR-41', 'P-15', 'T-05');
insert into ordernote values('O-25', '2019-02-24 01:17:02', 'M-04', 'MR-91', 'P-41', 'T-10');
insert into ordernote values('O-18', '2021-04-17 11:50:41' , 'M-01', 'MR-22', 'P-13', 'T-12');


insert into treatment values('T-01', '2021-03-15 10:30:00', 'Oophorectomy', ' G2 Right Overian Cancer', 'MR-14', 'P-12');
insert into treatment values('T-02', '2020-03-15 10:30:00', 'Hysterectomy', 'G1 Endometrioid Cancer', 'MR-31', 'P-24');
insert into treatment values('T-05', '2018-07-30 01:30:00', 'Laparotomy.', 'G3 Endometrioid Cancer', 'MR-41', 'P-15');
insert into treatment values('T-10', '2019-03-21 02:30:00', 'Myomectomy', 'Submucosal uterine fibriod', 'MR-91', 'P-41');
insert into treatment values('T-12', '2021-05-21 11:00:00' , 'Hysteroscopy/D&C', 'Endometrial Polyps', 'MR-22', 'P-13');

-- Select: 
-- select involving one/more conditions in Where Clause
-- a. Find the name of pateints whose first name starts with a C and room number is less than 30
select patient_name
from patient_info
where patient_name LIKE 'C%' and bed_number < 30;

-- b. Find the pateint name whose primary OBGYN doctor's name is Desai.
select patient_name from patient_info, physician
where physician_name = 'Desai'
and patient_info.physician_id = physician.physician_id;

-- 2. select with aggregate functions (i.e., SUM, MIN, MAX, AVG, COUNT)

-- a. Find the number of available rooms
SELECT count(*) "Number of available rooms"
FROM bed
WHERE available ='true';

-- b. count the number of unavailable rooms for each block in each floor.
SELECT block_floor as "Floor",
       count(*) AS  "No of available rooms"
FROM bed
WHERE available='true'
GROUP BY block_floor
HAVING count(*) =
  (SELECT max(zz) AS highest_total
   FROM
     ( SELECT block_floor ,
              count(*) AS zz
      FROM bed
      WHERE available='true'
      GROUP BY block_floor ) AS t );
   
 -- 3. select with Having, Group By, Order By clause
-- a.  Count the number of unavailable rooms for each block in each floor.
SELECT block_floor AS "Floor",
       block_code AS "Block",
       count(*) "Number of unavailable rooms"
FROM bed
WHERE available='false'
GROUP BY block_floor,
        block_code
ORDER BY block_floor,
        block_code;
-- b. Find all nurses who are on call for single room types only,
select nurse_name from nurse 
where nurse.center_id in
(select center_id from bed
where room_type = 'Single'
group by block_code);


-- 4. Nested Select
-- a. Show visit notes from all patients who's attending nurse's name starts with the letter M or D.
select visit_notes from assessment
where assessment.nurse_id in
(select nurse_id from nurse
where nurse_name LIKE 'M%' OR 'D%');

-- b. Find the names of patients who have undergone a hysterectomy.
select patient_name from patient_info
where patient_info.patient_medical_record in
(select patient_medical_record from treatment
where treatment_name = 'Hysterectomy');

-- c. Find the name of patients and treating physician whose new GYN appointment was scheduled for on the 17th of April at 11:30 AM. 
SELECT patient_name AS "Name of the patient",
       physician_name AS "Name of the physician",
       a.appointment_datetime
FROM patient_info patient_name
JOIN assessment a ON a.patient_medical_record=patient_name.patient_medical_record
JOIN physician p ON a.physician_id=p.physician_id
WHERE appointment_datetime ='2021-04-17 11:30:00';

-- 5. select involving the Union operation
--  Find the names of the nurses who work at Bristow ONGYN Associates, attending a patient scheduled for 17th of April at 11:30 AM,  or both
select nurse_name from nurse where nurse.nurse_id in
(select nurse_id from center where center_name = 'Bristow OBGYN Associates')
UNION
select nurse_name from nurse where nurse.nurse_id in
(select nurse_id from assessment where appointment_datetime = '2021-04-17 11:30:00');

-- Return the pulse rate of the patients with the lowest pulse rate and the highest.

SELECT patient_name AS "Name of the patient",
       a.patient_weight
FROM patient_info patient_name
JOIN assessment a ON a.patient_medical_record=patient_name.patient_medical_record
where patient_weight > 130
UNION
SELECT patient_name AS "Name of the patient",
       a.patient_weight
FROM patient_info patient_name
JOIN assessment a ON a.patient_medical_record=patient_name.patient_medical_record
where patient_weight < 130;

-- 6. insert one tuple into a table
INSERT INTO treatment (treatment_id, treatment_datetime, treatment_name, result, patient_medical_record, physician_id)
VALUES ('T-18', '2017-12-24 10:30:00', 'Vaginectomy', 'Clear cell adenocarcinoma of the vagina', 'MR-86', 'P-18');
select * from treatment;

-- 7. insert a set of tuples (by using another select statement) insert involving two tables.
INSERT INTO center(center_id, full_name, nurse_id)
SELECT nurse_id, full_name, center_id
FROM nurse;

-- 8. delete one tuple or a set of tuples: from one table, from multiple tables.
-- a. Delete all patients with height less than 5.0

DELETE FROM assessment
WHERE patient_height < 5.0 ;
select * from assessment;




-- b. Delete appointment date for pateint with medical record number MR-22 from the assessment table and delete their scheuled treatment date in the treatment table:

DELETE assessment,  treatment FROM assessment
INNER join treatment on assessment.patient_medical_record = treatment.patient_medical_record
where assessment.patient_medical_record = 'MR-22' ;
select * from assessment;
select * from treatment;

-- 9. update one tuple or a set of tuples: from one table, from multiple tables. 
-- a. Update each price of medication by fifty percent
update medication
set medication.med_totalcost = medication.med_totalcost * 0.5;
select * from medication;

-- b. Update  medication name, dose, for medictation id 'M-19'
update medication, med_consumption
set med_consumption.dose= 'Taxol 175mg/m2 IV + carbo 5-6 mg·min/mL IV',
medication.med_name = 'Carbo/Taxol'
where medication.med_number = 'M-19'
AND med_consumption.med_number = 'M-19';

select * from medication;
select * from med_consumption;

-- 10. Create View: - based on one relation and more than one relation: 
-- one relation
Create view Single as
Select * from bed
where room_type ="Single";

-- More than one relation – a view of dx names of those codes that start with the letter 'N'

create view DxStartWithN as
select * from dx
where dx.dx_code in
(select dx_code from physician_dx
where dx_code LIKE 'N%');

-- 11. operate on View (i.e., select, insert, delete, update,..):
Select * from Single
where available = 'false';

INSERT INTO Single (bed_number, room_number, room_type, block_floor, block_code, available, center_id)
VALUES (45, 'R-103', 'Single', '1', '3', 'true', 'C-201');
SELECT * from Single;


DELETE FROM  DxStartWithN
WHERE dx_name LIKE '%Cyst%';
SELECT * FROM DxStartWithN;

update Single
set Single.available = 'true';
SELECT * FROM Single;

-- B) Also, create at least 4 different practical/useful triggers (written in following tasks: MySQL) for your database to perform the 

-- - enforcing referential integrity: Delete patient assessment  when patients are deleted. To trigger this you will delete a tuple,
-- or multiple tuples, from the patient_info table.
drop trigger assessment_delete
Delimiter $$
create trigger assessment_delete after delete on patient_info
for each row
begin
delete from assessment where patient_medical_record = old.patient_medical_record;
end;
$$
-- Activitation
-- delete from patient_info where patient_medical_record = 'MR-41';
-- select * from assessment
-- select * from physician_info


-- enforcing attribute domain constraints: Setting a salary limit - varchar constraints. To trigger this you will add a salary raise of greater than 5% 
-- through an update, which will ensure that there are no salary raises greater than 5% when triggered. 

Delimiter $$
Create trigger LimitSalaryRaise 
after update on physician
For each row
Begin
if (new.salary - old.salary) > (0.05*old.salary) then
insert into mylog values("Physician salary is raised more than 5 percent");
end if;
end;
$$
-- Activating Trigger
update physician set salary=salary+1000 where physician_name= 'Rose' ;
select * from physician


-- creating database log


Create table MyLog (message varchar(70));

drop trigger add_physician
Delimiter $$
create trigger add_physician after insert on physician
for each row
begin
insert into MyLog values(concat("physician has been added by", current_user(), "on", current_date()));
end;
$$
insert into physician values('P-51','Jackson', 'Reproductive Endocrinology', 350547);
insert into physician values('P-76', 'Trueman', 'Maternal-Fetal Medicine', 515845);
select * from physician;
select * from MyLog;


Delimiter $$
create trigger update_physician after update on physician
for each row
begin
insert into MyLog values(concat('physician has been updated by ',current_user(), ' on ',current_date()));
end;
$$
update physician set salary=salary + 0.10 * salary where physician_name ='Somoza';
select * from physician;
select * from MyLog;

Delimiter $$
create trigger delete_physician after delete on physician
for each row
begin
insert into MyLog values(concat('physician has been deleted by ',current_user(), ' on ',current_date()));
end;
$$
delete from physician where physician_name ='Bicher';
select * from physician;
select * from MyLog;

-- gathering statistics: make a summary table on employee salaries. 
-- To trigger this a new employee will be added, and we will receive a summary table which gives us descriptive statistics.
create table salary_summary(subspeciality varchar(30),minsalary double, maxsalary double, avgsalary double);


Delimiter $$
create trigger salary_insert after insert on physician
for each row
begin
delete from salary_summary;
insert salary_summary
select subspeciality, min(salary),max(salary),avg(salary) from physician group by subspeciality;
end;
$$
insert into physician values ('P-09', 'Johnson', 'Urogynecology', '337834');
insert into physician values ('P-25', 'Roberts', 'Gynecologic Oncology', '382456');
select * from salary_summary;


























