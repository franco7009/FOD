{Se cuenta con un archivo de productos de una cadena de venta de alimentos congelados.
De cada producto se almacena: código del producto, nombre, descripción, stock disponible,
stock mínimo y precio del producto.
Se recibe diariamente un archivo detalle de cada una de las 30 sucursales de la cadena. Se
debe realizar el procedimiento que recibe los 30 detalles y actualiza el stock del archivo
maestro. La información que se recibe en los detalles es: código de producto y cantidad
vendida. Además, se deberá informar en un archivo de texto: nombre de producto,
descripción, stock disponible y precio de aquellos productos que tengan stock disponible por
debajo del stock mínimo.
Nota: todos los archivos se encuentran ordenados por código de productos. En cada detalle
puede venir 0 o N registros de un determinado producto.}

program ejercicio_3;

const
	valorAlto = 9999;
	dimF = 30; // Fue probado con 3 detalles para ahorrar tiempo. El ejercicio pide 30

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
	
	regDetalle = record
		codigo: integer;
		vendido: integer;
	end;
	
	archDetalle = file of regDetalle;
	
	vector = array [1..dimF] of archDetalle;


//----------------------------------------------------------------------


procedure actualizar(var v: vector; var maestro: archMaestro);


	procedure minimo(var v: vector; var r: regDetalle);
	var
		min: regDetalle;
		i, actMin: integer;
	begin
		actMin:= -1;
		r.codigo:= valorAlto;
		for i:= 1 to dimF do begin
			if (not eof(v[i])) then begin
				read(v[i], min);
				if(min.codigo < r.codigo) then begin
					if (r.codigo <> valorAlto) then begin
						seek(v[actMin], (filepos(v[actMin])) - 1)
					end;
					actMin:= i;
					r:= min
				end
				else
					seek(v[i], (filepos(v[i])) - 1);
			end;
		end;
	end;
	
	
var
	d: regDetalle;
	m: producto;
begin
	minimo(v, d);	
	while ((not eof(maestro)) and (d.codigo <> valorAlto)) do begin
		read(maestro, m);
		
		while((not eof(maestro)) and (m.codigo <> d.codigo)) do begin
			read(maestro, m);
		end;
		
		while (m.codigo = d.codigo) do begin
			m.disponible:= m.disponible - d.vendido;
			minimo(v, d);
		end;
		
		seek(maestro, filepos(maestro) - 1);
		write(maestro, m);
	end;
end;


//----------------------------------------------------------------------


procedure informar(var maestro: archMaestro; var informe: Text);

	procedure guardar(var m: producto; var informe: Text);
	begin
		writeLn(informe, m.disponible, m.nombre);
		writeLn(informe, m.precio, m.descripcion);
	end;
	
var
	m: producto;
	
begin
	seek(maestro, 0);
	while (not eof(maestro)) do begin
		read(maestro, m);
		if (m.disponible < m.minimo)then
			guardar(m, informe);
	end;
end;


//----------------------------------------------------------------------


procedure abrirDetalle(var v: vector);
var
	i: integer;
	detFisico: str15;

begin
	for i:= 1 to dimF do begin
		write('Nombre del detalle ',i,': ');
		readLn(detFisico);
		assign(v[i], detFisico);
		reset(v[i]);
	end;
end;
	
	
//----------------------------------------------------------------------


procedure cerrarDetalle(var v: vector);
var
	i: integer;

begin
	for i:= 1 to dimF do
		close(v[i]);
end;


//----------------------------------------------------------------------


var
	maestro: archMaestro;
	v: vector;
	informe: Text;

begin
	assign(maestro, 'maestro.txt');
	assign(informe, 'informe.txt');
	reset(maestro);
	rewrite(informe);
	abrirDetalle(v);
	actualizar(v, maestro);
	informar(maestro, informe);
	close(maestro);
	close(informe);
	cerrarDetalle(v);
End.
	
