/// Tipos de datos
///
void main() {
  // En este video vamos a ver el tipo de datos que pueden
  // tener las variables. Si recuerdan dijimos que una variable es un
  // espacio en memoria donde almacenamos un valor
  // y este valor puede ser un numero entero, un numero decimal, una
  // cadena de texto, etc.

  // Podemos ver esta table
  // Tipo de datos String: Son cadenas de texto.
  var nombre = 'Gerardo';
  String texto = 'Hola bienvenidos a mi curso';

  print(nombre);
  print(texto);

  // Tipo de datos entero: son numeros sin punto decimal.
  var numeroEntero = 10;
  int otroNumeroEntero = 5;

  print(numeroEntero);
  print(otroNumeroEntero);

  // Si el numero tiene decimales es un double
  var decimal = 1.25;
  double otroDecimal = 0.75;

  print(decimal);
  print(otroDecimal);

  // Los enteros se convierten automaticamente a doubles cuando
  // es necesario
  double x = 1;

  // un double no se convierte automaticamente a int
  //int y = x;

  print(x);

  // Tambien se pueden declarar los numero con el tipo num. De esta
  // la variable puede tener valores enteros y decimales
  num y = 1;
  y = 2.5;
  print(y);

  // Tipo de dato boleano
  final myBool1 = true;
  final myBool2 = false;
  print('El valor de myBool1 es: $myBool1');
  print('El valor de myBool2 es: $myBool2');
}
