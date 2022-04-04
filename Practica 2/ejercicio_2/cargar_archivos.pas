program cargarArchivos;

const
	valorAlto = 9999;
	
type
	str10 = String[10];
	str2 = String[2];
	
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
		aprobo: str2;
		cursada: str2;		
	end;
	
	archDetalle = file of regDetalle;

procedure cargarMaestro(var m: regMaestro);

begin
	write(#10 + 'Codigo: ');
	readLn(m.codigo);
	if(m.codigo <> valorAlto) then begin
		write('Apellido: ');
		readLn(m.apellido);
		write('Nombre: ');
		readLn(m.nombre);
		write('Cursadas aprobadas: ');
		readLn(m.cursadas);
		write('Finales aprobados: ');
		readLn(m.aprobadas);
	end;
end;

procedure cargarDetalle(var d: regDetalle);
begin
	write(#10 + 'Codigo: ');
	readLn(d.codigo);
	if(d.codigo <> valorAlto) then begin
		write('Cursada aprobada? (si - no): ');
		readLn(d.cursada);
		write('Final aprobado? (si - no): ');
		readLn(d.aprobo);

	end;
end;

procedure imprimir (var maestro: archMaestro);
var
	m: regMaestro;
begin
	while (not eof(maestro)) do begin
		read(maestro, m);
		writeLn(#10 + 'Codigo: ', m.codigo);
		writeLn('Apellido: ', m.apellido);
		writeLn('Nombre: ', m.nombre);
		writeLn('Cursadas aprobadas: ', m.cursadas);
		writeLn('Finales aprobados: ', m.aprobadas);
		end;
	end;

var
	maestro: archMaestro;
	detalle: archDetalle;
	d: regDetalle;
	m: regMaestro;
	
begin
	assign(maestro, 'maestro.txt');
	assign(detalle, 'detalle.txt');
	reset(maestro);
	reset(detalle);
	imprimir(maestro);
	{cargarMaestro(m);
	while (m.codigo <> valorAlto) do begin
	 	write(maestro, m);
		cargarMaestro(m);
	end;
	cargarDetalle(d);
	while (d.codigo <> valorAlto) do begin
		write(detalle, d);
		cargarDetalle(d);

	end;}
	close(maestro);
	close(detalle);
end.
				
