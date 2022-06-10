// Aprende más sobre Dart y Flutter:
// Video tutoriales en youtube: https://tinyurl.com/youyayo
// Tutoriales en mi blog: https://tinyurl.com/yw5hawc2
//
// Yayo Arellano
// Crear un programa que dado el diámetro de un círculo nos diga su perímetro y su área
void main() {
  final pi = 3.1416;

  final diametro = 5;

  final radio = diametro / 2;

  final perimetro = 2 * pi * radio;
  final area = pi * radio * radio;

  print('El perimetro es: $perimetro');
  print('El area es: $area');
}
