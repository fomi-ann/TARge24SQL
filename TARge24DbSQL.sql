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

--võõrvõtme ühenduse loomine kahe tabeli vahel
alter table Person add constraint tblPerson_GenderId_FK
foreign key (GenderId) references Gender(Id

--kui sisestad uue rea andmeid ja ei ole sisestanud GenderId alla väärtust,
--siis see automaatselt sisestab sellele reae väärtuse 3 e naru meil on unknown
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

--kõik kes elavad Gotham linnas
select * from Person where City = 'Gotham'

--kõik kes ei ela Gothamis
select * from Person where City != 'Gotham'
select * from Person where City <> 'Gotham'

--näitab teatud vanusega olevaid inimesi
select * from Person where Age = 100 or Age = 45 or Age = 19
select * from Person where Age in (100, 45, 19)

--näitab teatud vanusevahemikus olevaid inimesi
select * from Person where Age between 27 and 31

--wildcard e näitab kõik g-tähefa linnad
select * from Person where City like 'g%'
select * from Person where City like '%g%'

--näitab kõiki, kellel ei ole @-märki emailis
select * from Person where Email not like '%@%'

--näitab kõiki, kellel on emailis ees ja peale @-märki ainult üks täht
select * from Person where Email like '_@_.com'

--kõik, kellel nimes ei ole esimene täht W, A, S
select * from Person where Name like '[^WAS]%'
select * from Person 

--kõik kes elavad Gothamis ja New Yorkis
select * from Person where City = 'Gotham' or City = 'New York'
select * from Person where City in ('Gotham', 'New York')

--kõik kes elavad välja toodud linnades ja on vanemad ning kuni 29 a
select * from Person where (City = 'Gotham' or City = 'New York') and (Age <= 29)

--kuvab tähistikulises järjekorras inimesi ja võtab aluseks nime
select * from Person order by Name
--kuvab vastupidises järjestuses
select * from Person order by Name desc

--võtab kolm esimest rida
select top 3 * from Person

--kolm esimest, aga tabeli järjestus on Age ja siis Name
select top 3 Age, Name from Person

-- 3tund 12.03.2025

--näita esimesed 50% tabelis
select top 50 percent * from Person

--järjestab vanuse järgi isikud
-- see päring ei järjesta numbreid õigesti kuna Age on varchar
select * from Person order by Age desc

-- castime Age int andmetüübiks ja siis järjestab õigesti
select * from Person order by CAST(Age as int)

-- kõikide isikute koondvanus
select sum(cast(Age as int)) as TotalAge from Person
select sum(cast(Age as int)) as [Total Age] from Person

--kõige noorem isik
select min(cast(Age as int)) from Person

--kõige vanem isik
select max(cast(Age as int)) from Person

--keskmine vanus
select avg(cast(Age as int)) from Person

-- näeme konkreetsetes linnades olevat isikute koondvanust
-- enne oli Age string, aga enne päringut muudame selle inr-ks
select City, sum(Age) as TotalAge from Person group by City

-- nüüd muudame muutuja andmetüüpi koodiga
alter table Person
alter column Name nvarchar(25)

-- kuvab esimeses reas välja toodud järjestuses ja kuvab Age-i totalAge-ks
-- järjestab City-s olevate nimede järgi ja siis GenderId järgi
select City, GenderId, sum(Age) as TotalAge from Person
group by City, GenderId order by City

-- näitab mitu rida on selles tabelis
select count(*) from Person
select * from Person

-- näitab tulemust, mitu inimest on GenderId väärtusega 2 konkreetses linnas
-- veel arvutab vanuse kokku
select City, GenderId, sum(Age) as TotalAge, count(Id) as [Total Person(s)]
from Person
where GenderId = '2'
group by GenderId, City

insert into Person values
(10, 'Black Panter', 'b@b.com', 2, 34, 'New York')

-- näitab ära inimeste koondvanuse, kelle vanus on vähemal 29 a
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

-- arvutab kõikide palgad kokku
select sum(CAST(Salary AS int)) AS [Palgad Kokku]
from Employees

-- kõige väiksema palgasaaja palk
select min(CAST(Salary AS int))
from Employees

-- ühe kuu palgafond linnade lõikes
select Location, sum(cast(Salary as int)) as TotalSalary
from Employees
left join Department
on Employees.DepartmentId = Department.Id
group by Location

alter table Employees
add City nvarchar(30)

--sooline eripära palkade osas
select City, Gender, sum(cast(Salary as int)) as TotalSalary
from Employees
group by City, Gender

--sama nagu eelmine aga linnad on tähestikulises järjekorras
select City, Gender, sum(cast(Salary as int)) as TotalSalary
from Employees
group by City, Gender
order by City

-- loeb ära, mitu rida andmeid on tabelis,
-- tärni asemele võib panna muid veergude nimetusi
select count(*) from Employees
select count(Name) from Employees
select count(DepartmentId) from Employees

-- mitu töötajat on soo ja linna kaupa selles tabelis
select Gender, City, count(Id) as [Total Employee(s)]
from Employees
group by Gender, City

-- näitab kõik mehed linnade kaupa
select Gender, City, count(Id) as [Total Employee(s)]
from Employees
where Gender = 'Male'
group by Gender, City

-- näitab kõik naised linnade kaupa
select Gender, City, count(Id) as [Total Employee(s)]
from Employees
group by Gender, City
having Gender = 'Female'

-- kelle palk on vähemalt üle 4000
select Id, Name, Cast(Salary As Int)
from Employees
where Salary > 4000

-- kõigil kellel on palk üle 4000 ja arvuta bneed kokku ning näitab soo kaupa
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

-- kustutage ära City veerg Employees tabelist
alter table Employees
drop column City


-- inner join
-- kuvab neid, kellel on DepartmentName all olevas väärtus
select Name, Gender, Salary, DepartmentName
from Employees
inner join Department
on Employees.DepartmentId = Department.Id

-- left join
-- kuidas saada kõik andmed Employees tabelist kätte
select Name, Gender, Salary, DepartmentName
from Employees
left join Department -- vöib kasutda ka LEFT OUTER JOIN-i
on Employees.DepartmentId = Department.Id

-- right join
-- kuidas saada DeartmentName alla uus nimetus e antud juhul Other Department
select Name, Gender, Salary, DepartmentName
from Employees
right join Department
on Employees.DepartmentId = Department.Id

-- full outer join
-- kuidas saada kõikide tabelite väärtused ühte päringusse
select Name, Gender, Salary, DepartmentName
from Employees
full outer join Department
on Employees.DepartmentId = Department.Id

-- cross join
-- võtab kaks allpool olevat tabelit kokku ja korrutab need omavahel läbi
select Name, Gender, Salary, DepartmentName
from Employees
cross join Department

-- päringu sisu
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
--mõlema tabeli mitte-kattuvate väärtustega read kuvab välja
select Name, Gender, Salary, DepartmentName
from Employees
full join Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null or Department.Id is null

--saa´me muuta tabeli nimetust, alguses vana tabeli nimi ja uus soovitud
sp_rename 'Department', 'Department123'

sp_rename 'Department123', 'Department'

--teeme left join-i, aga Employees tabeli nimetus on lühendina: E
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
--kuvab ainult ManagerId all olevate isikute väärtuseid
select E.Name as Employee, M.Name as Manager
from Employees E
inner join Employees M
on E.ManagerId = M.Id

--cross join
--kõik saavad kõikide ülemused olla
select E.name as Employee, M.Name as Manager
from Employees E
cross join Employees M

select isnull('Asd', 'No manager') as Manager

--Null asemel kuvab No Manager
select coalesce(NULL, 'No Manager') as Manager

--neil kellel ei ole ülemust, siis paneb neile 'No Manager' teksti
select E.Name as Employee, isnull(M.Name, 'No Manager') as Manager
from Employees E
left join Employees M
on E.ManagerId = M.Id

--teeme päringu, kus kasutame case-i
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

--igast reast võtab esimesena täidetud lahtri ja kuvab ainult seda
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

--kasutame union all, näitab kõiki ridu
select Id, Name, Email from IndianCustomers
union all
select Id, Name, Email from UKCustomers

--korduvate väärtustega read pannakse ühte ja ei korrata
select Id, Name, Email from IndianCustomers
union
select Id, Name, Email from UKCustomers

-- kasuta union all ja sorteeri nime järgi
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

--niimodi saab sptahetud järjekorrast mööda minna, kui ise paned muutujad paika
spGetEmployeesByGenderAndDepartment @departmentId = 1, @Gender = 'Male'

--saab sp sisu vaadata result vaates
sp_helptext spGetEmployeesByGenderAndDepartment

--kuidas muuta sp-d ja võti peale panna, et keegi teine ei saaks muuta
alter proc spGetEmployeesByGenderAndDepartment
@Gender nvarchar(20),
@DepartmentId int
with encryption --paneb võtme peale
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

--annab tulemuse, kus loendab ära nõuetele vaastav read
--prindib ka tulemuse kirja teel
declare @TotalCount int
execute spGetEmployeeCountByGender 'Female', @TotalCount out
if(@TotalCount = 0)
	print '@TotalCount is null'
else
	print '@Total is not null'
print @TotalCount

--näitab ära, et mitu rida vastab nõuetele
declare @TotalCount int
execute spgetEmployeeCountByGender @EmployeeCount = @totalCount out, @gender = 'Male'
print @TotalCount

--sp sisu vaatamine
sp_help spgetEmployeeCountByGender
--tabeli info
sp_help Employees
--kui soovid sp teksti näha
sp_helptext spgetEmployeeCountByGender

--millest sõltub sp seesp
sp_depends spgetEmployeeCountByGender

--vaatame tabeli sõtuvust
sp_depends Employees

--
create proc spGetNameById
@Id int,
@Name nvarchar(20) output
as begin
	select @Id = Id, @Name = FirstName
	from Employees
end

--veateadet ei näita, aga tulemust ka ei ole
spGetNameById 1, 'Tom'

--töötav variant
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

-- tuleb veateade kuna kutsusime välja int-i, aga Tom on string
declare @EmployeeName nvarchar(50)
execute @EmployeeName = spGetnameById3 1
print 'Name of the employee = ' + @EmployeeName

-- sisseehitatud string funktsioonid
-- see konverteerib ASCII tähe väärtuse numbriks
select ASCII('a')

--Kuvab A-tähe
select char('A')

-- prindim kogu tähesiku välja
declare @Start int
set @Start = 97

while (@Start <= 122)
begin 
	select char (@start)
	set @Start = @Start + 1
end

-- eemaldame tühjad kohad sulgudes vasakult poolt
select ltrim('          Hello')

select * from Employees

-- tühikute eemaldamine veerust
select LTRIM(FirstName) as [First Name], MiddleName, LastName from Employees

--paremalt poolt eemaldab tühjad stringid
select RTRIM('Hello  --                 ')

-- 6 tund 02.04.2025

--keera kooloni sees olevad andmed vastupidiseks
--vastavalt upper ja lower-ga saan muuta märkide suurust
--reverse funktsioon pöörab kõik ümber
select reverse(upper(ltrim(FirstName))) as [First Name], MiddleName, lower(LastName) as LastName,
rtrim(ltrim(FirstName)) + ' ' + MiddleName + ' ' + LastName as FullName
from Employees

--näitab, et mitu tähte on sõnal ja loeb tühikud sisse
select FirstName, len(FirstName) as [Total Characters] from Employees

--eemaldame t[hikud ja ei loe sesse ???
select FirstName, len(trim(FirstName)) as [Total Characters] from Employees

--left, right ja substring
--vasakult poolt neli esimest tähte
select LEFT('ABCDEF', 4)

--paremalt poolt kolm tähte
select RIGHT('ABCDEF', 3)

--kuvab @-tähemärgi asetust
select CHARINDEX('@', 'sarda@aaa.com')

--esimene number peale komakohta näitab, et mitmendast alustab 
--ja siis mitu nr peale seda
select SUBSTRING('pam@bbb.com', 5, 4)

--@-märgist kuvab kom tähemärki. Viimase nr saab määrata pikkust
select substring('pam@bbb.com', CHARINDEX('@', 'pam@bbb.com') + 1,2)

--peale @-märki reguleerib tähemärkide pikkuse näitamist
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

--lisame *-märgi alates teatud kohast
select FirstName, LastName,
	SUBSTRING(Email, 1, 2) + REPLICATE('*', 5) + --peale teist tähemärki paneb viis tärni
	SUBSTRING(Email, CHARINDEX('@', Email), len(Email) - charindex('@', Email) + 1) as Email --kuni @-märgini on dünaamiline
	from Employees

--kolm korda näitab stringis plevat väärtust
select REPLICATE('asd', 3)

--kuidas sisestada tühikut kahe nime vahele
select FirstName + ' ' + LastName as FullName from Employees

select concat(FirstName, ' ', LastName) as FullName from Employees

--tühikute arv kahe nime vahel
select FirstName + space(20) + LastName as FullName from Employees


--PATINDEX
--sama, mis CHARINDEX, aga dünaamilisem ja saab kasutada wildcardi
select Email, PATINDEX('%@aaa.com', Email) as FirstOccurence
from Employees
where PATINDEX('%@aaa.com', Email) > 0 --leian kõik selle domeeni esindajad ja
--alates mitmendast märgist algab @

--- kõik .com-d asendatakse .net-ga
update Employees
SET Email = REPLACE(Email, '.com', '.net')
where Email LIKE '%.com'

select * from Employees

--soovin asendada peale esimest märki kolm tähte viie tärniga
--peate kasutama stuff-i
select FirstName, LastName, Email,
	stuff(Email, 2, 3, '*****') as [Stuffed Email]
from Employees

--------
--ajaühikute tabel
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

select CURRENT_TIMESTAMP, 'CURRENT TIMESTAMP' --aja päring
-- leida veelkolm aja pääringut
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


select day(getdate())	-- annab tänase päeva nr
select day('01/31/2025') -- annab stringis oleva kp ja järjestus peab olema õige

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

-- kuidas võtta veerust andmeid ja selle abil luua uued veerud
select Name, DateOfBirth, DATENAME(WEEKDAY, DateOfBirth) as [Day], --vaatab DoB veerust päeva ja kuvab päeva nimetuse sinna
	MONTH(dateOfBirth) as MonthNumber, --vt DoB veerust kp-d ja kuvab kuu nr
	DATENAME(Month, DateOfBirth) as [MonthName], --vt DoB veerust kp-d ja kuvab kuu sõnana
	Year(DateOfBirth) as [Year] --vt DoB veerust aasta nr
from EmployeesWithDates


-- tund 7 09.04.25

-- näitab 4 kuna USA nädal algab pühapäevast
select DATEPART(WEEKDAY, '2025-01-29 12:59:30.670')

-- näitab kuu numbrit
select DATEPART(month, '2025-01-29 12:59:30.670')

-- liidab stringis olevale kuupäevale 20 päeva
select DATEADD(day, 20, '2025-01-29 12:59:30.670')

-- lahutab stringis olevale kuupäevale 20 päeva
select DATEADD(day, +20, '2025-01-29 12:59:30.670')

--kuvab kahe stringi vahel olevat kuudevahelist aega
select DATEDIFF(month, '11/30/2024', '01/30/2024')

--kuvab kahe stringi vahel olevat astatevahelist aega
select DATEDIFF(year, '11/30/2020', '01/30/2372')

-- func
create function fnComputeAge(@DOB datetime)
returns nvarchar(50)
as begin
	declare @tempdate datetime, @years int, @months int, @days int
		select @tempdate = @DOB

		select @years = datediff(year, @tempdate, getdate()) - case when (month(@DOB) > month(getdate())) or (month(@DOB) = MONTH(getdate()) and day(@DOB) > day(getdate())) then 1 else 0 end
		select @tempdate = DATEADD(year, @years, @tempdate)
		select @months = datediff(MONTH, @tempdate, getdate()) - case when day(@DOB) > day(getdate()) then 1 else 0 end
		select @tempdate = DATEADD(Month, @months, @tempdate)
		select @days = datediff(day, @tempdate, getdate())

	declare @Age nvarchar(50)
		set @Age = cast(@years as nvarchar(4)) + ' Years ' + cast(@months as nvarchar(2)) + ' Months ' + CAST(@days as nvarchar(2)) + ' Days old'
	return @Age
end

-- saame vaadata kasutajate vanust
select Id, Name, DateOfBirth, dbo.fnComputeAge(dateofBirth) as Age 
from EmployeesWithDates

-- kui kasutame seda functsiooni, siis saame teada tänase päeva vahet stringis välja tooduga
select dbo.fnComputeAge('11/30/2010')

--nr peale DOB muutujat näitab, et mismoodi kuvab DOB-d
select Id, Name, DateOfBirth,
convert(nvarchar, DateOfBirth, 1) as ConvertedDOB
from EmployeesWithDates

select Id, Name, Name + ' - ' + cast(Id as nvarchar) as [Name-Id]
from EmployeesWithDates

-- tänane kp
select cast(getdate() as date)

-- tänane kp
select convert(date, getdate())

-- matemaatilised funktsioonid

-- abs on absoluutväärtus ja miinus võetakse ära
select ABS(-101.5)

-- ümardab suurema arvu poole
select CEILING(15.2)

-- tulemus on -15 ja suurendab positiivse täisarvu suunas
select CEILING(-15.2)

-- ümardab väiksema arvu poole
select FLOOR(15.2)

-- ümardab väiksema arvu poole e -16
select FLOOR(-15.2)

-- hakkab korrutama 2x2x2x2, esimene number on korrutatav
select POWER(2, 4)

-- antud juhul 9 ruudus
select SQUARE(9)

-- annab vastuse 9, ruutjuur
select sqrt(81)

-- annab suvalise nr vahemikus 0...1 (FLOAT) 
select rand()

-- korrutab sajaga iga suvalise nr
select floor(rand() * 100)

-- iga kord näitab 10 suvalist nr-t
declare @i int = 0

while @i < 11
begin
	set @i = @i + 1
	print floor(rand() * 100)
end

-- ümardab kaks kohta peale komat, tulemus 850.560
select round(850.556, 2)

-- ümardab allapoole, tulemus 850.550
select round(850.556,2,1)

-- ümardab ülespoole ja võtab ainult esimese nr peale koma 850.600
select round(850.556,1)

-- ümardab allapoole ja võtab ainult esimese nr peale koma 850.500
select round(850.556,1,1)

-- ümardab täisnr ülesse
select round(850.556,-2)

-- ümardab täisnr allapoole
select round(850.556,-1)

---
create function dbo.CalculateAge(@DOB date)
returns int
as begin
declare @Age int

set @Age = DATEDIFF(year, @DOB, GETDATE()) -
	case
		when (MONTH(@DOB) > MONTH(getdate())) or
			 (MONTH(@DOB) > MONTH(GETDATE()) and day(@DOB) > day(getdate()))

			 then 1
			 else 0
			 end
		return @Age
end

exec CalculateAge '08/14/2010'

--arvutab välja, kui vana on isik ja võtab arvesse kuud ja päevad
-- antud juhul näitab kõike, kes on üle 36 a vanad

select Id, Name, dbo.CalculateAge(DateOfBirth) as Age from EmployeesWithDates
where dbo.CalculateAge(DateOfBirth) > 36

--inline table valued functions
alter table EmployeesWithDates
add DepartmentId int

alter table EmployeesWithDates
add Gender nvarchar(10)

select * from EmployeesWithDates

update EmployeesWithDates 
SET DepartmentId = 1, Gender = 'Male'
where Id = 1;

update EmployeesWithDates 
SET DepartmentId = 2, Gender = 'Female'
where Id = 2;

update EmployeesWithDates 
SET DepartmentId = 1, Gender = 'Male'
where Id = 3;

update EmployeesWithDates 
SET DepartmentId = 3, Gender = 'Female'
where Id = 4;

insert into EmployeesWithDates
values(5, 'Todd', '1978-11-29 12:59:30.670', 1, 'Male')

-- scalare function annab mingis vahemikus olevaid andmeid, aga
-- inline table values ei kasuta begin ja ned funktsioone
-- scalar annab väärtused ja inline annab tabeli

create function fn_EmployeesByGender(@Gender nvarchar(10))
returns table
as
return (select Id, Name, DateOfBirth, DepartmentId, Gender
		from EmployeesWithDates
		where Gender = @Gender)

-- kõik female töötajad
select * from fn_EmployeesByGender('female')

select * from fn_EmployeesByGender('female')
where Name = 'Pam'

select * from Department

select Name, Gender, DepartmentName
from fn_EmployeesByGender('male') E
join Department D on D.Id = E.DepartmentId

-- inline funktsioon
create function fn_GetEmployees()
returns table as 
return (select Id, Name, cast(DateOfBirth as date)
		as DOB
		from EmployeesWithDates)

select * from fn_GetEmployees()

-- teha multi-state funktsioon
-- peab defineerima uue tabeli veerud koos muutujatega
-- Id int, Name nvarchar(20), DOB date
-- funktsiooni nimi on fn_MS_getEmployees()
create function fn_MS_GetEmployees()
returns @Table Table(Id int, name nvarchar(20), DOB date)
as begin
	insert into @Table
	select Id, Name, cast(DateOfBirth as date) from EmployeesWithDates
	return
end

select * from fn_MS_getEmployees()

update fn_GetEmployees() set Name = 'Sam1' where Id = 1 -- saab muuta andmeid
update fn_MS_getEmployees() set Name = 'Sam 1' where Id = 1 -- ei saa muuta andmeid

-- deterministic ja non-deterministic
select count(*) from EmployeesWithDates
select SQUARE(3) -- kõik tehtemärgid on deterministic funktsioonid,
-- sinna kuuluvad veel SUM, AVG, ja SQUARE

-- non-deterministic
select getdate()
select current_timestamp()
select rand() --see functsioon saab olla mõlemas kategoorias, kõik oleneb sellest,
-- kas sulgedes on 1 või ei ole midagi

-- loome funktsiooni
create function fn_GetNameById(@id int)
returns nvarchar(30)
as begin
	return (select name from EmployeesWithDates where Id = @id)
end

select dbo.fn_GetNameById(4)

---
create function fn_getEmployeenameById(@Id int)
returns nvarchar(20)
with encryprion
as begin
	return (select name from EmployeesWithDates where Id = @Id)
end

sp_helptext fn_getEmployeesNameById()

-- muudame ülevalpool olevat funktsiooni.
-- Kindlasti tabeli ette panna dbo.TabeliNimi

alter function dbo.fn_getEmployeenameById(@id int)
returns nvarchar(20)
with schemabinding
as begin
	return (select Name from dbo.EmployeesWithDates where Id = @Id)
end

-- ei saa kustutada tabeleid ilma funktsiooni kustutamata
drop table dbo.EmployeesWithDates

-- temporary tables
-- #-märgi ette panemisel saame aru, et tegemist on temp tabeliga
-- seda tabelit saab ainult selles pärings avada

--databases > System Databases > tempdb > Temporary Tables
create table #PersonDetails(Id int, Name nvarchar(20))
insert into #PersonDetails values(1, 'Mike')
insert into #PersonDetails values(2, 'John')
insert into #PersonDetails values(3, 'Todd')

select * from #PersonDetails

select Name from sysobjects
where Name like '#PersonDetails%'

--- kustuta temp table
drop table #PersonDetails

create proc spCreateLocalTempTable
as begin
create table #PersonDetails(Id int, Name nvarchar(20))
insert into #PersonDetails values(1, 'Mike')
insert into #PersonDetails values(2, 'John')
insert into #PersonDetails values(3, 'Todd')

select * from #PersonDetails
end

exec spCreateLocalTempTable

-- globaalse temp tabeli  tegemine
create table ##PersonDetails(Id int, Name nvarchar(20))

-- Erinevused lokaalse ja globaalse ajutise tabeli osas:
-- 1. Lokaalsed ajutised tabelid on ühe # märgiga, aga globaalsel on kaks tükki.
-- 2. SQL server lisab suvalisi numbreid lokaalse ajutise tabeli nimesse, aga globaalse puhul seda ei ole.
-- 3. Lokaalsed on nähtavad ainult selles sessioonis, mis on selle loodud, aga globaalsed on nähtavad kõikides sessioonides.
-- 4. Lokaalsed ajutised tabelid on automaatselt kustutatud, kui selle loodud sessioon on kinni pandud, aga gloabaalsed ajutised tabelid lõpetatakse alles peale viimase ühenduse lõpetamist.


----- 8 tund 16.04.2025

-- Index
create table EmployeeWithSalary
(
Id int primary key,
Name nvarchar(35),
Salary int,
Gender nvarchar(10)
)

insert into EmployeeWithSalary (Id, Name, Salary, Gender)
values (1, 'Sam', 2500, 'Male'),
(2, 'Pam', 6500, 'Female'),
(3, 'John', 4500, 'Male'),
(4, 'Sara', 5500, 'Female'),
(5, 'Todd', 3100, 'Male')

-- Indekseid kasutatakse p'ringute tegemisel, mis annavad meile kiiresti andmeid.
-- Indekseid luuakse tabelites ja vaadetes. Indeks tabelis või vaates on samasugune raamatu indeksile.
-- Kui raamatus ei oleks indeksit ja tahaksin üles leida konkreetse peatüki, siis sa peaksid kogu raamatu läbi vaatama.
-- Kui indeks on olemas, siis vaatad peatüki leheküljenumbrit ja liigud vastavale leheküljele.
-- Raamatuindeks aitab oluliselt kiiremini üles leida vajaliku peatüki.
-- Sama teevad ka tabeli ja vaate indeksid serveris.
-- Õigete indeksite eksisteerimine lühendab oluliselt päringu tulemust.
-- Kui indeksit ei ole, siis päring teeb kogu tabeli ülevaatuse ja seda kutsutakse Table Scan-iks ja see on halb jõudlusele.

select * from EmployeeWithSalary
where Salary > 5000 and Salary < 7000

-- loome indeksi mis asetab palga kahanevasse järjestusse
create index IX_Employee_Salary
on EmployeeWithSalary (Salary asc)

select * from EmployeeWithSalary

-- indeksi kutsumine IX_Employee_Salary
select * from EmployeeWithSalary with (index(IX_Employee_Salary))
select Name, Salary from EmployeeWithSalary with (index = IX_Employee_Salary)

-- saame teada, et mis on selle tabeli primaarvõti ja index
exec sys.sp_helpindex @objname = 'EmployeeWithSalary'

--saame vaadata tabelit koos selle sisuga alates väga detailsest infost
select TableName = t.name,
IndexName = ind.name,
IndexId = ind.index_id,
ColumnId = ic.index_column_id,
ColumnName = col.name,
ind.*,
ic.*,
col.*
from
	sys.indexes ind
inner join
	sys.index_columns ic on ind.object_id = ic.object_id and ind.index_id = ic.index_id
inner join
	sys.columns col on ic.object_id = col.object_id and ic.column_id = col.column_id
inner join
	sys.tables t on ind.object_id = t.object_id
where
	ind.is_primary_key = 0
	and ind.is_unique = 0
	and ind.is_unique_constraint = 0
	and t.is_ms_shipped = 0
order by
	t.name, ind.name, ind.index_id, ic.is_included_column, ic.key_ordinal;

-- indeksi kustutamine
drop index EmployeeWithSalary.IX_Employee_Salary

-- Indeksi tüübid:
-- 1. Klastrites olevad
-- 2. Mitte-klastris olevad
-- 3. Unikaalsed
-- 4. Filtreeritud
-- 5. XML
-- 6. Täistekst
-- 7. Ruumiline
-- 8. Veerusäilitav
-- 9. Veergude indeksid
-- 10.Väljaarvatud veergudega indeksid

-- Klastris olev indeks määrab ära tabelis oleva füüsilise järjestuse ja selle tulemusel saab tabelis olla ainult üks klastris olev indeks.

create table EmployeeCity
(
Id int primary key,
Name nvarchar(50),
Salary int,
Gender nvarchar(10),
City nvarchar(50)
)

exec sp_helpindex EmployeeCity
-- andmete õige järjestuse loovad klastris olevad indeksid ja kasutab selleks nr-t
-- põhjuseks on Id kasutamisel tuleneb selle primaarvõtmest
insert into EmployeeCity values(3, 'John', 4500, 'Male', 'New York')
insert into EmployeeCity values(1, 'Sam', 2500, 'Male', 'London')
insert into EmployeeCity values(4, 'Sara', 5500, 'Female', 'Tokyo')
insert into EmployeeCity values(5, 'Todd', 3100, 'Male', 'Toronto')
insert into EmployeeCity values(2, 'Pam', 6500, 'Male', 'Sydney')

-- klastrite olevad indeksid dikteerivad säilitatud andmete järjestuse tabelis ja seda saab klastrite puhul olla ainult üks

select * from EmployeeCity

create clustered index IX_EmployeeCity_Name
on EmployeeCity(Name)

-- annab veateate, et tabelis saab olla ainult üks klaastris olev indeks
-- kui soovid, uut indeksit luua, siis kustuta olemasolev

-- saame luua ainult ühe klastris oleva indeksi tabeli peale
-- klastris olev indeks on analoogne telefoni suunakoodile

-- loome composite indeksi
-- enne tuleb kõik teised klastris olevad indeksid ära kustutada

create clustered index IX_Employee_Gender_Salary
on EmployeeCity(Gender desc, Salary asc)

-- kui teed select päringu sellele tabelile, siis peaksid nägema andmeid,
-- mis on järjestatud selliselt:
-- esimeseks võetakse aluseks Gender veerg kahanevas järjestuses ja siis Salary veerg tõusvas järjestuses

select * from EmployeeCity

-- mitte klastris olev indeks
create nonclustered index IX_EmployeCity_Name
on EmployeeCity(Name)

--teeme päringu tabelile
select * from EmployeeCity

-- erinevused kahe indeksi vahel:
-- 1. Ainult üks klastris olev indeks saab olla tabeli peale, mitte-klastris olevaid indekseid saab olla mitu
-- 2. Klastris olevad indeksid on kiiremad kuna indeks peab tagasi viitama tabelile.
--    Juhul, kui selekteeritud veerg ei ole olemas indeksis
-- 3. Klastris olev indeks määratleb ära tabeli  ridade slvestusjärjestuse ja ei nõua kettal lisa ruumi.
--    Samas mitte klastris olevad indeksid on salvestatud tabelist eraldi ja nõuab lisa ruumi

create table EmployeeFirstName
(
Id int primary key,
FirstName nvarchar(50),
LastName nvarchar(50),
Salary int,
Gender nvarchar(10),
City nvarchar(50)
)

exec sp_helpindex EmployeeFirstName

insert into EmployeeFirstName values(1, 'Mike', 'Sandoz', 4500, 'Male', 'New York')
insert into EmployeeFirstName values(1, 'John', 'Menco', 2500, 'Male', 'London')

drop index EmployeeFirstName.PK__Employee__3214EC0705196AF1
-- kui käivitad ülevalpool oleva koodi, siis tuleb veateade
-- et SQL server kusutab UNIQUE indeksit jõustamaks väärtuste unikaalsust ja primaarvõti
-- koodiga Unikaalseid Indekseid ei saa kustutada, aga käsitsi saab

truncate table EmployeeFirstName

-- sisestame uuesti
insert into EmployeeFirstName values(1, 'Mike', 'Sandoz', 4500, 'Male', 'New York')
insert into EmployeeFirstName values(2, 'John', 'Menco', 2500, 'Male', 'London')

-- unikaalset indeksit kasutatakse kindlustamaks väärtuste unikaalsust (sh primaarvõti)
create unique nonclustered index UIX_Employee_FirstName_LastName
on EmployeeFirstName(FirstName, LastName)

-- lisame uue unikaalse piirangu
alter table EmployeeFirstName
add constraint UQ_EmployeeFirstName_City
unique nonclustered(City)

insert into EmployeeFirstName values(3, 'John1', 'Menco1', 3000, 'Male', 'London')
-- ei luba tabelisse väärtusega uut Londonit

-- saab vaadata indeksite nimekirja
exec sp_helpconstraint EmployeeFirstName

-- 1. Vaikimisi primaarvõti loob unikaalse klastris oleva indeksi, samas unikaalne piirang loob unikaalse mitte-klastris oleva indeksi
-- 2. Unikaalset indeksit või piirangut ei saa luua olemasolevasse tabelisse, kui tabel jub sisestab väärtusi võtmeveerus
-- 3. Vaikimisi korduvaid väärtuseid ei ole veerus lubatud, kui peaks olema unikaalne indeks või piirang.
--	  Nt, kui lükatakse tagasi. Kui soovid ainult 5 rea tagasi lükkamist ja ülejäänud 5 rea sisestamist, siis selleks kasutataks IGNORE_DUP_KEY

create unique index IX_EmployeeFirstName
on EmployeeFirstName(City)
with ignore_dup_key

insert into EmployeeFirstName values (3, 'John', 'Menco', 3512, 'Male', 'London')
insert into EmployeeFirstName values (4, 'John', 'Menco', 3111, 'Male', 'London1')
insert into EmployeeFirstName values (4, 'John', 'Menco', 3222, 'Male', 'London1')

select * from EmployeeFirstName
-- enne ignore käsku oleks kõik kolm rida tagasi lükatud, aga nüüd läks keskmine rida läbi kuna linna nimi oli unikaalne

-- View

-- view on salvestatud SQL-i päring. Saab käsitleda ka virtuaalse tabeline
select FirstName, Salary, Gender, DepartmentName
from Employees join Department
on Employees.DepartmentId = Department.Id

-- loome view
create view vEmployeesByDepartment
as
select FirstName, Salary, Gender, DepartmentName
from Employees join Department
on Employees.DepartmentId = Department.Id

-- view päringu esile kutsumine
select * from vEmployeesByDepartment

-- view ei salvesta andmeid vaikimisi
-- seda tasub võtta, kui salvestatud virtuaalse tabelina

-- milleks vaja view-d:
-- saab kasutada andmebaasi skeemi keerukuse lihtsustamiseks,
-- mitte IT-inimesele
-- piiratud ligipääs andmetele, ei näe kõik veerge

-- teeme view, kus näeb ainult IT-töötajaid
-- view nimi on vITEmployeesInDepartment
-- kasutabe tabeleid Employees ja Department
create view vITEmployeesInDepartment
as
select FirstName, Salary, Gender, DepartmentName
from Employees join Department
on Employees.DepartmentId = Department.Id
where Department.DepartmentName = 'IT'

-- ülevalpool olevat päringut saab liigitada reataseme alla
-- tahan ainult näidata IT osakonna töötajaid

select * from vITEmployeesInDepartment

-- veeru taseme turvalisus
-- peale selecti määratled veergude näitamise ära
alter view vEmployeesInDepartmentSalaryNoShow
as
select FirstName, Gender, DepartmentName
from Employees join Department
on Employees.DepartmentId = Department.Id

-- Salary veergu ei näita
select * from vEmployeesInDepartmentSalaryNoShow

-- Saab kasutada esitlemaks koondandmeid ja üksikasjalike andmeid
-- view, mis tagastab summeeritud andmeid
create view vEmployeesCountByDepartment
as
select DepartmentName, count(Employees.Id) as TotalEmployees
from Employees
join Department
on Employees.DepartmentId = Department.Id
group by DepartmentName

select * from vEmployeesCountByDepartment

-- kui soovid vaadata view sisu
sp_helptext vEmployeesCountByDepartment
-- muutmine
alter view vEmployeesCountByDepartment
-- kustutamine
drop view vEmployeesCountByDepartment

-- view uuendused
update vEmployeesDataExceptSalary
set [FirstName] = 'Tom' where Id = 2

create view vEmployeesDataExceptSalary
as
select Id, FirstName, Gender, DepartmentIdfrom Employees

-- kustutame ja sisestame andmeid
delete from vEmployeesDataExceptSalary where Id = 2
insert into vEmployeesDataExceptSalary (Id, Gender, DepartmentId, FirstName)
values (2, 'Female', 2, 'Pam');

-- tund 9
-- MS SQL-s on indekseeritud view nime all ja
-- Oracle-s kutsutakse materjaliseeritud view-ks

create table Product
(
Id int primary key,
Name nvarchar(20),
UnitPrice int
);

insert into Product values(1, 'Books', 20)
insert into Product values(2, 'Pens', 14)
insert into Product values(3, 'Pencils', 11)
insert into Product values(4, 'Clips', 10)

create table ProductSales
(
Id int,
QuantitySold int)

insert into ProductSales values(1,10)
insert into ProductSales values(3,23)
insert into ProductSales values(4,21)
insert into ProductSales values(2,12)
insert into ProductSales values(1,13)
insert into ProductSales values(3,12)
insert into ProductSales values(4,13)
insert into ProductSales values(1,11)
insert into ProductSales values(2,12)
insert into ProductSales values(1,14)

-- loome view, mis annab meile veerud TotalSales ja TotalTransaction
create view vTotalSalesProduct
with schemabinding
as
select Name,
sum(isnull((QuantitySold * UnitPrice), 0)) as TotalSales,
COUNT_BIG(*) as TotalTransactions
from dbo.ProductSales
join dbo.Product
on dbo.Product.Id = dbo.ProductSales.Id
group by Name

--- kui soovid luua indeksi view sisse, siis peab järgima teatud reegleid
-- 1. view tuleb luua koos schemabinding-ga
-- 2. kui lisafunktsioon select list viitab väljendile ja selle tulemuseks võib olla NULL, siis asendusväärtus peaks olema täpsustatud.
-- Antud juhul kasutasime ISNULL funktsiooni asendamaks NULL väärtust
-- 3. kui GroupBy on täpsustatud, siis view select list peab sisaldama COUNT_BIG(*) väljendit
-- 4. Baastabelis peaksid view-d olema viidatud kahesosalise nimega e antud juul dbo.Product ja dbo.ProductSales

select * from vTotalSalesProduct

create unique clustered index UIX_vTotalSalesByProduct_Name
on vTotalSalesProduct(Name)
-- panev selle view tähestikulisse järjestusse

-- view piirangud
create view vEmployeeDeatails
@Gender nvarchar(20)
as
select Id, FirstName, Gender, DepartmentId
from Employees
where Gender = @Gender
-- vaatesse ei saa kaasa panna parameetreid e antud juhul @Gender

create function fnEmployeeDetails(@Gender nvarchar(20))
returns table
as return
(select Id, FirstName, Gender, DepartmentId
from Employees where Gender = @Gender)

-- funktsiooni esile kutsumine koos parameetriga
select * from fnEmployeeDetails('male')

-- order by kasutamine
-- tuleb teha view mille nimeks on vEmployeeDetailsSorted
-- order by-s tuleb kasutada Id-d

create view vEmploteeDetailsSorted
as
select * from Employees
order by Id
-- view puhul ei saa kasutada order by!

-- temp table kasutamine
create table ##TestTempTable (Id int, FirstName nvarchar(20), Gender nvarchar(10))

insert into ##testTempTable values(101, 'Martin', 'Male')
insert into ##TestTempTable values(102, 'Joe', 'Female')
insert into ##TestTempTable values(103, 'Pam', 'Female')
insert into ##TestTempTable values(104, 'James', 'Male')

create view vOnTemptable
as
select Id, FirstName, Gender
from ##TestTempTable

-- temp tabel-s ei saa kasutada viewd!

-- Triggerid

-- kokku on kolme tüüpi: DML, DDL ja LOGON
-- trigger on stored procedure eriliik, mis automaatselt käivitub, kui mingi tegevus peaks andmebaasis aset leidma

-- DML - data manipulation language
-- DML-i põhilised käsklused: insert, update ja delete

-- DML triggereid saab klasifitseerida kahte tüüpiÖ
-- 1. After trigger (kutsutakse ka FOR triggeriks)
-- 2. Instead of trigger (selmet trigger e selle asemel trigger)

-- after trigger käivitub peale sündmust, kui kuskil on tehtud insert, update ja delete

create table EmployeeAudit
(
Id int identity(1, 1) primary key,
Auditdata nvarchar(1000)
)

-- peale iga töötaja sisestamist tahame teada saada töötaja Id-d,
-- päeva ning aega (millal sisestati)
-- kõik andmed tulevad EmployeeAudit tabelisse

create trigger trEmployeeForInsert
on Employees
for insert
as begin
declare @Id int
select @Id = Id from inserted
insert into EmployeeAudit
values ('New employee with Id = ' + cast(@Id as nvarchar(5)) + ' is added at ' + CAST(GETDATE() as nvarchar(20)))
end

select * from Employees
insert into Employees values
(11, 'Bob', 'Blob', 'Bomb', 'Male', 3000, 1, 3, 'bob@bomb.com')

select * from EmployeeAudit

-- delete trigger
create trigger trEmployeeForDelete
on Employees
for delete
as begin
	declare @Id int
	select @Id = Id from deleted

	insert into EmployeeAudit
	values('An existing employee with Id = ' + cast(@Id as nvarchar(5)) + ' is deketed at ' + cast(GETDATE() as nvarchar(20)))
end

delete from Employees where Id = 11

select * from EmployeeAudit;

-- update trigger
create trigger trEmployeeForUpdate
on Employees
for update
as begin
	-- muutujate deklareerimine
	declare @Id int
	declare @OldGender nvarchar(20), @newGender nvarchar(20)
	declare @OldSalary int, @NewSalary int
	declare @OldDepartmentId int, @NewDepartmentId int
	declare @OldManagerId int, @NewManagerId int
	declare @OldFirstName nvarchar(20), @NewFirstName nvarchar(20)
	declare @OldMiddleName nvarchar(20), @NewMiddleName nvarchar(20)
	declare @OldLastName nvarchar(20), @NewLastName nvarchar(20)
	declare @OldEmail nvarchar(50), @NewEmail nvarchar(50)

	--muutuja kuhu läheb lõpptekst
	declare @AuditString nvarchar(1000)

	-- laeb kõik uuendatud andmed temp tabeli alla
	select * into #TempTable
	from inserted

	-- kõik läbi kõik andmed temp table-s
	while(exists(select Id from #TempTable))
	begin 
		set @AuditString = ''
		--selekteerib esimese rea andmed temp tabele-st
		select top 1 @Id = Id, @Newgender = Gender,
		@NewSalary = Salary, @NewDepartmentId = DepartmentId,
		@NewManagerId = ManagerId, @NewFirstname = FirstName,
		@NewMiddleName = MiddleName, @NewLastName = LastName,
		@NewEmail = Email
		from #TempTable
		-- võtab vanad andmed kustutratud tabelist
		select @OldGender = Gender,
		@OldSalary = Salary, @OldDepartmentId = DepartmentId,
		@OldManagerId = ManagerId, @OldFirstName = FirstName,
		@OldMiddleName = MiddleName, @OldLastName = LastName,
		@OldEmail = Email
		from deleted where Id = @Id

		-- loob audit stringi dünaamiliselt
		set AuditString = 'Employee with Id = ' + cast(@Id as nvarchar(4)) + ' changed '
		if(@OldGender <> @NewGender)
			set @AuditString = @AuditString + ' Gender from ' + @OldGender + ' to ' +
			@NewGender

		if(@OldSalary <> @NewSalary)
			set @AuditString = @AuditString + ' Salary from ' + cast(@OldSalary as nvarchar(20))
			+ ' to ' + cast(@NewSalary as nvarchar(10))

		if(@OldDepartmentId <> @NewDepartmentId)
			set @AuditString = @AuditString + ' DepartmentId from ' + cast(@OldDepartmentId as nvarchar(20))
			+ ' to ' + cast(@NewDepartmentId as nvarchar(10))

		if(@OldManagerId <> @NewManagerId)
			set @AuditString = @AuditString + ' ManagerId from ' + cast(@OldManagerId as nvarchar(20))
			+ ' to ' + cast(@NewManagerId as nvarchar(10))

		if(@OldFirstName <> @NewFirstName)
			set @AuditString = @AuditString + ' FirstName from ' + @OldFirstName + ' to ' +
			@NewFirstName

		if(@OldMiddleName <> @NewMiddleName)
			set @AuditString = @AuditString + ' MiddleName from ' + @OldMiddleName + ' to ' +
			@NewMiddleName

		if(@OldLastName <> @NewLastName)
			set @AuditString = @AuditString + ' LastName from ' + @OldLastName + ' to ' +
			@NewLastName

		if(@OldEmail <> @NewEmail)
			set @AuditString = @AuditString + ' Email from ' + @OldEmail + ' to ' +
			@NewEmail

		insert into dbo.EmployeeAudit values (@AuditString)
		-- kustutab temp table-st rea, et saaksime liikuda uue rea juurde
		delete from #TempTable where Id = @Id
	end
end

update Employees set FirstName = 'test123', Salary = 4000, MiddleName = 'test50000' where Id = 10
select * from Employees
select * from EmployeeAudit

-- instead of trigger
create table Employee
(
Id int primary key,
Name varchar(30),
Gender nvarchar(10),
DepartmentId int
)

insert into Employee values(1, 'John', 'Male', 3)
insert into Employee values(2, 'Mike', 'Male', 2)
insert into Employee values(3, 'Pam', 'Female', 1)
insert into Employee values(4, 'Todd', 'Male', 4)
insert into Employee values(5, 'Sara', 'Female', 1)
insert into Employee values(6, 'Ben', 'Male', 3)

select * from Employee

create view vEmployeeDetails
as
select Employee.Id, Name, Gender, DepartmentName
from Employee
join Department
on Employee.DepartmentId = Department.Id

select * from vEmployeeDetails

insert into vEmployeeDetails values(7, 'Valarie', 'Female', 'IT')
-- tuleb veateade
-- nüüd vaatame kuidas saab instead of triggeriga seda probleemi lahendada

create trigger tr_vEmployeeDetails_InsteadOfInsert
on vEmployeeDetails
instead of insert
as begin
	declare @DeptId int

	select @DeptId = dbo.Department.Id
	from Department
	join inserted
	on inserted.DepartmentName = Department.DepartmentName

	if(@DeptId is null)
		begin
		raiserror('Invalid department name. Statement Terminated', 16, 1)
		return
	end

	insert into dbo.Employee(Id, Name, Gender, DepartmentId)
	select Id, Name, Gender, @deptId
	from inserted
end
--- raiseerror funktsioon
-- selle eesmärk on tuua välja veateade, kui DepartmentName veerus ei ole väärtust
-- ja ei klapi uue sisestatud väärtusega.
-- Esimene on parameeter on veateate sisu, teine on veataseme nr
-- (nr 16 tähendab üldiseid vigu),
-- kolmas on olek