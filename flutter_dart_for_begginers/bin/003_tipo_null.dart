/// Tipos de datos: Null
///
void main() {
  // En este videp vamos a hablar sobre soporte de verificacion de nulos o
  // null safety. Que fue agregada en  la version de dart 2.12.
  // Cuando declaramos una variable por defecto no puede tener nulos.
  // Pero hay veces que declaramos una variable sin asignarle un valor
  // o no le queremos asignar un valor de inmediato por lo que podemos
  // declararla con soporte de nulo.

  // Vamos a empezar creando una variable sin iniciarlasale.
  // Si imprimimos POdemos ver que el resultado es null
  var nombre;
  print('El nombre es $nombre');

  // El compilador reconoze automaticamente que la variable anterior puede ser null pero no sabe
  // si es una String, int, etc.

  // Si declaramos una variable diciendo el tipo y la queremos usar sin inicializar
  // vemos que tenemos un error de compilacion porque el tipo de dato String no puede tener el valor
  // de null
  String nombre2;
  // print(nombre2);

  // Si queremos declarar una variable

  int? numero;
  print('El numero es $numero');
}
