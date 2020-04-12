create database torneoTusi

use torneoTusi

#drop database torneoTusi

create table partido(id_partido int auto_increment,
					id_equipo_local int not null,
					id_equipo_visitante int not null,
					fecha dateTime,
					constraint pk_partido primary key (id_partido),
					constraint fk_equipo_local foreign key (id_equipo_local) references equipo (id_equipo),
					constraint fk_equipo_visitante foreign  key (id_equipo_visitante) references equipo (id_equipo),
					constraint check (id_equipo_local <> id_equipo_visitante ));
					
create table equipo(id_equipo int auto_increment,
					nombre_equipo varchar(50) not null,
					constraint pk_id_equipo primary key (id_equipo));
					
create table jugadores_x_equipo_x_partido(id_jugador int not null,
										id_partido int not null,
										puntos int,
										rebotes int,
										asistencias int,
										minutos int,
										faltas int,
										constraint pk_jugadores_x_equipo_x_partido primary key (id_jugador,id_partido),
										constraint fk_partido foreign key (id_partido) references partido (id_partido),
										constraint fk_jugador foreign key (id_jugador) references jugador (id_jugador));
									
#drop table jugadores_x_equipo_x_partido;

create table jugador(id_jugador int auto_increment not null,
					id_equipo int not null,
					nombre varchar(50),
					apellido varchar(50),
					constraint pk_id_jugador primary key (id_jugador), 
					constraint fk_id_equipo foreign key (id_equipo) references equipo (id_equipo));
								

create procedure sp_insertEquipo(in nombre_equipo varchar(50),out lastId int)
begin
	insert into equipo (nombre_equipo) values (nombre_equipo);
	set lastId = last_insert_id();

end;

call sp_insertEquipo('Boca', @lastId);
select @lastId;


#EJERCICIO 4 ----------------------------------------------------------------------------------------
# 4) Generar un Stored Procedure que permita dar de alta un equipo y sus jugadores.
#Devolver en un parámetro output el id del equipo.
create temporary table jugador_temp(nombre varchar(50), apellido varchar(50))

create procedure sp_insertTeamWithPlayer(pTeamName varchar(50),out vId_equipo int)
begin
	declare vId_equipo int;
	insert into equipo(nombre_equipo ) values (pTeamName);
	set vId_equipo = last_insert_id();
	#bulk insert
	insert into jugador(id_equipo , nombre ,apellido )
	select vId_equipo, nombre, apellido from jugador_temp;
	truncate jugador_temp;
end

insert into jugador_temp values ('Pepe','Garcia'),('Jonhie','Walker'),('Walter','White'),('Jesse','Pinkman');
select * from jugador_temp;
call sp_insertTeamWithPlayer('River Plate',@vId_equipo);

insert into jugador_temp values ('Tito','Gomez'),('Robert','Lee'),('Stonewall','Jackson'),('Ewell','Hood');
select * from jugador_temp;
call sp_insertTeamWithPlayer('Boca Juniors',@vId_equipo);

select * from equipo e
inner join jugador j;
select * from jugador;

