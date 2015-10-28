use "Andrej.Novikov"

IF OBJECT_ID('measures','U') is not null
	drop table measures; 
IF OBJECT_ID('unitMeasure','U') is not null
	drop table unitMeasure; 
IF OBJECT_ID('stations','U') is not null
	drop table stations; 



create table unitMeasure(
	ID int not null IDENTITY(1,1),
	unit char(50) not null,
	name char(50) not null,
	constraint ChkIdDimension primary key (ID)
);
create table stations(
	ID int not null IDENTITY(1,1),
	name char(50) not null,
	address char(50) not null,
	email char(50),
	telefone char(50),
	constraint СhkIdStations primary key (ID),
	constraint ChkEmail check (email like '%_@_%_.__%')
);
create table measures(
	ID int not null IDENTITY(1,1),
	idStation int not null,
	idUnit int not null,
	dateRecord date not null,
	valueMeasure float not null,
	constraint СhkidMeasures primary key (ID),
	constraint ChkExistidStation foreign key(idStation) references dbo.stations(ID),
	constraint ChkExistidUnit foreign key(idUnit) references dbo.unitMeasure(ID),
);



insert into dbo.stations values
	('Свердловчанка', 'г.Екатеринбург', 'info@66.ru', '89688449922'),
	('Москалька', 'г.Москва', 'info@777.ru', '89688559922'),
	('НижТагилка', 'г.Нижний Тагил', 'info@nt66.ru', '5555555555')
insert into dbo.unitMeasure values
	('м/с', 'скорость ветра'),
	('°C', 'температура'),
	('мм', 'кол. осадков')
insert into dbo.measures values
	(1, 1, '18-11-2014', 5.6),
	(1, 2, '10-12-2014', 25),
	(2, 1, '10-12-2014', 3.2),
	(2, 2, '18-11-2014', 24),
	(2, 2, '18-11-2014', 30),
	(2, 2, '18-11-2014', 10),
	(2, 1, '10-12-2014', 20),
	(2, 1, '10-12-2014', 40),
	(2, 2, '18-11-2014', 10),
	(1, 1, '27-05-2014', 20),
	(1, 1, '27-05-2014', 40)

	

select * from dbo.unitMeasure
select * from dbo.stations
select * from dbo.measures


select 
CONVERT(varchar(11), dateRecord, 106) as 'Дата',
(select name from stations where ID=idStation) as 'Станция',
(select name from unitMeasure where ID=idUnit) as 'Тип измерения',
FORMAT( avg(valueMeasure), '#####.##') as 'Среднее значение',
(select unit from unitMeasure where ID=idUnit) as 'Единицы измерения' from measures
group by dateRecord, idStation, idUnit
order by dateRecord, idStation;
