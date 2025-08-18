void main() {
  print("=== GENERIC METHODS AND FUNCTIONS ===\n");

  print("1. Basic Generic Functions:");
  
  print("Swapping integers:");
  int a = 10, b = 20;
  print("Before swap: a=$a, b=$b");
  var swapped = swap<int>(a, b);
  print("After swap: a=${swapped.first}, b=${swapped.second}");
  
  print("\nSwapping strings:");
  String x = "Hello", y = "World";
  print("Before swap: x=$x, y=$y");
  var swappedStrings = swap<String>(x, y);
  print("After swap: x=${swappedStrings.first}, y=${swappedStrings.second}");
  print("");

  print("2. Generic Functions with Type Inference:");
  
  print("Finding maximum:");
  int maxInt = findMax(15, 25);
  double maxDouble = findMax(3.14, 2.71);
  String maxString = findMax("apple", "banana");
  
  print("Max of 15 and 25: $maxInt");
  print("Max of 3.14 and 2.71: $maxDouble");
  print("Max of 'apple' and 'banana': $maxString");
  print("");

  print("3. Generic Collection Operations:");
  
  List<int> numbers = [1, 2, 3, 4, 5];
  List<String> words = ["hello", "world", "dart"];
  
  print("Original numbers: $numbers");
  print("Reversed numbers: ${reverseList(numbers)}");
  
  print("Original words: $words");
  print("Reversed words: ${reverseList(words)}");
  
  print("First 3 numbers: ${takeFirst(numbers, 3)}");
  print("First 2 words: ${takeFirst(words, 2)}");
  print("");

  print("4. Generic Transformation Functions:");
  
  List<int> squared = transform(numbers, (n) => n * n);
  List<String> uppercased = transform(words, (w) => w.toUpperCase());
  
  print("Squared numbers: $squared");
  print("Uppercased words: $uppercased");
  
  List<String> numberStrings = transform(numbers, (n) => "Number: $n");
  print("Number strings: $numberStrings");
  print("");

  print("5. Generic Filtering and Searching:");
  
  List<int> evenNumbers = filter(numbers, (n) => n % 2 == 0);
  List<String> longWords = filter(words, (w) => w.length > 4);
  
  print("Even numbers: $evenNumbers");
  print("Long words: $longWords");
  
  int? foundNumber = findFirst(numbers, (n) => n > 3);
  String? foundWord = findFirst(words, (w) => w.startsWith('d'));
  
  print("First number > 3: $foundNumber");
  print("First word starting with 'd': $foundWord");
  print("");

  print("6. Generic Reduction Operations:");
  
  int sum = reduce(numbers, 0, (acc, n) => acc + n);
  String concatenated = reduce(words, "", (acc, w) => acc + w);
  
  print("Sum of numbers: $sum");
  print("Concatenated words: $concatenated");
  
  int product = reduce(numbers, 1, (acc, n) => acc * n);
  print("Product of numbers: $product");
  print("");

  print("7. Generic Utility Functions:");
  
  print("Creating pairs:");
  var numberPair = createPair(10, 20);
  var mixedPair = createPair("Age", 25);
  
  print("Number pair: (${numberPair.first}, ${numberPair.second})");
  print("Mixed pair: (${mixedPair.first}, ${mixedPair.second})");
  
  print("\nChecking containment:");
  print("Numbers contain 3: ${contains(numbers, 3)}");
  print("Words contain 'dart': ${contains(words, 'dart')}");
  print("Numbers contain 10: ${contains(numbers, 10)}");
  print("");

  print("8. Generic Comparison Functions:");
  
  List<int> list1 = [1, 2, 3];
  List<int> list2 = [1, 2, 3];
  List<int> list3 = [1, 2, 4];
  
  print("list1 equals list2: ${areEqual(list1, list2)}");
  print("list1 equals list3: ${areEqual(list1, list3)}");
  
  List<String> words1 = ["a", "b"];
  List<String> words2 = ["a", "b"];
  print("words1 equals words2: ${areEqual(words1, words2)}");
  print("");

  print("9. Generic Factory Methods:");
  
  Container<int> intContainer = createContainer(42);
  Container<String> stringContainer = createContainer("Hello");
  Container<bool> boolContainer = createContainer(true);
  
  print("Int container: ${intContainer.value}");
  print("String container: ${stringContainer.value}");
  print("Bool container: ${boolContainer.value}");
  print("");

  print("10. Complex Generic Operations:");
  
  List<Person> people = [
    Person("Alice", 25),
    Person("Bob", 30),
    Person("Charlie", 35)
  ];
  
  List<String> names = transform(people, (p) => p.name);
  List<Person> adults = filter(people, (p) => p.age >= 18);
  Person? oldestPerson = reduce(people, null, (oldest, person) {
    return oldest == null || person.age > oldest.age ? person : oldest;
  });
  
  print("Names: $names");
  print("Adults: ${adults.map((p) => p.name).toList()}");
  print("Oldest person: ${oldestPerson?.name} (${oldestPerson?.age})");
}

Pair<T, T> swap<T>(T first, T second) {
  return Pair(second, first);
}

T findMax<T extends Comparable>(T a, T b) {
  return a.compareTo(b) > 0 ? a : b;
}

List<T> reverseList<T>(List<T> list) {
  return list.reversed.toList();
}

List<T> takeFirst<T>(List<T> list, int count) {
  return list.take(count).toList();
}

List<U> transform<T, U>(List<T> list, U Function(T) transformer) {
  return list.map(transformer).toList();
}

List<T> filter<T>(List<T> list, bool Function(T) predicate) {
  return list.where(predicate).toList();
}

T? findFirst<T>(List<T> list, bool Function(T) predicate) {
  for (T item in list) {
    if (predicate(item)) return item;
  }
  return null;
}

U reduce<T, U>(List<T> list, U initialValue, U Function(U, T) reducer) {
  U result = initialValue;
  for (T item in list) {
    result = reducer(result, item);
  }
  return result;
}

Pair<T, U> createPair<T, U>(T first, U second) {
  return Pair(first, second);
}

bool contains<T>(List<T> list, T item) {
  return list.contains(item);
}

bool areEqual<T>(List<T> list1, List<T> list2) {
  if (list1.length != list2.length) return false;
  
  for (int i = 0; i < list1.length; i++) {
    if (list1[i] != list2[i]) return false;
  }
  
  return true;
}

Container<T> createContainer<T>(T value) {
  return Container<T>(value);
}

T getDefaultValue<T>() {
  return null as T;
}

class Pair<T, U> {
  final T first;
  final U second;

  Pair(this.first, this.second);

  @override
  String toString() => '($first, $second)';
}

class Container<T> {
  T value;

  Container(this.value);

  void updateValue(T newValue) {
    value = newValue;
  }

  @override
  String toString() => 'Container<$T>($value)';
}

class Person {
  final String name;
  final int age;

  Person(this.name, this.age);

  @override
  String toString() => 'Person(name: $name, age: $age)';
}

extension GenericListExtensions<T> on List<T> {
  List<U> mapToList<U>(U Function(T) transform) {
    return map(transform).toList();
  }

  List<T> filterList(bool Function(T) predicate) {
    return where(predicate).toList();
  }

  T? findElement(bool Function(T) predicate) {
    for (T element in this) {
      if (predicate(element)) return element;
    }
    return null;
  }
}

mixin GenericMixin<T> {
  List<T> items = [];

  void addItem(T item) {
    items.add(item);
  }

  void removeItem(T item) {
    items.remove(item);
  }

  List<T> getAllItems() {
    return List.from(items);
  }

  int getCount() {
    return items.length;
  }
}