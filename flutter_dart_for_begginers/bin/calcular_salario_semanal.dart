// Aprende más sobre Dart y Flutter:
// Video tutoriales en youtube: https://tinyurl.com/youyayo
// Tutoriales en mi blog: https://tinyurl.com/yw5hawc2
//
// Yayo Arellano
// Calcular el promedio de 3 números.
void main() {
  // Este valor lo elegimos nosotros
  final horasTrabajadas = 40;

  // Estos valores son dados por el problema
  final salarioHora = 10;
  final salarioHoraExtra = 15;

  var salarioSemanal;

  if (horasTrabajadas > 40) {
    salarioSemanal = 40 * salarioHora;
    salarioSemanal += (horasTrabajadas - 40) * salarioHoraExtra;
  } else {
    salarioSemanal = horasTrabajadas * salarioHora;
  }

  print('El salario semanal es de: $salarioSemanal');
}
