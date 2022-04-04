program cargar;

const
	valorAlto = 9999;
	dimF = 30;

type
	str10 = String[10];
	str15 = String[15];
	producto = record
		codigo: integer;
		nombre: str10;
		descripcion: str10;
		disponible: integer;
		minimo: integer;
		precio: real;
	end;
	
	archMaestro = file of producto;


procedure cargarMaestro(var maestro: archMaestro);
	procedure leer(var m: producto);
	begin
		write('Codigo: ');
		readLn(m.codigo);
		if (m.codigo <> valorAlto) then begin
			write('Nombre: ');
			readLn(m.nombre);
			write('Descripcion: ');
			readLn(m.descripcion);
			write('Disponibles: ');
			readLn(m.disponible);
			write('Minimo: ');
			readLn(m.minimo);
			write('Precio: ');
			readLn(m.precio);
		end;
	end;
	
var
	m: producto;
	
begin
	leer(m);
	while (m.codigo <> valorAlto) do begin
		write(maestro, m);
		leer(m);
	end;
end;


procedure imprimirMaestro(var maestro: archMaestro);
var
	m: producto;
begin
	while(not eof(maestro)) do begin
		read(maestro, m);
		writeLn(#10 + 'Codigo: ', m.codigo);
		writeLn('Nombre: ', m.nombre);
		writeLn('Descripcion: ', m.descripcion);
		writeLn('Disponibles: ', m.disponible);
		writeLn('Minimo: ', m.minimo);
		writeLn('Precio: ', m.precio:2:2);
	end;
end;

var
	maestro: archMaestro;
	
begin
	assign(maestro, 'maestro.txt');
	{rewrite(maestro);
	cargarMaestro(maestro);}
	reset(maestro);
	imprimirMaestro(maestro);
	close(maestro);
end.
