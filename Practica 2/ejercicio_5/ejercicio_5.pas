{A partir de un siniestro ocurrido se perdieron las actas de nacimiento y fallecimientos de
toda la provincia de buenos aires de los últimos diez años. En pos de recuperar dicha
información, se deberá procesar 2 archivos por cada una de las 50 delegaciones distribuidas
en la provincia, un archivo de nacimientos y otro de fallecimientos y crear el archivo maestro
reuniendo dicha información.
Los archivos detalles con nacimientos, contendrán la siguiente información: nro partida
nacimiento, nombre, apellido, dirección detallada (calle,nro, piso, depto, ciudad), matrícula
del médico, nombre y apellido de la madre, DNI madre, nombre y apellido del padre, DNI del
padre.
En cambio, los 50 archivos de fallecimientos tendrán: nro partida nacimiento, DNI, nombre y
apellido del fallecido, matrícula del médico que firma el deceso, fecha y hora del deceso y
lugar.
Realizar un programa que cree el archivo maestro a partir de toda la información de los
archivos detalles. Se debe almacenar en el maestro: nro partida nacimiento, nombre,
apellido, dirección detallada (calle,nro, piso, depto, ciudad), matrícula del médico, nombre y
apellido de la madre, DNI madre, nombre y apellido del padre, DNI del padre y si falleció,
además matrícula del médico que firma el deceso, fecha y hora del deceso y lugar. Se
deberá, además, listar en un archivo de texto la información recolectada de cada persona.
Nota: Todos los archivos están ordenados por nro partida de nacimiento que es única.
Tenga en cuenta que no necesariamente va a fallecer en el distrito donde nació la persona y
además puede no haber fallecido.}

program ejercicio_5;

const
	delegaciones = 50;

type
	str10 = String[10];
	str5 = String[5];
	
	domicilio = record;
		calle: str10;
		numero: integer;
		piso: integer;
		departamento: char;
		ciudad: str10;
	end;
	
	persona = record;
		nombre: str10;
		apellido: str10;
	end;	
	
	nacimiento = record
		partida: integer;
		bebe: persona;
		direccion: domicilio;
		medico: integer;
		madre: persona;
		DNI_madre: integer;
		padre: persona;
		DNI_padre: integer;
	end;
	
	regFallecidoMaestro = record
		medico: integer;
		fecha: str10;
		hora: str5;
		lugar: str10;
	end;

	fallecido = record
		partida: integer;
		fallecido: persona;
		datosFallecido: regFallcidoMaestro;		
	end;
	
	regMaestro = record;
		infoNacimiento: nacimiento;
		fallecio: boolean;
		infoFallecido: regFallcidoMaestro;
	end;		
	
	
	archFallecidos = file of fallecido;
	archNacimientos = file of nacimiento;
	archMaestro = file of regMaestro;

	vectorNacimientos = array 1 to delegaciones of archNaciemientos;
	vectorFallecidos = array 1 to delegaciones of archFallecidos;
	

procedure abrirVectorNacimientos(var v: vectorNaciemientos);
var
	i: integer;
	nombreFisico: str10;

begin
	for i:= 1 to delegaciones do begin
		write('Nombre de archivo de naciemientos de delegacion ',i,': ');
		readLn(nombreFisico);
		assign(v[i], nombreFisico);
		reset(v[i]);
	end;
end;

procedure abrirVectorFallecidos(var v: vectorFallecidos);
var
	i: integer;
	

begin
	for
