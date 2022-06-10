// Aprende más sobre Dart y Flutter:
// Video tutoriales en youtube: https://tinyurl.com/youyayo
// Tutoriales en mi blog: https://tinyurl.com/yw5hawc2
//
// Yayo Arellano
import 'dart:io';

void main() {
  var texto = 'Hola mundo';

  var textoInvertido = StringBuffer();

  for (var i = texto.length - 1; i >= 0; i--) {
    textoInvertido.write(String.fromCharCode(texto.runes.elementAt(i)));
  }

  print(textoInvertido);




  ejercicio5();
}

// Crear un programa que calcula la suma de los primeros 10
// numeros naturales.
void ejercicio1() {
  var suma = 0;
  for (var i = 1; i <= 10; i++) {
    suma += i;
  }
  print('La suma es: $suma');
}

// Crear un programa que dado un numero muestre
// su tabla de multiplicar.
void ejercicio2() {
  var numero = 5;
  for (var i = 0; i <= 10; i++) {
    print('$numero x $i = ${numero * i}');
  }
}

// Crear un programa que calcule el factorial de un
// numero dado
void ejercicio3() {
  var numero = 5;

  var factorial = 1;
  for (var i = 1; i <= numero; i++) {
    factorial *= i;
  }
  print('El factorial de $numero es: $factorial');
}

// Crear un programa que dado un arreglo de numeros
// imprima la suma de los pares e impares
void ejercicio4() {
  var numeros = [2, 2, 3, 3];

  var sumaPares = 0;
  var sumaImpares = 0;
  for (var i = 0; i < numeros.length; i++) {
    if (numeros[i] % 2 == 0) {
      sumaPares += numeros[i];
    } else {
      sumaImpares += numeros[i];
    }
  }
  print('La suma de los pares es $sumaPares');
  print('La suma de los impares es $sumaImpares');
}

// Crear un programa que dado un numero entero mayor que 0
// determine si es primo o no
void ejercicio5() {
  var numero = 7;

  var esPrimo = true;

  if (numero < 2) {
    esPrimo = false;
  } else {
    for (var i = 2; i < numero; i++) {
      if (numero % i == 0) {
        esPrimo = false;
        break;
      }
    }
  }

  print(esPrimo ? 'Si es primo' : 'No es primo');
}
