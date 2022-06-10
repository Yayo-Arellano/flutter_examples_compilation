// Aprende más sobre Dart y Flutter:
// Video tutoriales en youtube: https://tinyurl.com/youyayo
// Tutoriales en mi blog: https://tinyurl.com/yw5hawc2
//
// Yayo Arellano
void main() {
  for (var i = 1; i <= 10; i++) {
    if (i == 5) {
      break;
    }
    print('El valor de i es: $i');
  }

  for (var i = 1; i <= 10; i++) {
    if (i == 5) {
      continue;
    }
    print('El valor de i es: $i');
  }
}
