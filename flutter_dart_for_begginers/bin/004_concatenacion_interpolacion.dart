void main() {
  // Tipo de datos String: Son cadenas de texto.
  var miVariable1 = 'Hola';
  var miVariable2 = 'mundo';

  print( miVariable1 + miVariable2 ); // Hay que poner el espacio


  // Quiero imprimir Hola mundo

  // Concatenacion
  print(miVariable1 + ' ' + miVariable2);

  // Interpolacion
  print( '$miVariable1 $miVariable2' );


  // Conversión automatica
  var miVariable3 = 'El número es:';
  var miVariable4 = 100;

  print( '$miVariable3 $miVariable4' );
}
