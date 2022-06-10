/// Prioridad de operadores

void main() {
  // Ahora vamos a ver que es la prioridad de operadores, en programacion
  // Cuando tenemos una operacion donde hay sumas, restas, multiplicaciones, divisiones, etc.
  // Estas no se ejecutan de izquierda a derecha.

  // Por ejemplo la siguiente operacion:
  var resultado = 5 + 5 / 2; // Si se ejecutaran de izq a derecha el resultado seria 5

  print(resultado); // Pero no es cinco: es 7.5 Porque??

  // Ahora que vimos la tabla anterior sabmos que primero se ejecuta la division (Explicar)
  // Si queremos que el resultado sea 5 tenemos que agregar parentesis a la suma para que se ejecute primero.

  var resultado2 = (5 + 5) / 2;
  print(resultado2);

  // Que pasa si tenemos la siguiente operacion. Que se va ejecutar primero?
  var resultado3 = 10 / 2 * 5 + 5;
  print(resultado3);
}
