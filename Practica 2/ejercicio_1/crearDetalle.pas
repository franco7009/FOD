program crearDetalle;
const
	valorAlto = 9999;
	
type
	str10 = String[10];
	
	empleado = record
		codigo: integer;
		monto: real;
		nombre: str10;
	end;
	
	archivo = file of empleado;
	

procedure crear(var detalle: archivo);

	procedure leer(var e: empleado);
	begin	
		write(#10 + 'Codigo (corte - 9999: ');
		readLn(e.codigo);
		if (e.codigo <> valorAlto) then begin
			write('Monto: ');
			readLn(e.monto);
			write('Nombre: ');
			readLn(e.nombre);
		end;
	end;
	

var
	e: empleado;

begin
	leer(e);
	while (e.codigo <> valorAlto) do begin
		write(detalle, e);
		leer(e);
	end;
end;

//----------------------------------------------------------------------

procedure imprimir(var detalle: archivo);
var
	e: empleado;
begin
	seek(detalle, 0);
	while(not eof(detalle)) do begin
		read(detalle, e);
		writeLn(#10 + 'Codigo: ', e.codigo);
		writeLn('Monto: ', e.monto:2:2);
		writeLn('Nombre: ', e.nombre);
	end;
end;

//----------------------------------------------------------------------

var
	detalle: archivo;

begin
	assign(detalle, 'detalle.txt');
	reset(detalle);
	//crear(detalle);
	imprimir(detalle);
	close(detalle);
End.
