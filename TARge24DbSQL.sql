-- 1tund 26.02.25

create database TARge24

--db valimine
use TARge24

-- db kustutamine
drop database TARge24

--2und 05.03.2025

--tabeli loomine
create table Gender
(
Id int not null primary key,
Gender nvarchar(10) not null
)

--andmete sisestamine
insert into Gender (Id, Gender)
values (2, 'Male')

insert into Gender (Id, Gender)
values (1, 'Female'),
(3, 'Unknown')

--vaatame tabeli andmeid / * jarjestab ID jargi
select * from Gender

create table Person
(
Id int not null primary key,
Name nvarchar(30),
Email nvarchar(30),
GenderId int
)

--andmete sisestamine
insert into Person (Id, Name, Email, GenderId)
values (1, 'Superman', 's@s.com', 2),
(2, 'Wonderwoman', 'w@w.com', 1),
(3, 'Batman', 'b@b.com', 2),
(4, 'Aquaman', 'a@a.com', 2),
(5, 'Catwoman', 'c@c.com', 2),
(6, 'Antman', 'ant"ant.com', 2),
(8, NULL, NULL, 2)

select * from Person

--v��rv�tme �henduse loomine kahe tabeli vahel
alter table Person add constraint tblPerson_GenderId_FK
foreign key (GenderId) references Gender(Id

--kui sisestad uue rea andmeid ja ei ole sisestanud GenderId alla v��rtust,
--siis see automaatselt sisestab sellele reae v��rtuse 3 e naru meil on unknown
alter table Person
add constraint DF_Person_GenderId
default 3 for GenderId

select * from Person

insert into Person (Id, Name, Email)
values (7, 'Spiderman', 'spider@s.com')

--piirangu kustutamine
alter table Person
drop constraint DF_Person_GenderId

--lisame veeru
alter table Person
add Age nvarchar(10)

--lisame nr piirangu vanuse sisestamisel
alter table Person
add constraint CK_Person_Age check (Age > 0 and Age < 155)

--rea kustutamine
delete from Person where Id = 8

select * from Person

--kuidas uuendada andmeid
update Person
set Age = 19
where Id = 7

select * from Person

--lisame veeru juurde
alter table Person
add City nvarchar(50)

--k�ik kes elavad Gotham linnas
select * from Person where City = 'Gotham'

--k�ik kes ei ela Gothamis
select * from Person where City != 'Gotham'
select * from Person where City <> 'Gotham'

--n�itab teatud vanusega olevaid inimesi
select * from Person where Age = 100 or Age = 45 or Age = 19
select * from Person where Age in (100, 45, 19)

--n�itab teatud vanusevahemikus olevaid inimesi
select * from Person where Age between 27 and 31

--wildcard e n�itab k�ik g-t�hefa linnad
select * from Person where City like 'g%'
select * from Person where City like '%g%'

--n�itab k�iki, kellel ei ole @-m�rki emailis
select * from Person where Email not like '%@%'

--n�itab k�iki, kellel on emailis ees ja peale @-m�rki ainult �ks t�ht
select * from Person where Email like '_@_.com'

--k�ik, kellel nimes ei ole esimene t�ht W, A, S
select * from Person where Name like '[^WAS]%'
select * from Person 

--k�ik kes elavad Gothamis ja New Yorkis
select * from Person where City = 'Gotham' or City = 'New York'
select * from Person where City in ('Gotham', 'New York')

--k�ik kes elavad v�lja toodud linnades ja on vanemad ning kuni 29 a
select * from Person where (City = 'Gotham' or City = 'New York') and (Age <= 29)

--kuvab t�histikulises j�rjekorras inimesi ja v�tab aluseks nime
select * from Person order by Name
--kuvab vastupidises j�rjestuses
select * from Person order by Name desc

--v�tab kolm esimest rida
select top 3 * from Person

--kolm esimest, aga tabeli j�rjestus on Age ja siis Name
select top 3 Age, Name from Person

-- 3tund 12.03.2025

--n�ita esimesed 50% tabelis
select top 50 percent * from Person

--j�rjestab vanuse j�rgi isikud
-- see p�ring ei j�rjesta numbreid �igesti kuna Age on varchar
select * from Person order by Age desc

-- castime Age int andmet��biks ja siis j�rjestab �igesti
select * from Person order by CAST(Age as int)

-- k�ikide isikute koondvanus
select sum(cast(Age as int)) as TotalAge from Person
select sum(cast(Age as int)) as [Total Age] from Person

--k�ige noorem isik
select min(cast(Age as int)) from Person

--k�ige vanem isik
select max(cast(Age as int)) from Person

--keskmine vanus
select avg(cast(Age as int)) from Person

-- n�eme konkreetsetes linnades olevat isikute koondvanust
-- enne oli Age string, aga enne p�ringut muudame selle inr-ks
select City, sum(Age) as TotalAge from Person group by City

-- n��d muudame muutuja andmet��pi koodiga
alter table Person
alter column Name nvarchar(25)

-- kuvab esimeses reas v�lja toodud j�rjestuses ja kuvab Age-i totalAge-ks
-- j�rjestab City-s olevate nimede j�rgi ja siis GenderId j�rgi
select City, GenderId, sum(Age) as TotalAge from Person
group by City, GenderId order by City

-- n�itab mitu rida on selles tabelis
select count(*) from Person
select * from Person

-- n�itab tulemust, mitu inimest on GenderId v��rtusega 2 konkreetses linnas
-- veel arvutab vanuse kokku
select City, GenderId, sum(Age) as TotalAge, count(Id) as [Total Person(s)]
from Person
where GenderId = '2'
group by GenderId, City

insert into Person values
(10, 'Black Panter', 'b@b.com', 2, 34, 'New York')

-- n�itab �ra inimeste koondvanuse, kelle vanus on v�hemal 29 a
-- kui palju neid igas linnas elab
select GenderId, City, sum(Age) as TotalAe, count(Id)
as [Total Person(s)]
from Person
group by GenderId, City having sum(Age) > 29


-- loome tabelid Employees ja Department
create table Department
(
Id int primary key,
DepartmentName nvarchar(50),
Location nvarchar(50),
DepartmentHead nvarchar(50)
)

create table Employees
(
Id int primary key,
Name varchar(50),
Gender nvarchar(50),
Salary nvarchar(50),
DepartmentId int
)

insert into Employees values
(1, 'Tom', 'Male', 4000, 1),
(2, 'Pam', 'Female', 3000, 3),
(3, 'John', 'Male', 3500, 1),
(4, 'Sam', 'Male', 4500, 2),
(5, 'Todd', 'Male', 2800, 2),
(6, 'Ben', 'Male', 7000, 1),
(7, 'Sara', 'Female', 4800, 3),
(8, 'Valarie', 'Female', 5500, 1),
(9, 'James', 'Male', 6500, NULL),
(10, 'Russel', 'Male', 8800, NULL)

select * from Employees

insert into Department values
(1, 'IT', 'London', 'Rick'),
(2, 'Payroll', 'Delhi', 'Ron'),
(3, 'HR', 'New York', 'Christie'),
(4, 'Other Department', 'Sydney', 'Cindrella')

select * from Department

-- left join
select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id

-- arvutab k�ikide palgad kokku
select sum(CAST(Salary AS int)) AS [Palgad Kokku]
from Employees

-- k�ige v�iksema palgasaaja palk
select min(CAST(Salary AS int))
from Employees

-- �he kuu palgafond linnade l�ikes
select Location, sum(cast(Salary as int)) as TotalSalary
from Employees
left join Department
on Employees.DepartmentId = Department.Id
group by Location

alter table Employees
add City nvarchar(30)

--sooline erip�ra palkade osas
select City, Gender, sum(cast(Salary as int)) as TotalSalary
from Employees
group by City, Gender

--sama nagu eelmine aga linnad on t�hestikulises j�rjekorras
select City, Gender, sum(cast(Salary as int)) as TotalSalary
from Employees
group by City, Gender
order by City

-- loeb �ra, mitu rida andmeid on tabelis,
-- t�rni asemele v�ib panna muid veergude nimetusi
select count(*) from Employees
select count(Name) from Employees
select count(DepartmentId) from Employees

-- mitu t��tajat on soo ja linna kaupa selles tabelis
select Gender, City, count(Id) as [Total Employee(s)]
from Employees
group by Gender, City

-- n�itab k�ik mehed linnade kaupa
select Gender, City, count(Id) as [Total Employee(s)]
from Employees
where Gender = 'Male'
group by Gender, City

-- n�itab k�ik naised linnade kaupa
select Gender, City, count(Id) as [Total Employee(s)]
from Employees
group by Gender, City
having Gender = 'Female'

-- kelle palk on v�hemalt �le 4000
select Id, Name, Cast(Salary As Int)
from Employees
where Salary > 4000

-- k�igil kellel on palk �le 4000 ja arvuta bneed kokku ning n�itab soo kaupa
select Gender, City, sum(cast(Salary as int)) as TotalSalary, count (Id) as [Total Employee(s)]
from Employees group by Gender, City
having sum(cast(Salary As int)) > 4000

-- loome tabeli, milles hakatakse nummerdama Id-d
create table Test1
(
Id int identity(1,1),
Value nvarchar(20)
)

insert into Test1 values('X')
select * from Test1

-- kustutage �ra City veerg Employees tabelist
alter table Employees
drop column City


-- inner join
-- kuvab neid, kellel on DepartmentName all olevas v��rtus
select Name, Gender, Salary, DepartmentName
from Employees
inner join Department
on Employees.DepartmentId = Department.Id

-- left join
-- kuidas saada k�ik andmed Employees tabelist k�tte
select Name, Gender, Salary, DepartmentName
from Employees
left join Department -- v�ib kasutda ka LEFT OUTER JOIN-i
on Employees.DepartmentId = Department.Id

-- right join
-- kuidas saada DeartmentName alla uus nimetus e antud juhul Other Department
select Name, Gender, Salary, DepartmentName
from Employees
right join Department
on Employees.DepartmentId = Department.Id

-- full outer join
-- kuidas saada k�ikide tabelite v��rtused �hte p�ringusse
select Name, Gender, Salary, DepartmentName
from Employees
full outer join Department
on Employees.DepartmentId = Department.Id

-- cross join
-- v�tab kaks allpool olevat tabelit kokku ja korrutab need omavahel l�bi
select Name, Gender, Salary, DepartmentName
from Employees
cross join Department

-- p�ringu sisu
select ColumnList
from LeftTable
joinType RightTable
on JoinCondition

-- kuidas kuvada ainult need isikud, kellel on DepartmentName NULL
select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null

-- 4tund 19.03.2025
-- kuidas kuvada ainult need isikud, kellel on DepartmentName NULL
-- teine variant
select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id
where Department.Id is null

-- kuidas saame Departmnt tabelis oleva rea, kus on NULL
select Name, Gender, Salary, DepartmentName
from Employees
right join Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null

--full join
--m�lema tabeli mitte-kattuvate v��rtustega read kuvab v�lja
select Name, Gender, Salary, DepartmentName
from Employees
full join Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null or Department.Id is null

--saa�me muuta tabeli nimetust, alguses vana tabeli nimi ja uus soovitud
sp_rename 'Department', 'Department123'

sp_rename 'Department123', 'Department'

--teeme left join-i, aga Employees tabeli nimetus on l�hendina: E
select Name, DepartmentName
from Employees E
left join Department
on E.DepartmentId = Department.Id

select E.Name as Employee, M.Name as Manager
from Employees E
left join Employees M
on E.ManagerId = M.Id


alter table Employees
add ManagerId int

--inner join
--kuvab ainult ManagerId all olevate isikute v��rtuseid
select E.Name as Employee, M.Name as Manager
from Employees E
inner join Employees M
on E.ManagerId = M.Id

--cross join
--k�ik saavad k�ikide �lemused olla
select E.name as Employee, M.Name as Manager
from Employees E
cross join Employees M

select isnull('Asd', 'No manager') as Manager

--Null asemel kuvab No Manager
select coalesce(NULL, 'No Manager') as Manager

--neil kellel ei ole �lemust, siis paneb neile 'No Manager' teksti
select E.Name as Employee, isnull(M.Name, 'No Manager') as Manager
from Employees E
left join Employees M
on E.ManagerId = M.Id

--teeme p�ringu, kus kasutame case-i
select E.Name as Employee, case when M.Name is null then 'No Manager'
else M.Name end as Manager
from Employees E
left join Employees M
on E.ManagerId = M.Id

--lisame taeli uued veerud
alter table Employees
add MiddleName nvarchar(30)
alter table Employees
add LastName nvarchar(30)

--Note: If no permission to save table (design) 'tools > options > designers > table and database designers > *uncheck* Prvent saving changes that require table re-creation'

--muudame veeru nime / teine variant >> design table
sp_rename 'Employees.Name', 'FirstName'

-- andmete lisamine
select * from Employees

update Employees 
set MiddleName = 'Nick', LastName = 'Jones'
where Id = 1;

update Employees 
set LastName = 'Anderson'
where Id = 2;

update Employees 
set LastName = 'Smith'
where Id = 4;

update Employees 
set FirstName = NULL, MiddleName = 'Todd', LastName = 'Someone'
where Id = 5;

update Employees 
set MiddleName = 'Ten', LastName = 'Seven'
where Id = 6;

update Employees 
set LastName = 'Connor'
where Id = 7;

update Employees 
set MiddleName = 'Balerine'
where Id = 8;

update Employees 
set MiddleName = '007', LastName = 'Bond'
where Id = 9;

update Employees 
set LastName = 'Crowe'
where Id = 10;

select * from Employees

--igast reast v�tab esimesena t�idetud lahtri ja kuvab ainult seda
select Id, coalesce(FirstName, MiddleName, LastName) as Name
from Employees


--loome kaks tbelit juurde
create table IndianCustomers
(
Id int identity(1,1),
Name nvarchar(25),
Email nvarchar(25)
)

create table UKCustomers
(
Id int identity(1,1),
Name nvarchar(25),
Email nvarchar(25)
)

--sisestame andmeid
insert into IndianCustomers (Name, Email)
values ('Raj', 'R@R.com'),
('Sam', 'S@S.com')

insert into UKCustomers (Name, Email)
values ('Ben', 'B@B.com'),
('Sam', 'S@S.com')

select * from IndianCustomers
select * from UKCustomers

--kasutame union all, n�itab k�iki ridu
select Id, Name, Email from IndianCustomers
union all
select Id, Name, Email from UKCustomers

--korduvate v��rtustega read pannakse �hte ja ei korrata
select Id, Name, Email from IndianCustomers
union
select Id, Name, Email from UKCustomers

-- kasuta union all ja sorteeri nime j�rgi
select Id, Name, Email from IndianCustomers
union all
select Id, Name, Email from UKCustomers
order by Name

--stored procedure
create procedure spGetEmployees
as begin
	select FirstName, Gender from Employees
end

-- kutsuda stored procedure esile
--1:
spGetEmployees
--2:
exec spGetEmployees
--3:
execute spGetEmployees

create proc spGetEmployeesByGenderAndDepartment
@Gender nvarchar(20),
@DepartmentId int
as begin
	select FirstName, Gender, DepartmentId from Employees
	where Gender = @Gender and DepartmentId = @DepartmentId
end

--kutsume sp esile, selle puhul tuleb sisestda parameetrid
spGetEmployeesByGenderAndDepartment 'Male', 1

--niimodi saab sptahetud j�rjekorrast m��da minna, kui ise paned muutujad paika
spGetEmployeesByGenderAndDepartment @departmentId = 1, @Gender = 'Male'

--saab sp sisu vaadata result vaates
sp_helptext spGetEmployeesByGenderAndDepartment

--kuidas muuta sp-d ja v�ti peale panna, et keegi teine ei saaks muuta
alter proc spGetEmployeesByGenderAndDepartment
@Gender nvarchar(20),
@DepartmentId int
with encryption --paneb v�tme peale
as begin
	select FirstName, Gender, DepartmentId
	from Employees
	where Gender = @Gender and DepartmentId = @DepartmentId
end

sp_helptext spGetEmployeesByGenderAndDepartment

--sp tegemine
create proc spGetEmployeeCountbyGender
@Gender nvarchar(20),
@EmployeeCount int output
as begin
	select @EmployeeCount = count(Id) from Employees where Gender = @Gender
end

--annab tulemuse, kus loendab �ra n�uetele vaastav read
--prindib ka tulemuse kirja teel
declare @TotalCount int
execute spGetEmployeeCountByGender 'Female', @TotalCount out
if(@TotalCount = 0)
	print '@TotalCount is null'
else
	print '@Total is not null'
print @TotalCount

--n�itab �ra, et mitu rida vastab n�uetele
declare @TotalCount int
execute spgetEmployeeCountByGender @EmployeeCount = @totalCount out, @gender = 'Male'
print @TotalCount

--sp sisu vaatamine
sp_help spgetEmployeeCountByGender
--tabeli info
sp_help Employees
--kui soovid sp teksti n�ha
sp_helptext spgetEmployeeCountByGender

--millest s�ltub sp seesp
sp_depends spgetEmployeeCountByGender

--vaatame tabeli s�tuvust
sp_depends Employees

--
create proc spGetNameById
@Id int,
@Name nvarchar(20) output
as begin
	select @Id = Id, @Name = FirstName
	from Employees
end

--veateadet ei n�ita, aga tulemust ka ei ole
spGetNameById 1, 'Tom'

--t��tav variant
declare @FirstName nvarchar(20)
execute spGetnameById 1, @FirstName output
print 'name of the employee = ' + @FirstName

--uus sp
create proc spGetNameById2
@Id int,
@Name nvarchar(20) output
as begin
	select @Id = Id, @Name = FirstName
	from Employees where Id = @Id
end

declare @FirstName nvarchar(20)
execute spGetnameById2 1, @FirstName output
print 'name of the employee = ' + @FirstName

-- 5 tund 26.03.2025
declare
@FirstName nvarchar(20)
execute spGetNameById1 1, @FirstName out
print 'Name = ' + @FirstName

create proc spGetnameById3
@Id int
as begin
	return (select FirstName from Employees where Id = @Id)
end

-- tuleb veateade kuna kutsusime v�lja int-i, aga Tom on string
declare @EmployeeName nvarchar(50)
execute @EmployeeName = spGetnameById3 1
print 'Name of the employee = ' + @EmployeeName

-- sisseehitatud string funktsioonid
-- see konverteerib ASCII t�he v��rtuse numbriks
select ASCII('a')

--Kuvab A-t�he
select char('A')

-- prindim kogu t�hesiku v�lja
declare @Start int
set @Start = 97

while (@Start <= 122)
begin 
	select char (@start)
	set @Start = @Start + 1
end

-- eemaldame t�hjad kohad sulgudes vasakult poolt
select ltrim('          Hello')

select * from Employees

-- t�hikute eemaldamine veerust
select LTRIM(FirstName) as [First Name], MiddleName, LastName from Employees

--paremalt poolt eemaldab t�hjad stringid
select RTRIM('Hello  --                 ')

-- 6 tund 02.04.2025

--keera kooloni sees olevad andmed vastupidiseks
--vastavalt upper ja lower-ga saan muuta m�rkide suurust
--reverse funktsioon p��rab k�ik �mber
select reverse(upper(ltrim(FirstName))) as [First Name], MiddleName, lower(LastName) as LastName,
rtrim(ltrim(FirstName)) + ' ' + MiddleName + ' ' + LastName as FullName
from Employees

--n�itab, et mitu t�hte on s�nal ja loeb t�hikud sisse
select FirstName, len(FirstName) as [Total Characters] from Employees

--eemaldame t[hikud ja ei loe sesse ???
select FirstName, len(trim(FirstName)) as [Total Characters] from Employees

--left, right ja substring
--vasakult poolt neli esimest t�hte
select LEFT('ABCDEF', 4)

--paremalt poolt kolm t�hte
select RIGHT('ABCDEF', 3)

--kuvab @-t�hem�rgi asetust
select CHARINDEX('@', 'sarda@aaa.com')

--esimene number peale komakohta n�itab, et mitmendast alustab 
--ja siis mitu nr peale seda
select SUBSTRING('pam@bbb.com', 5, 4)

--@-m�rgist kuvab kom t�hem�rki. Viimase nr saab m��rata pikkust
select substring('pam@bbb.com', CHARINDEX('@', 'pam@bbb.com') + 1,2)

--peale @-m�rki reguleerib t�hem�rkide pikkuse n�itamist
select substring('pam@bbb.com', CHARINDEX('@', 'pam@bbb.com') + 1,
len('pam@bbb.com') - charindex('@', 'pam@bbb.com'))



alter table Employees
add Email nvarchar(20)

select * from Employees

update Employees
set Email = 'Tom@aaa.com'
where Id = 1

update Employees
set Email = 'Pam@bbb.com'
where Id = 2

update Employees
set Email = 'John@aaa.com'
where Id = 3

update Employees
set Email = 'Sam@bbb.com'
where Id = 4

update Employees
set Email = 'Todd@bbb.com'
where Id = 5

update Employees
set Email = 'Ben@ccc.com'
where Id = 6

update Employees
set Email = 'Sara@ccc.com'
where Id = 7

update Employees
set Email = 'Valarie@aaa.com'
where Id = 8

update Employees
set Email = 'james@bbb.com'
where Id = 9

update Employees
set Email = 'Russel@bbb.com'
where Id = 10

select * from Employees

--tahame teada saada domeeninimed emailides
select SUBSTRING(Email, CHARINDEX('@', Email) + 1,
len(Email) - charindex('@', Email)) as EmailDomain 
from Employees

--lisame *-m�rgi alates teatud kohast
select FirstName, LastName,
	SUBSTRING(Email, 1, 2) + REPLICATE('*', 5) + --peale teist t�hem�rki paneb viis t�rni
	SUBSTRING(Email, CHARINDEX('@', Email), len(Email) - charindex('@', Email) + 1) as Email --kuni @-m�rgini on d�naamiline
	from Employees

--kolm korda n�itab stringis plevat v��rtust
select REPLICATE('asd', 3)

--kuidas sisestada t�hikut kahe nime vahele
select FirstName + ' ' + LastName as FullName from Employees

select concat(FirstName, ' ', LastName) as FullName from Employees

--t�hikute arv kahe nime vahel
select FirstName + space(20) + LastName as FullName from Employees


--PATINDEX
--sama, mis CHARINDEX, aga d�naamilisem ja saab kasutada wildcardi
select Email, PATINDEX('%@aaa.com', Email) as FirstOccurence
from Employees
where PATINDEX('%@aaa.com', Email) > 0 --leian k�ik selle domeeni esindajad ja
--alates mitmendast m�rgist algab @

--- k�ik .com-d asendatakse .net-ga
update Employees
SET Email = REPLACE(Email, '.com', '.net')
where Email LIKE '%.com'

select * from Employees

--soovin asendada peale esimest m�rki kolm t�hte viie t�rniga
--peate kasutama stuff-i
select FirstName, LastName, Email,
	stuff(Email, 2, 3, '*****') as [Stuffed Email]
from Employees

--------
--aja�hikute tabel
create table DateTime
(
c_time time,
c_date date,
c_smalldatetime smalldatetime,
c_datetime datetime,
c_datetime2 datetime2,
c_datetimeoffset datetimeoffset
)

select * from DateTime

--konkreetse masina kellaaeg
select GETDATE(), 'GETDATE()'

insert into dateTime
values (getdate(), getdate(), getdate(), getdate(), getdate(), getdate())

--muudame tabeli andmeid
update DateTime
set c_datetimeoffset = '2025-04-02 14:06:41.4666667 +10:00'
where c_datetimeoffset = '2025-04-02 14:06:41.4666667 +00:00'

select CURRENT_TIMESTAMP, 'CURRENT TIMESTAMP' --aja p�ring
-- leida veelkolm aja p��ringut
select CURRENT_TIME, 'CURRENT TIME'
select CURRENT_DATE, 'CURRENT DATE'


select SYSDATETIME()
select SYSDATETIME()
select SYSDATETIMEOFFSET()
select SYSUTCDATETIME()

select GETDATE()
select GETUTCDATE()

---
select isdate('asd') -- tagastab 0 kuna string ei ole date
select isdate(GETDATE()) -- tagastab 1 kuna on aeg
select isdate('2025-04-02 14:06:41.4666667') -- tagastab 0 kuna max 3 numbrit peale koma tohib olla
select isdate('2025-04-02 14:06:41.466') --tagastab 1


select day(getdate())	-- annab t�nase p�eva nr
select day('01/31/2025') -- annab stringis oleva kp ja j�rjestus peab olema �ige

select month(getdate())	-- annab jooksva kuu arvu
select month('01/31/2025') -- annab stringis oleva kuu nr

select year(getdate())	-- annab jooksva aasta arvu
select year('01/31/2025') -- annab stringis oleva aasta nr

-----
create table EmployeesWithDates
(
Id nvarchar(2),
Name nvarchar(20),
DateOfBirth datetime
)

insert into EmployeesWithDates (Id, Name, DateOfBirth)
values(1, 'Sam', '1980-12-30 00:00:00.000'),
(2, 'Pam', '1982-09-01 12:02:36.260'),
(3, 'John', '1985-08-22 12:03:30.370'),
(4, 'Sara', '1979-11-29 12:59:30.670')

select * from EmployeesWithDates

-- kuidas v�tta veerust andmeid ja selle abil luua uued veerud
select Name, DateOfBirth, DATENAME(WEEKDAY, DateOfBirth) as [Day], --vaatab DoB veerust p�eva ja kuvab p�eva nimetuse sinna
	MONTH(dateOfBirth) as MonthNumber, --vt DoB veerust kp-d ja kuvab kuu nr
	DATENAME(Month, DateOfBirth) as [MonthName], --vt DoB veerust kp-d ja kuvab kuu s�nana
	Year(DateOfBirth) as [Year] --vt DoB veerust aasta nr
from EmployeesWithDates