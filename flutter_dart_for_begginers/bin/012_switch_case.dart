// Aprende más sobre Dart y Flutter:
// Video tutoriales en youtube: https://tinyurl.com/youyayo
// Tutoriales en mi blog: https://tinyurl.com/yw5hawc2
//
// Yayo Arellano
void main() {
  // La estructura de control switch case permite comparar
  // strings, numeros u otras constantes con el operador relacional igual que  (==)

  // Si suponemos que la semana empieza en el dia 1 que es domingo y termina en el dia 7 que es
  // sabdo
  final diaActual = 2;

  switch (diaActual) {
    case 1:
      print('Lunes');
      break;
    case 2:
      print('Martes');
      break;
    case 3:
      print('Miercoles');
      break;
    case 4:
      print('Jueves');
      break;
    case 5:
      print('Viernes');
      break;
    case 6:
      print('Sabado');
      break;
    case 7:
      print('Domingo');
      break;
    default:
      print('El dia no existe');
      break;
  }

  // Y que pasa si solo queremos imprimir si es fin de semana (Sabado o domingo) o no.
  switch (diaActual) {
    case 1:
    case 2:
    case 3:
    case 4:
    case 5:
      print('No es fin de semana');
      break;
    case 7:
    case 6:
      print('Es fin de semana');
      break;
    default:
      print('El dia no existe');
      break;
  }
}
