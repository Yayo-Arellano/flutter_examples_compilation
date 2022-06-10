void main() {
  // Operador ?
  var edad = 17;

  if (edad >= 18) {
    print('Es mayor de edad');
  } else {
    print('Es menor de edad');
  }

  edad >= 18 ? print('Es mayor de edad') : print('Es menor de edad');

  // Operador ??
  String? nombre = 'Yayo';

  if (nombre == null) {
    print('El nombre es nulo');
  } else {
    print(nombre);
  }

  print(nombre ?? 'El nombre es nulo ');
}
