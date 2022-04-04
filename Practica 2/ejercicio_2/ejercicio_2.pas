{2. Se dispone de un archivo con información de los alumnos de la Facultad de Informática. Por
cada alumno se dispone de su código de alumno, apellido, nombre, cantidad de materias
(cursadas) aprobadas sin final y cantidad de materias con final aprobado. Además, se tiene
un archivo detalle con el código de alumno e información correspondiente a una materia
(esta información indica si aprobó la cursada o aprobó el final).
Todos los archivos están ordenados por código de alumno y en el archivo detalle puede
haber 0, 1 ó más registros por cada alumno del archivo maestro. Se pide realizar un
programa con opciones para:
a. Actualizar el archivo maestro de la siguiente manera:
i.Si aprobó el final se incrementa en uno la cantidad de materias con final aprobado.
ii.Si aprobó la cursada se incrementa en uno la cantidad de materias aprobadas sin
final.
b. Listar en un archivo de texto los alumnos que tengan más de cuatro materias
con cursada aprobada pero no aprobaron el final. Deben listarse todos los campos.
NOTA: Para la actualización del inciso a) los archivos deben ser recorridos sólo una vez.}

program ejercicio_2;

const
	valorAlto = 9999;
	
type
	str10 = String[10];
	srt2 = String[2];
	
	regMaestro = record
		codigo: integer;
		apellido: str10;
		nombre: str10;
		cursadas: integer;
		aprobadas: integer;
	end;
	
	archMaestro = file of regMaestro;
	
	regDetalle = record
		codigo: integer;
		aprobo: srt2;
		cursada: srt2;		
	end;
	
	archDetalle = file of regDetalle;


//----------------------------------------------------------------------


procedure leerDetalle(var detalle: archDetalle; var d: regDetalle);

begin
	if (not eof(detalle)) then begin
		read(detalle, d)
	end
	else
		d.codigo:= valorAlto;
end;


procedure actualizar(var detalle: archDetalle; var maestro: archMaestro);
var
	d: regDetalle;
	m: regMaestro;
	
begin
	leerDetalle(detalle, d);
	
	while(not eof(maestro)) and (d.codigo <> valorAlto) do begin
		read(maestro, m);
			
		while ((not eof(maestro)) and (m.codigo <> d.codigo)) do begin
			read(maestro, m);
		end;
		
		while (m.codigo = d.codigo) do begin
			
			if (d.cursada = 'si') then 
				m.cursadas:= m.cursadas + 1;
				
			if (d.aprobo = 'si') then 
				m.aprobadas:= m.aprobadas + 1;
			
			leerDetalle(detalle, d);			
		end;			
		seek(maestro, filepos(maestro) - 1);		
		write(maestro, m);
	end;
end;


//----------------------------------------------------------------------



var
	maestro: archMaestro;
	detalle: archDetalle;
	
begin
	assign(maestro, 'maestro.txt');
	assign(detalle, 'detalle.txt');
	reset(maestro);
	reset(detalle);
	actualizar(detalle, maestro);
	close(maestro);
	close(detalle);
end.
				
			
			
	
	
	
	
