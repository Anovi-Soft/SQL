-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------
use "Andrej.Novikov"
-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------
IF OBJECT_ID('Main','U') is not null
	drop table Main; 
IF OBJECT_ID('Cars','U') is not null
	drop table Cars; 
IF OBJECT_ID('Regions','U') is not null
	drop table Regions; 
IF OBJECT_ID('Punish','U') is not null
	drop table Punish; 
-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------
create table Main(
	id int identity(1,1),
	post int not null,
	car int not null,
	clock int not null,
	direction char(20) null,
constraint PkMain primary key primary clustered (id asc)
)
-- -----------------------------------------------------------------------------
create table Cars(
	id int identity(1,1),
	model char(20) not null,
	color char(20) not null,
	num char(9) not null unique nonclustered,
	region int not null,
	surname char(20) not null,
	stat char(20) null,
constraint PkCars primary key primary clustered (id asc)	
)
-- -----------------------------------------------------------------------------
create table Regions(
	name char(20) not null,
	num int not null,
constraint PkRegions primary key clustered (id asc)
)
-- -----------------------------------------------------------------------------
create table Punish(
	id int identity(1,1),
	num char(9) not null,
	name char(max) not null,
	money int not null,
	payed int not null,
constraint PkPunish primary key clustered (id asc)
)
-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------
alter table Main with check add constraint FkMainCars foreign key (car)
references Cars(id)
-- -----------------------------------------------------------------------------
alter table Cars with check add constraint FkCarsRegions foreign key(region)
references Regions(num)
-- -----------------------------------------------------------------------------
alter table Cars add constraint CkCarsRegion check (region<100 or (region<100 and (region/100=1 or region/100=2 or region/100=7)))
alter table Cars add constraint CkCarsNUm check (num like '[ВУКАНХЕРОСМТ]___[ВУКЕНХАРОСМТ][ВУКЕНХАРОСМТ]%')
-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------
insert into Regions values
('Екатеринбург',96),
('Екатеринбург',66),
('Москва',77)
-- -----------------------------------------------------------------------------
insert into Cars values
('model1','blue','А123ВВ196',96,'surname1',NULL),
('model2','red','А124ВВ777',77,'surname2',NULL),
('model3','red','А124ВВ196',96,'surname3',NULL),
('model4','red','А777АА777',77,'surname4',NULL),
('model5','red','А001АА777',77,'surname5',NULL)
-- -----------------------------------------------------------------------------
insert into Main values
(1,1,'12:12:13','from'),
(1,1,'12:12:14','into'),
(1,2,'12:12:15','into'),
(1,2,'12:12:16','from'),
(1,3,'12:12:17','into'),
(2,3,'12:12:18','from'),
(2,4,'12:12:19','from'),
(3,4,'12:12:20','into'),
(2,5,'12:12:21','into'),
(2,5,'12:12:22','into')
-- -----------------------------------------------------------------------------
insert into Punish values
(1, 'punish1', 123, 0),
(2, 'punish2', 312, 1),
(1, 'punish3', 312, 1)
-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------
select * from Regions;
select * from Cars;
select * from Main;
select * from Punish;
-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------
select 
	(select count(*) from Cars where[stat]='transit') as 'transit',
	(select count(*) from Cars where[stat]='other_city') as 'other_city',
	(select count(*) from Cars where[stat]='local') as 'other_city',
	(select count(*) from Cars where[stat]='other') as 'other_city'
-- -----------------------------------------------------------------------------
select color, count(color) as 'Count' from Cars group by color;
-- -----------------------------------------------------------------------------
select model, count(model) as 'Count' from Cars group by model;
-- -----------------------------------------------------------------------------
select
	(select top(1) name from Regions where num%100=region%100) as 'Region',
	count(region%100) as 'Count'
from Cars group by region % 100;
-- -----------------------------------------------------------------------------
select * 
from Cars as C
join regions as R
on C.region=R.num
order by region
-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------