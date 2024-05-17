void main() {
  final texto = 'ABCDE😆';
  final repetido = <int>{};
  int? resultado;

  for (int i = 0; i < texto.length; i++) {
    final char = texto[i];
    print(char);
  }

  for (final caracter in texto.runes) {
    if (repetido.contains(caracter)) {
      resultado = caracter;
      break;
    }
    repetido.add(caracter);
  }

  if (resultado == null) {
    print('No hay carácter repetido');
  } else {
    print(
      'El primer carácter repetido es: ${String.fromCharCode(resultado)}',
    );
  }
}
