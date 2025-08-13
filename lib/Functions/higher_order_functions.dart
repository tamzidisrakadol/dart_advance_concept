// HIGHER ORDER FUNCTIONS IN DART
// ===============================

// What are Higher Order Functions?
// Functions that either:
// 1. Take other functions as parameters, OR
// 2. Return functions as results, OR
// 3. Both

import 'package:dart_advance_concept/dart_advance_concept.dart';

void main() {
  print('=== HIGHER ORDER FUNCTIONS GUIDE ===\n');

  // 1. FUNCTIONS TAKING FUNCTIONS AS PARAMETERS
  print('1. Functions Taking Functions as Parameters:');
  
  // Basic calculator that takes an operation function
  double calculator(double a, double b, double Function(double, double) operation) {
    return operation(a, b);
  }
  
  // Operation functions
  double add(double a, double b) => a + b;
  double multiply(double a, double b) => a * b;
  
  print('Addition: ${calculator(10, 5, add)}');
  print('Multiplication: ${calculator(10, 5, multiply)}');
  print('Subtraction: ${calculator(10, 5, (a, b) => a - b)}');
  print('');

  // 2. FUNCTIONS RETURNING FUNCTIONS
  print('2. Functions Returning Functions:');
  
  // Function factory - creates specialized functions
  Function createValidator(String type) {
    switch (type) {
      case 'email':
        return (String input) => input.contains('@') && input.contains('.');
      case 'phone':
        return (String input) => RegExp(r'^\d{10,}$').hasMatch(input);
      case 'password':
        return (String input) => input.length >= 8 && RegExp(r'[A-Z]').hasMatch(input);
      default:
        return (String input) => input.isNotEmpty;
    }
  }
  
  var emailValidator = createValidator('email');
  var passwordValidator = createValidator('password');
  
  print('Email valid: ${emailValidator('test@example.com')}');
  print('Password valid: ${passwordValidator('SecurePass123')}');
  
  // Function that creates multiplier functions
  Function createMultiplier(num factor) {
    return (num value) => value * factor;
  }
  
  var doubleValue = createMultiplier(2);
  var triple = createMultiplier(3);
  
  print('Double 7: ${doubleValue(7)}');
  print('Triple 7: ${triple(7)}\n');

  // 3. COMMON BUILT-IN HIGHER ORDER FUNCTIONS
  print('3. Built-in Higher Order Functions:');
  
  List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  List<String> words = ['apple', 'banana', 'cherry', 'date', 'elderberry'];
  
  // map() - Transform each element
  var squares = numbers.map((n) => n * n).toList();
  print('Squares: $squares');
  
  // where() - Filter elements
  var evenNumbers = numbers.where((n) => n % 2 == 0).toList();
  print('Even numbers: $evenNumbers');
  
  // reduce() - Combine elements into single value
  var sum = numbers.reduce((acc, current) => acc + current);
  print('Sum: $sum');
  
  // fold() - Like reduce but with initial value
  var product = numbers.take(4).fold(1, (acc, current) => acc * current);
  print('Product of first 4: $product');
  
  // any() and every() - Test conditions
  var hasEven = numbers.any((n) => n % 2 == 0);
  var allPositive = numbers.every((n) => n > 0);
  print('Has even number: $hasEven');
  print('All positive: $allPositive');
  
  // sort() - Sort with custom comparison
  words.sort((a, b) => a.length.compareTo(b.length));
  print('Words by length: $words\n');

  // 4. CUSTOM HIGHER ORDER FUNCTIONS
  print('4. Custom Higher Order Functions:');
  
  // Retry function - executes a function multiple times on failure
  T retry<T>(T Function() operation, {int maxAttempts = 3}) {
    for (int i = 0; i < maxAttempts; i++) {
      try {
        return operation();
      } catch (e) {
        if (i == maxAttempts - 1) rethrow;
        print('Attempt ${i + 1} failed, retrying...');
      }
    }
    throw StateError('This should never be reached');
  }
  
  // Timing function - measures execution time
  T timeExecution<T>(String name, T Function() operation) {
    final stopwatch = Stopwatch()..start();
    final result = operation();
    stopwatch.stop();
    print('$name took ${stopwatch.elapsedMilliseconds}ms');
    return result;
  }
  
  // Cache function - memoization
  T Function(String) cache<T>(T Function(String) operation) {
    final Map<String, T> _cache = {};
    return (String key) {
      if (_cache.containsKey(key)) {
        print('Cache hit for: $key');
        return _cache[key]!;
      }
      print('Cache miss for: $key');
      final result = operation(key);
      _cache[key] = result;
      return result;
    };
  }
  
  // Example usage of custom higher order functions
  var expensiveOperation = (String input) {
    // Simulate expensive computation
    var result = input.length * 100;
    return result;
  };
  
  var cachedOperation = cache(expensiveOperation);
  
  print('First call: ${cachedOperation('hello')}');
  print('Second call: ${cachedOperation('hello')}'); // Cache hit
  
  timeExecution('List processing', () {
    return numbers.where((n) => n % 2 == 0).map((n) => n * n).reduce((a, b) => a + b);
  });
  
  print('');

  // 5. FUNCTION COMPOSITION
  print('5. Function Composition:');
  
  // Compose two functions into one
  C Function(A) compose<A, B, C>(C Function(B) f, B Function(A) g) {
    return (A input) => f(g(input));
  }
  
  // Individual functions
  int addTen(int n) => n + 10;
  int multiplyByTwo(int n) => n * 2;
  String intToString(int n) => n.toString();
  
  // Compose them
  var addThenMultiply = compose(multiplyByTwo, addTen);
  var processNumber = compose(intToString, compose(multiplyByTwo, addTen));
  
  print('5 -> add 10 -> multiply by 2: ${addThenMultiply(5)}');
  print('5 -> add 10 -> multiply by 2 -> toString: ${processNumber(5)}');
  
  print('');

  // 6. CURRYING
  print('6. Currying (Converting multi-parameter functions):');
  
  // Normal function with multiple parameters
  int normalAdd(int a, int b, int c) => a + b + c;
  
  // Curried version - returns functions that take one parameter at a time
  Function curriedAdd(int a) {
    return (int b) {
      return (int c) => a + b + c;
    };
  }
  
  // Using curried function
  var addFive = curriedAdd(5);
  var addFiveAndTen = addFive(10);
  var result = addFiveAndTen(7);
  
  print('Normal add(5, 10, 7): ${normalAdd(5, 10, 7)}');
  print('Curried add(5)(10)(7): $result');
  
  // Practical currying example
  Function createGreeting(String greeting) {
    return (String name) => '$greeting, $name!';
  }
  
  var sayHello = createGreeting('Hello');
  var sayGoodbye = createGreeting('Goodbye');
  
  print('${sayHello('Alice')}');
  print('${sayGoodbye('Bob')}\n');

  // 7. PIPELINE OPERATIONS
  print('7. Pipeline Operations:');
  
  // Create a pipeline of transformations
  T pipe<T>(T value, List<T Function(T)> operations) {
    return operations.fold(value, (current, operation) => operation(current));
  }
  
  // Pipeline of string transformations
  var text = 'hello world from dart';
  var processedText = pipe<String>(text, [
    (String s) => s.split(' ').map((word) => word.isEmpty ? word : word[0].toUpperCase() + word.substring(1)).join(' '),
    (String s) => s.replaceAll(' ', '_'),
    (String s) => s.toUpperCase(),
  ]);
  
  print('Original: $text');
  print('Processed: $processedText');
  
  // Pipeline of number transformations
  var numberPipeline = pipe<int>(5, [
    (int n) => n * 2,      // 10
    (int n) => n + 5,      // 15
    (int n) => n * n,      // 225
    (int n) => n ~/ 10,    // 22
  ]);
  
  print('Number pipeline result: $numberPipeline\n');

  // 8. REAL-WORLD EXAMPLES
  print('8. Real-World Examples:');
  
  // Event handling system (imported from dart_advance_concept.dart)
  var eventBus = EventBus();
  var emitUserLogin = eventBus.createEmitter('user:login');
  var emitUserLogout = eventBus.createEmitter('user:logout');
  
  eventBus.on('user:login', (user) => print('User logged in: $user'));
  eventBus.on('user:logout', (user) => print('User logged out: $user'));
  
  emitUserLogin('Alice');
  emitUserLogout('Bob');
  
  // API wrapper with middleware (imported from dart_advance_concept.dart)
  var api = ApiClient();
  
  // Add logging middleware
  api.use((config) => config['timestamp'] = DateTime.now().toString());
  api.use((config) => config['userAgent'] = 'DartApp/1.0');
  api.use((config) => print('Request intercepted: ${config['url']}'));
  
  api.request({'url': 'https://api.example.com/users', 'method': 'GET'});
}

/*
KEY CONCEPTS:

1. WHAT ARE HIGHER ORDER FUNCTIONS?
   - Functions that operate on other functions
   - Take functions as parameters
   - Return functions as results
   - Enable functional programming patterns

2. COMMON PATTERNS:
   - Map/Filter/Reduce operations
   - Function composition
   - Currying and partial application
   - Middleware and pipeline patterns
   - Event handling systems

3. BENEFITS:
   ✅ Code reusability
   ✅ Functional composition
   ✅ Cleaner abstractions
   ✅ Separation of concerns
   ✅ More expressive code

4. WHEN TO USE:
   ✅ Data transformation pipelines
   ✅ Event systems
   ✅ Validation and middleware
   ✅ API wrappers
   ✅ Configuration and factory patterns

5. BEST PRACTICES:
   - Keep functions pure when possible (no side effects)
   - Use descriptive names for function parameters
   - Consider performance implications
   - Document complex higher-order functions
   - Use generics for type safety
*/