// Aprende más sobre Dart y Flutter:
// Video tutoriales en youtube: https://tinyurl.com/youyayo
// Tutoriales en mi blog: https://tinyurl.com/yw5hawc2
//
// Yayo Arellano
void main() {
  // Declaramos 2 variables mencionando el tipo
  String miNombre = 'Gerardo';
  int miNumero = 5;

  print(miNombre);
  print(miNumero);

  // Como son variables las podemos modificar mas adelante
  miNombre = 'Carlos';
  miNumero = 100;

  print(miNombre);
  print(miNumero);

  // Otra forma de declarar variables es con la palabra `var`
  var miNombre2 = 'Juan';

  // El compilador sabe que es de tipo String. Esto se le llama
  // inferencia de datos. Asi que ya no puedo cambiar el valor a un
  // numero
  // miNombre2=5;

  print(miNombre2);

  // Por ultimo tenemos las constantes que se declaran
  // usando "final"
  const pi = 3.1416;
  print(pi);

  final otroNumero= 12345;
  print(otroNumero);

  // Ya no la podeoms modificar
  // otroNumero = 500;


}
