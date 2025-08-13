// LAMBDA & ARROW FUNCTIONS IN DART
// ================================

// What are Lambda/Arrow Functions?
// - Anonymous functions (functions without names)
// - Shorter syntax for simple functions
// - Also called "anonymous functions" or "closures"

void main() {
  print('=== LAMBDA & ARROW FUNCTIONS GUIDE ===\n');

  // 1. TRADITIONAL FUNCTION vs ARROW FUNCTION
  print('1. Traditional vs Arrow Functions:');
  
  // Traditional function
  int addTraditional(int a, int b) {
    return a + b;
  }
  
  // Arrow function (lambda)
  int addArrow(int a, int b) => a + b;
  
  print('Traditional: ${addTraditional(5, 3)}');
  print('Arrow: ${addArrow(5, 3)}\n');

  // 2. ANONYMOUS FUNCTIONS (Lambda Functions)
  print('2. Anonymous Functions:');
  
  // Anonymous function assigned to variable
  var multiply = (int a, int b) => a * b;
  var divide = (int a, int b) {
    if (b == 0) throw ArgumentError('Cannot divide by zero');
    return a / b;
  };
  
  print('Multiply: ${multiply(4, 5)}');
  print('Divide: ${divide(10, 2)}\n');

  // 3. FUNCTIONS AS PARAMETERS
  print('3. Functions as Parameters:');
  
  void processNumbers(int a, int b, Function operation) {
    print('Result: ${operation(a, b)}');
  }
  
  // Using arrow functions as parameters
  processNumbers(10, 5, (a, b) => a + b);  // Addition
  processNumbers(10, 5, (a, b) => a - b);  // Subtraction
  processNumbers(10, 5, (a, b) => a * b);  // Multiplication
  print('');

  // 4. LIST OPERATIONS WITH ARROW FUNCTIONS
  print('4. List Operations:');
  
  List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  
  // map() - Transform each element
  var squared = numbers.map((n) => n * n).toList();
  print('Squared: $squared');
  
  // where() - Filter elements
  var evenNumbers = numbers.where((n) => n % 2 == 0).toList();
  print('Even numbers: $evenNumbers');
  
  // reduce() - Combine all elements
  var sum = numbers.reduce((a, b) => a + b);
  print('Sum: $sum');
  
  // forEach() - Execute for each element
  print('Each number: ');
  numbers.take(5).forEach((n) => print('  $n'));
  print('');

  // 5. COMPLEX ARROW FUNCTIONS
  print('5. Complex Examples:');
  
  // Function that returns a function
  Function createMultiplier(int factor) {
    return (int value) => value * factor;
  }
  
  var multiplyByThree = createMultiplier(3);
  print('3 * 7 = ${multiplyByThree(7)}');
  
  // Conditional arrow functions
  var getAbsolute = (int n) => n < 0 ? -n : n;
  print('Absolute of -15: ${getAbsolute(-15)}');
  
  // String operations
  var capitalize = (String s) => s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);
  print('Capitalized: ${capitalize("hello world")}\n');

  // 6. SORTING WITH ARROW FUNCTIONS
  print('6. Sorting Examples:');
  
  List<String> names = ['John', 'Alice', 'Bob', 'Charlie'];
  List<Map<String, dynamic>> people = [
    {'name': 'John', 'age': 25},
    {'name': 'Alice', 'age': 30},
    {'name': 'Bob', 'age': 20},
    {'name': 'Charlie', 'age': 35},
  ];
  
  // Sort strings by length
  names.sort((a, b) => a.length.compareTo(b.length));
  print('Names sorted by length: $names');
  
  // Sort objects by age
  people.sort((a, b) => a['age'].compareTo(b['age']));
  print('People sorted by age: ${people.map((p) => '${p['name']}(${p['age']})').join(', ')}\n');

  // 7. ASYNC ARROW FUNCTIONS
  print('7. Async Arrow Functions:');
  
  // Simple async arrow function
  Future<String> fetchData(String url) async => 'Data from $url';
  
  // Using async arrow functions with lists
  List<String> urls = ['api1.com', 'api2.com', 'api3.com'];
  
  fetchData('example.com').then((data) => print('Fetched: $data'));
  
  // Processing multiple async operations
  var futures = urls.map((url) => fetchData(url)).toList();
  Future.wait(futures).then((results) {
    print('All results: ${results.join(', ')}');
  });

  print('\n8. Practical Real-World Examples:');
  
  // Validation functions
  var isValidEmail = (String email) => email.contains('@') && email.contains('.');
  var isValidPassword = (String password) => password.length >= 8;
  var isAdult = (int age) => age >= 18;
  
  print('Valid email: ${isValidEmail("test@example.com")}');
  print('Valid password: ${isValidPassword("securepass123")}');
  print('Is adult: ${isAdult(25)}');
  
  // Data transformation pipeline
  var processUserData = (Map<String, dynamic> user) => {
    'name': capitalize(user['name']?.toString() ?? ''),
    'email': user['email']?.toString().toLowerCase() ?? '',
    'isActive': user['lastLogin'] != null,
  };
  
  var rawUser = {'name': 'john doe', 'email': 'JOHN@EXAMPLE.COM', 'lastLogin': '2024-01-01'};
  var processedUser = processUserData(rawUser);
  print('Processed user: $processedUser');
}

/*
KEY CONCEPTS:

1. WHAT ARE ARROW FUNCTIONS?
   - Short syntax for simple functions: (params) => expression
   - Single expression only (no statements)
   - Automatically return the expression result

2. LAMBDA FUNCTIONS:
   - Anonymous functions without names
   - Can be assigned to variables
   - Useful for short, one-time operations

3. WHEN TO USE:
   ✅ List operations (map, where, reduce, forEach)
   ✅ Event handlers and callbacks
   ✅ Simple transformations and validations
   ✅ Sorting and comparisons
   ✅ Functional programming patterns

4. WHEN NOT TO USE:
   ❌ Complex logic requiring multiple statements
   ❌ Functions that need debugging (harder to debug)
   ❌ Reusable logic (better as named functions)
   ❌ When readability is compromised

SYNTAX RULES:
- Single expression: (params) => expression
- Multiple statements: (params) { statements; return value; }
- No parameters: () => expression
- Single parameter: param => expression (parentheses optional)
- Multiple parameters: (param1, param2) => expression
*/