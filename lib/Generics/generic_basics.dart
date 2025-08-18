void main() {
  print("=== DART GENERICS FUNDAMENTALS ===\n");

  print("What are Generics?");
  print("Generics allow you to write code that works with multiple types");
  print("while maintaining type safety at compile time.\n");

  print("Why do we need Generics?");
  print("1. Type Safety - Catch errors at compile time");
  print("2. Code Reusability - Write once, use with multiple types");
  print("3. Performance - No runtime type checking needed");
  print("4. Cleaner Code - Eliminate type casting\n");

  print("=== BASIC GENERIC USAGE ===\n");

  print("1. Built-in Generic Collections:");
  
  List<String> stringList = ['Apple', 'Banana', 'Cherry'];
  List<int> numberList = [1, 2, 3, 4, 5];
  Map<String, int> ageMap = {'Alice': 25, 'Bob': 30, 'Charlie': 35};
  Set<String> uniqueNames = {'John', 'Jane', 'Bob'};

  print("String List: $stringList");
  print("Number List: $numberList");
  print("Age Map: $ageMap");
  print("Unique Names: $uniqueNames");
  print("");

  print("2. Generic Type Inference:");
  
  var autoStringList = <String>['Auto', 'Inferred', 'Types'];
  var autoNumberList = <int>[10, 20, 30];
  
  print("Auto String List: $autoStringList");
  print("Auto Number List: $autoNumberList");
  print("");

  print("3. Without Generics vs With Generics:");
  
  print("--- Without Generics (BAD) ---");
  NonGenericBox stringBox = NonGenericBox('Hello World');
  NonGenericBox numberBox = NonGenericBox(42);
  
  String? retrievedString = stringBox.getValue() as String?;
  int? retrievedNumber = numberBox.getValue() as int?;
  
  print("Retrieved String: $retrievedString");
  print("Retrieved Number: $retrievedNumber");
  print("");

  print("--- With Generics (GOOD) ---");
  GenericBox<String> genericStringBox = GenericBox<String>('Hello Generics');
  GenericBox<int> genericNumberBox = GenericBox<int>(100);
  
  String genericString = genericStringBox.getValue();
  int genericNumber = genericNumberBox.getValue();
  
  print("Generic String: $genericString");
  print("Generic Number: $genericNumber");
  print("");

  print("4. Multiple Type Parameters:");
  
  Pair<String, int> nameAge = Pair('Alice', 25);
  Pair<String, String> nameCity = Pair('Bob', 'New York');
  Pair<int, bool> numberFlag = Pair(42, true);
  
  print("Name-Age: ${nameAge.first} is ${nameAge.second} years old");
  print("Name-City: ${nameCity.first} lives in ${nameCity.second}");
  print("Number-Flag: ${numberFlag.first} is ${numberFlag.second}");
  print("");

  print("5. Generic Collections with Custom Types:");
  
  List<Person> people = [
    Person('Alice', 25),
    Person('Bob', 30),
    Person('Charlie', 35)
  ];
  
  Map<String, Person> personMap = {
    'p1': Person('David', 28),
    'p2': Person('Eve', 32)
  };
  
  print("People List:");
  for (Person person in people) {
    print("  ${person.name} (${person.age})");
  }
  
  print("Person Map:");
  personMap.forEach((key, person) {
    print("  $key: ${person.name} (${person.age})");
  });
  print("");

  print("6. Generic Type Checking:");
  
  GenericBox<String> stringOnlyBox = GenericBox<String>('Type Safe');
  
  print("String box type: ${stringOnlyBox.runtimeType}");
  print("Is GenericBox<String>: ${stringOnlyBox is GenericBox<String>}");
  print("Is GenericBox<int>: ${stringOnlyBox is GenericBox<int>}");
  print("");

  print("7. Nullable Generics:");
  
  GenericBox<String?> nullableStringBox = GenericBox<String?>(null);
  GenericBox<int?> nullableIntBox = GenericBox<int?>(null);
  
  print("Nullable String Box: ${nullableStringBox.getValue()}");
  print("Nullable Int Box: ${nullableIntBox.getValue()}");
  
  nullableStringBox.setValue('Now has value');
  nullableIntBox.setValue(999);
  
  print("After setting values:");
  print("Nullable String Box: ${nullableStringBox.getValue()}");
  print("Nullable Int Box: ${nullableIntBox.getValue()}");
}

class NonGenericBox {
  dynamic _value;

  NonGenericBox(this._value);

  dynamic getValue() => _value;
  
  void setValue(dynamic value) => _value = value;
}

class GenericBox<T> {
  T _value;

  GenericBox(this._value);

  T getValue() => _value;
  
  void setValue(T value) => _value = value;
  
  @override
  String toString() => 'GenericBox<$T>($_value)';
}

class Pair<T, U> {
  T first;
  U second;

  Pair(this.first, this.second);

  @override
  String toString() => 'Pair<$T, $U>($first, $second)';
}

class Person {
  String name;
  int age;

  Person(this.name, this.age);

  @override
  String toString() => 'Person(name: $name, age: $age)';
}