void main() {
  // Operadores de igualdad
  var a = true;

  print(a); // Imprime true
  print(!a); // Imprime false

  // Operadores logicos

  final alicia = 21;
  final gerardo = 15;

  if (alicia >= 18 && gerardo >= 18) {
    print('&&: Alicia y Gerardo son mayor que 18');
  } else {
    print('&&: Alicia y/o Gerardo son menores de 18');
  }

  if (alicia >= 18 || gerardo >= 18) {
    print('||: Alicia y/o Gerardo son mayores de 18');
  } else {
    print('||: Ninguno es mayor de 18');
  }


}
