class XMLTest {
  String firstName;
  String lastName;
  int age;
  bool isAlive;

  XMLTest(this.firstName, this.lastName, this.age, this.isAlive);

  factory XMLTest.fromXML(String xml) {
    final firstName = RegExp(r'<firstname>\s*([a-zA-Z]+)\s*</firstname>').firstMatch(xml)?.group(1) ?? "No first name.";
    final lastName = RegExp(r'<lastname>\s*([a-zA-Z]+)\s*</lastname>').firstMatch(xml)?.group(1) ?? "No last name.";
    final age = int.parse(RegExp(r'<age>\s*(\d+)\s*</age>').firstMatch(xml)?.group(1) ?? "0");
    final isAlive = RegExp(r'<isalive>\s*(true|false)\s*</isalive>').firstMatch(xml)?.group(1) == "true";

    return XMLTest(firstName, lastName, age, isAlive);
  }

  String toXML() {
    return 
    '''
    <person>
      <firstname>
        $firstName
      </firstname>
      <lastname>
        $lastName
      </lastname>
      <age>
        $age
      </age>
      <isalive>
        ${isAlive ? "true" : "false"}
      </isalive>
    </person>
    ''';
  }
}

void main() {
  print("Person1 test:");
  XMLTest person1 = XMLTest("Cecilia", "Lungu", 22, true);
  print(person1.toXML());

  print("\nPerson2 test:");
  XMLTest person2 = XMLTest.fromXML(
  '''
  <person>
    <firstname>
    </firstname>
    <lastname>
      Valentina
    </lastname>
    <age>
      200
    </age>
    <isalive>
      false
    </isalive>
  </person>
  '''
  );

  print(person2.firstName);
  print(person2.lastName);
  print(person2.age);
  print(person2.isAlive);
}
