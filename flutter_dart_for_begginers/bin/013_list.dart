// Aprende más sobre Dart y Flutter:
// Video tutoriales en youtube: https://tinyurl.com/youyayo
// Tutoriales en mi blog: https://tinyurl.com/yw5hawc2
//
// Yayo Arellano
void main() {
  // Creamos una lista
  var carros = ['Toyota', 'Mazda', 'Nissan'];
  print(carros[0]);
  print(carros[1]);
  print(carros[2]);

  print('El tamaño de la lista es: ${carros.length}');
  print('¿La lista esta vacia?: ${carros.isEmpty}');
  print('¿La lista contiene el elemento?: ${carros.contains('Toyota')}');

  // Agregamos un nuevo elemento
  carros.add('Ford');
  print('El tamaño de la lista ahora es: ${carros.length}');

  // Reemplazamos el elemento en la posicion 0
  carros[0] = "BMW";
  print('Los elementos de la lista son: $carros');

  // Borrar todos los elementos de la lista
  carros.clear();
  print('El tamaño de la lista ahora es: ${carros.length}');

}
