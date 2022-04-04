{Una empresa posee un archivo con información de los ingresos percibidos por diferentes
empleados en concepto de comisión, de cada uno de ellos se conoce: código de empleado,
nombre y monto de la comisión. La información del archivo se encuentra ordenada por
código de empleado y cada empleado puede aparecer más de una vez en el archivo de
comisiones.
Realice un procedimiento que reciba el archivo anteriormente descripto y lo compacte. En
consecuencia, deberá generar un nuevo archivo en el cual, cada empleado aparezca una
única vez con el valor total de sus comisiones.
NOTA: No se conoce a priori la cantidad de empleados. Además, el archivo debe ser
recorrido una única vez.}

program ejercicio;

type
	str10 = String[10];
	
	empleado = record
		codigo: integer;
		monto: real;
		nombre: str10;
	end;
	
	archivo = file of empleado;
	
	

procedure compactar(var detalle: Text; var maestro: archivo);

var
	regMae, regDet: empleado;
	suma: real;
	
begin
	readLn(detalle, regDet.codigo, regDet.monto, regDet.nombre);

	while(not eof(maestro)) do begin
		read(maestro, regMae);
		
		while((regMae.codigo <> regDet.codigo) and (not eof(maestro))) do begin
			read(maestro, regMae);
		end;
		suma:= 0;
			
		while((regMae.codigo = regDet.codigo) and (not eof(maestro)) and (not eof(detalle))) do begin
			suma:= suma + regDet.monto;
			readLn(detalle, regDet.codigo, regDet.monto, regDet.nombre);
		end;
		regMae.monto:= regMae.monto + suma;
		seek(maestro, filepos(maestro) - 1);
		write(maestro, regMae);
	end;
end;
		
		


var
	detalle: Text;
	maestro: archivo;
	
begin
	assign(detalle, 'detalle.txt');
	assign(maestro, 'maestro.txt');
	reset(detalle);
	reset(maestro);
	compactar(detalle, maestro);
	close(detalle);
	close(maestro);
end.
