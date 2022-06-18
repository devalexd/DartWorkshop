import 'dart:math';

/* About constructors:
 * Link: https://dart.dev/guides/language/language-tour#named-constructors
 * - The order of execution is as follows:
 * 1. initializer list
 * 2. superclass’s unnamed no-arg constructor
 * 3. main class’s unnamed no-arg constructor
 */

abstract class Shape {
  Shape();
  num get area;
}

/* Option 1: ordinary unnamed constructor
 * - You can only have one unnamed constructor, but you can have any number of
 * - additional named constructors.
 */
class Circle extends Shape {
  final num radius;
  Circle(this.radius);
  @override
  num get area => pi * radius * radius;
}

class Triangle extends Shape {
  final num a, b, c;
  Triangle._(this.a, this.b, this.c);
  @override
  num get area {
    final p = (a + b + c) / 2;
    return sqrt(p * (p - a) * (p - b) * (p - c));
  }
}

/* Option 2: factory constructor
 * Link: https://dart.dev/guides/language/language-tour#factory-constructors
 * - Use the factory keyword when implementing a constructor that doesn’t
 * - always create a new instance of its class. For example, a factory constructor
 * - might return an instance from a cache, or it might return an instance of
 * - a subtype. Another use case for factory constructors is initializing a final
 * - variable using logic that can’t be handled in the initializer list.
 */
class Rectangle extends Shape {
  final num w, h;
  final bool isSquare;
  factory Rectangle(num w, num h) {
    if (w == h) {
      return Rectangle.asSquare(w);
    } else {
      return Rectangle.asNonSquare(w, h);
    }
  }
  Rectangle.asSquare(num l): w = l, h = l, isSquare = true;
  Rectangle.asNonSquare(this.w, this.h): isSquare = false;
  @override
  num get area => w * h;
}
