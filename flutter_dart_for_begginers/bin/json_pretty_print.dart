import 'dart:convert';

// Aprende Dart & Flutter
// https://yayocode.com/es

void main() {
  final map = {
    'nombre': 'Gerardo',
    'edad': 28,
    'direccion': {
      'calle': '123 centro',
      'ciudad': 'Mexico',
      'telefono': 123456789,
    },
    'hobbies': [
      'ejercicio',
      'programacion',
      'escribir',
    ]
  };

  print(prettyJson(map));
}

String prettyJson(Map<String, Object> json) =>
    JsonEncoder.withIndent('  ').convert(json);














