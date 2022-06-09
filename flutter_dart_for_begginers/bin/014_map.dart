// Aprende más sobre Dart y Flutter:
// Video tutoriales en youtube: https://tinyurl.com/youyayo
// Tutoriales en mi blog: https://tinyurl.com/yw5hawc2
//
// Yayo Arellano
void main() {

  var colorHex = {
    // Key:    Value
    'blanco': '#FFFFFF',
    'azul': '#0000FF',
    'rojo': '#FF0000'
  };

  print(colorHex['blanco']);
  print(colorHex['azul']);
  print(colorHex['rojo']);

  print('El tamaño del mapa es: ${colorHex.length}');
  print('¿El mapa esta vacio?: ${colorHex.isEmpty}');
  print('¿El mapa contiene el elemento?: ${colorHex.containsKey('blanco')}');

  // Agregamos un nuevo elemento
  colorHex['verde']='00FF00';
  print('El tamaño del mapa ahora es: ${colorHex.length}');

  // Borrar todos los elementos
  colorHex.clear();
  print('El tamaño del mapa ahora es: ${colorHex.length}');
}
