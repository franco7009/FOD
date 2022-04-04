{4. Suponga que trabaja en una oficina donde está montada una LAN (red local). La misma
fue construida sobre una topología de red que conecta 5 máquinas entre sí y todas las
máquinas se conectan con un servidor central. Semanalmente cada máquina genera un
archivo de logs informando las sesiones abiertas por cada usuario en cada terminal y por
cuánto tiempo estuvo abierta. Cada archivo detalle contiene los siguientes campos:
cod_usuario, fecha, tiempo_sesion. Debe realizar un procedimiento que reciba los archivos
detalle y genere un archivo maestro con los siguientes datos: cod_usuario, fecha,
tiempo_total_de_sesiones_abiertas.
Notas:
- Cada archivo detalle está ordenado por cod_usuario y fecha.
- Un usuario puede iniciar más de una sesión el mismo día en la misma o en diferentes
máquinas.
- El archivo maestro debe crearse en la siguiente ubicación física: /var/log.}

program ejercicio_4;

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


procedure generarMaestro(var v: vector; var maestro: archMaestro);

	procedure minimo(var v: vector; var d: regDetalle);
	var
		min: regDetalle;
		minAct, i: integer;
		
	begin
		d.codigo_usuario:= codigoAlto;
		minAct:= -1;
				
		for i:= 1 to maquinas do begin
			if (not eof(v[i])) then begin
				read(v[i], min);
				
				if (min.codigo_usuario < d.codigo_usuario) then begin
					if (d.codigo_usuario <> codigoAlto) then begin
						seek(v[minAct], filepos(v[minAct]) - 1);
					end;
					d:= min;
					minAct:= i
				end
				else begin
					if ((min.codigo_usuario = d.codigo_usuario) and (min.fecha < d.fecha)) then begin
						seek(v[minAct], filepos(v[minAct]) - 1);
						d:= min;
						minAct:= i
					end
					else
						seek(v[i], filepos(v[i]) - 1);
				end;
			end;
		end;
	end;



var
	d: regDetalle;
	m: regMaestro;
	
begin
	minimo(v, d);
	
	while (d.codigo_usuario <> codigoAlto) do begin

		m.codigo_usuario:= d.codigo_usuario;
		
		while ((d.codigo_usuario <> codigoAlto) and (d.codigo_usuario = m.codigo_usuario)) do begin

				m.fecha:= d.fecha;
				m.tiempo_total:= 0;
				
				while ((d.codigo_usuario = m.codigo_usuario) and (d.fecha = m.fecha)) do begin
					m.tiempo_total:= m.tiempo_total + d.tiempo_sesion;
					minimo(v, d);
				end;
				write(maestro, m);
		end;
	end;
end;


//----------------------------------------------------------------------


procedure imprimirMaestro(var maestro: archMaestro);
var
	m: regMaestro;
begin
	seek(maestro, 0);
	while (not eof(maestro)) do begin
		read(maestro, m);
		writeLn(#10 + 'Codigo: ', m.codigo_usuario);
		writeLn('Fecha: ', m.fecha);
		writeLn('Tiempo total: ', m.tiempo_total);
	end;
end;


//----------------------------------------------------------------------


procedure abrirDetalle(var v: vector);
var
	i: integer;
	detalleFisico: str15;
	
begin
	for i:= 1 to maquinas do begin
		write(#10 + 'Nombre del detalle ',i,': ');
		readLn(detalleFisico);
		assign(v[i], detalleFisico);
		reset(v[i]);
	end;
	{assign(v[1], 'log_1.txt');
	assign(v[2], 'log_2.txt');
	assign(v[3], 'log_3.txt');
	for i:= 1 to 3 do
		reset(v[i]);}
end;


//----------------------------------------------------------------------


procedure cerrarDetalle(var v: vector);
var
	i: integer;
begin
	for i:= 1 to maquinas do
		close(v[i]);
end;


//----------------------------------------------------------------------


var
	maestro: archMaestro;
	v: vector;

begin
	assign(maestro, 'D:\Users\ezequ\Documents\Facultad\Fundamentos De Organizacion de Datos\Practica\Practica 2\ejercicio_4\var\log\maestro.txt');
	rewrite(maestro);
	abrirDetalle(v);
	generarMaestro(v, maestro);
	imprimirMaestro(maestro);
	cerrarDetalle(v);
	close(maestro);
End.
				
	
