// Aprende más sobre Dart y Flutter:
// Video tutoriales en youtube: https://tinyurl.com/youyayo
// Tutoriales en mi blog: https://tinyurl.com/yw5hawc2
//
// Yayo Arellano
void main() {
  for (var i = 1; i <= 10; i++) {
    print('El valor de i es: $i');
  }

  var carros = ['Toyota', 'Mazda', 'Nissan'];
  for (var i = 0; i < carros.length; i++) {
    print('El carro es: ${carros[i]}');
  }

  for (var carro in carros) {
    print('El carro es: $carro');
  }

}
