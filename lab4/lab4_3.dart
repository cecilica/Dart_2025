/* Implement class MathOps, where T and G can be int, double or String:


    MathOps <T,G> {
      int sub(T obj1, G obj2);
      int prod(T obj1, G obj2);
      int mod(T obj1, G obj2);
    }

    ^^ I assumed that all values are valid numbers, so I didn't add any error handling for invalid values.
*/

int getVal(var obj) {
  /* Returns the integer value of the object */

  if(obj is double) {
    return obj.toInt();
  } else if(obj is String) {
    return double.parse(obj).toInt();
  }

  return obj;
}

class MathOps <T,G> {
  int sub(T obj1, G obj2) {
    return getVal(obj1) - getVal(obj2);
  }

  int prod(T obj1, G obj2) {
    return getVal(obj1) * getVal(obj2);
  }

  int mod(T obj1, G obj2) {
    return getVal(obj1) % getVal(obj2);
  }
}

void main() {
  MathOps mathOps = MathOps();

  print(mathOps.sub(1, 5));
  print(mathOps.prod(1, "5"));
  print(mathOps.mod("100", 5));

  print(mathOps.sub(10.55, "5"));
  print(mathOps.prod(10.55, 5));
  print(mathOps.mod("10.55", 5));

  print(mathOps.sub("100", 5));
  print(mathOps.prod("100", "5"));
  print(mathOps.mod("10", "9.55"));
}
