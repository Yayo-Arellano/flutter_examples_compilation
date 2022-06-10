// Video tutoriales en youtube: https://tinyurl.com/youyayo
// Tutoriales en mi blog: https://tinyurl.com/yw5hawc2
//
// Yayo Arellano
/*
Crear un programa que dada una temperatura en grados imprima el tipo de clima de acuerdo
a las siguientes condiciones:
- Si la temperatura 10 grados o menos es clima frio
- Si la temperatura esta entre 11 y 20 grados es clima templado
- Si la temperatura es mayor que 20 y menor o igual que 30 grados es clima tropical
- Mayor de 30 es clima caluroso
 */
void main() {
  final temperatura = 11;

  if (temperatura <= 10) {
    print('Clima frio');
  } else if (temperatura >= 11 && temperatura <= 20) {
    print('Clima templado');
  } else if (temperatura >= 21 && temperatura <= 30) {
    print('Clima tropical');
  } else {
    print('Clima caluroso');
  }
}
