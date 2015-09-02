#!/bin/bash
#

function _rotar_linea {
	# Tiempo a dormir entre giro
	INTERVAL=1
	
	# Para cada TCOUNT la linea gira 45 grados
	TCOUNT="0"
	
	# Bucle infinito hasta que terminamos la funcion
	while true
	do
		TCOUNT=`expr $TCOUNT + 1` # Incrementa TCOUNT
		case $TCOUNT in
			"1") echo -e "-""\b\c"
				sleep $INTERVAL ;;
			"2") echo -e '\\'"\b\c"
				sleep $INTERVAL ;;
			"3") echo -e "|""\b\c"
				sleep $INTERVAL ;;
			"4") echo -e "/""\b\c"
				sleep $INTERVAL ;;
			*) TCOUNT="0" ;; 			# Pone a cero TCOUNT
	esac
	done
}
######## Cuerpo principal ############

# Ejecuta la función _rotar_linea en background, es decir,
# se ejecuta concurrentemente con el resto del guion.
_rotar_linea &

# Captura el PID del último proceso que está en background.
ROTAR_PID=$!

# Simulamos la ejecución de una orden que consume mucha CPU
# durante la cual mostramos la línea rotando

for ((CONT=1; CONT<900000; CONT++ )) ;
do
	:
done

# Paramos la función _rotar_linea

kill -9 $ROTAR_PID 	# provoca la terminación del proceso cuyo PID es $ROTAR_PID

# Limpiamos el trazo que queda tras finalizar

echo -e "\b\b"
