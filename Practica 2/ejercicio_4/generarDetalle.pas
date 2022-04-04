program generarDetalle;

const
	codigoAlto = 9999;
	maquinas = 3;
	
type
	str10 = String[10];
	str15 = String[15];
	regDetalle = record
		codigo_usuario: integer;
		fecha: str10;
		tiempo_sesion: integer;
	end;
	
	archDetalle = file of regDetalle;
	
	vector = array [1..maquinas] of archDetalle;
	
	regMaestro = record		
		codigo_usuario: integer;
		fecha: str10;
		tiempo_total: integer;
	end;
	
	archMaestro = file of regMaestro;


//----------------------------------------------------------------------


procedure crearDetalle(var v: vector);

	procedure leer(var r: regDetalle);
	begin
		write(#10 + 'Codigo de Usuario: ');
		readLn(r.codigo_usuario);
		if (r.codigo_usuario <> codigoAlto) then begin
			write('Fecha: ');
			readLn(r.fecha);
			write('Tiempo de sesion: ');
			readLn(r.tiempo_sesion);
		end;
	end;
	
var
	i: integer;
	detFisico: str15;
	r: regDetalle;

begin
	for i:= 1 to maquinas do begin
		write(#10 + 'Nombre del log ',i,': ');
		readLn(detFisico);
		assign(v[i], detFisico);
		rewrite(v[i]);
		leer(r);
		while( r.codigo_usuario <> codigoAlto) do begin
			write(v[i], r);
			leer(r);
		end;
	end;
end;


//----------------------------------------------------------------------


procedure imprimirDetalle(var v: vector);
var
	i: integer;
	r: regDetalle;

begin
	for i:= 1 to maquinas do begin
		writeLn(#10 + 'Detalle ',i,': ');
		seek(v[i], 0);
		while(not eof(v[i])) do begin
			read(v[i], r);
			writeLn(#10 + 'Codigo de Usuario: ', r.codigo_usuario);
			writeLn('Fecha: ', r.fecha);
			writeLn('Tiempo de sesion: ', r.tiempo_sesion);
		end;
	end;
end;


//----------------------------------------------------------------------


procedure cerrarDetalle(var v: vector);
var
	i: integer;

begin
	for i:= 1 to maquinas do begin
		close(v[i])
	end;
end;


procedure abrirDetalle(var v: vector);
var
	i: integer;
	detFisico: str15;

begin
	assign(v[1], 'log_1.txt');
	assign(v[2], 'log_2.txt');
	assign(v[3], 'log_3.txt');
	for i:= 1 to maquinas do begin
		{write(#10 + 'Nombre del log ',i,': ');
		readLn(detFisico);
		assign(v[i], detFisico);}
		reset(v[i]);
	end;
end;

//----------------------------------------------------------------------

var
	v: vector;

begin
	crearDetalle(v);
	//abrirDetalle(v);
	imprimirDetalle(v);
	cerrarDetalle(v);
End.
