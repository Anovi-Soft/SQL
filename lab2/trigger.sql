-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------
use "Andrej.Novikov"
-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------
if object_id ('update_stat', 'tr') is not null
   drop trigger update_stat;
-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------
create trigger update_stat on Main
after insert
as 
begin
	begin
		update cars
		set cars.stat=
		case i.direction
			when 'into' then 'other'
			when 'from' then 'other_city'
		end
		from Main as m
		inner join inserted as i
		on m.car=i.car and m.post=i.post
		where m.direction='into' and cars.id=m.car and cars.stat is null and m.id!=i.id
	end
	
	begin
		update cars
		set cars.stat=
		case i.direction
			when 'into' then 'other'
			when 'from' then 'transit'
		end
		from inserted as i 
		inner join Main as m
		on m.car=i.car and m.post!=i.post
		where m.direction='into' and cars.id=m.car and cars.stat is null and m.id!=i.id
	end

	begin
		update cars
		set cars.stat=
		case i.direction
			when 'into' then 'local'
			when 'from' then 'other'
		end
		from inserted as i 
		inner join Main as m
		on m.car=i.car and m.post=i.post
		where m.direction='from' and cars.id=m.car and cars.stat is null and m.id!=i.id
	end

	begin
		update cars
		set cars.stat=
		case i.direction
			when 'into' then 'other'
			when 'from' then 'other'
		end
		from inserted as i 
		inner join Main as m
		on m.car=i.car and m.post!=i.post
		where m.direction='from' and cars.id=m.car and cars.stat is null and m.id!=i.id
	end
end
-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------