program ejercicio_1_v2;

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


//----------------------------------------------------------------------

	
procedure compactar(var detalle, maestro: archivo);

	procedure leerDetalle(var detalle: archivo; var regDet: empleado);
	begin		

		if (not eof(detalle)) then
			read(detalle, regDet)
		else
			regDet.codigo:= valorAlto;
	end;


var
	regDet: empleado; 
	regMae: empleado;

begin
	leerDetalle(detalle, regDet);
	
	while (regDet.codigo <> valorAlto) do begin
		regMae:= regDet;
		regMae.monto:= 0;
		
		while (regMae.codigo = regDet.codigo) do begin
			regMae.monto:= regMae.monto + regDet.monto;
			leerDetalle(detalle, regDet);
		end;
		write(maestro, regMae);
	end;
end;


//---------------------------------------------------------------------


procedure imprimir(var maestro: archivo);
var
	e: empleado;
begin
	seek(maestro, 0);
	while(not eof(maestro)) do begin
		read(maestro, e);
		writeLn(#10 + 'Codigo: ', e.codigo);
		writeLn('Monto: ', e.monto:2:2);
		writeLn('Nombre: ', e.nombre);
	end;
end;


//----------------------------------------------------------------------


var
	detalle, maestro: archivo;
	
begin

	assign(detalle, 'detalle.txt');
	assign(maestro, 'maestro.txt');
	reset(detalle);
	rewrite(maestro);
	compactar(detalle, maestro);
	imprimir(maestro);
	close(detalle);
	close(maestro);
end.
	
