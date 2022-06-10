// Aprende más sobre Dart y Flutter:
// Video tutoriales en youtube: https://tinyurl.com/youyayo
// Tutoriales en mi blog: https://tinyurl.com/yw5hawc2
//
// Yayo Arellano
void main() {
  var i = 1;

  do {
    print('El valor de i es: ${i++}');
  } while (i <= 10);

  i = 0;
  var carros = ['Toyota', 'Mazda', 'Nissan'];

  do {
    print('El carro es: ${carros[i++]}');
  } while (i < carros.length);

  do {
    print('El carro es: ${carros[i]}');
    i = i + 1;
  } while (i < carros.length);


}
