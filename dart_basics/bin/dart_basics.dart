import 'dart:io';

void main() {
  // print('hello word');
  // var x = stdin.readLineSync();
  // print("ok$x");
  print('entet two numbers');
  print('number 1');
  var num1 = stdin.readLineSync();
  print('number 2');
  var num2 = stdin.readLineSync();
  var n1 = int.parse(num1!);
  var n2 = int.parse(num2!);

  print('sum = ${n1 + n2}');
}
