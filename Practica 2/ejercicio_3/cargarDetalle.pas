procedure cargarDet;
const
	valorAlto = 9999;
	dimF = 3;

type
	str15 = String[15];
	regDetalle = record
		codigo: integer;
		vendido: integer;
	end;
	
	archDetalle = file of regDetalle;
	
	vector = array [1..dimF] of archDetalle;


//----------------------------------------------------------------------


procedure cargarDetalle(var v: vector);

	procedure leer(var d: regDetalle);
	begin
		write('Codigo: ');
		readLn(d.codigo);
		if (d.codigo <> valorAlto) then begin
			write('Cantidad vendida: ');
			readLn(d.vendido);
		end;
	end;


var
	d: regDetalle;
	i: integer;
	detFisico: str15;
	
begin
	for i:= 1 to dimF do begin
		write('Nombre del detalle ',i,': ');
		readLn(detFisico);
		assign(v[i], detFisico);
		rewrite(v[i]);
		leer(d);
		while (d.codigo <> valorAlto) do begin
			write(v[i], d);
			leer(d);
		end;
	end;
end;


//----------------------------------------------------------------------


procedure imprimirDetalle(var v: vector);
var
	d: regDetalle;
	i: integer;
	
begin
	for i:= 1 to dimF do begin
		write('Detalle ',i,': ');
		while (not eof(v[i])) do begin
			read(v[i], d);
			writeLn('Codigo: ', d.codigo);
			writeLn('Vendido: ', d.vendido);
		end;
	end;
end;


//---------------------------------------------------------------------


procedure cerrarDetalle(var v: vector);
var
	i: integer;
	
begin
	for i:= 1 to dimF do begin
		close(v[i]);
	end;
end;


//----------------------------------------------------------------------


var
	v: vector;
	
begin
	cargarDetalle(v);
	imprimirDetalle(v);
	cerrarDetalle(v);
End.


