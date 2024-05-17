// Aprende Dart & Flutter
// https://yayocode.com/es

enum Carro { toyota, nissan, mazda, ford, tesla }

Carro? carro = Carro.toyota;

void main() {
  // Forma comun
  if (carro == Carro.toyota || carro == Carro.nissan || carro == Carro.mazda) {
    print('El carro es japones');
  }

  // Usando Iterable.contains()
  if ([Carro.toyota, Carro.nissan, Carro.mazda].contains(carro)) {
    print('El carro es japones');
  }

  // Usando 
  if (carro case Carro.toyota || Carro.nissan || Carro.mazda) {
    print('El carro es japones');
  }
}
