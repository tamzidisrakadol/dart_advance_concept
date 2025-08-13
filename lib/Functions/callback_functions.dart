// CALLBACK FUNCTIONS IN DART
// ===========================

// What are Callback Functions?
// Functions that are passed as arguments to other functions
// and are called back (executed) at a specific time or when certain conditions are met

import 'package:dart_advance_concept/dart_advance_concept.dart';

Future<void> main() async {
  print('=== CALLBACK FUNCTIONS GUIDE ===\n');

  // 1. BASIC CALLBACK CONCEPT
  print('1. Basic Callback Concept:');
  
  // Function that takes a callback
  void processData(String data, void Function(String) callback) {
    print('Processing: $data');
    // Simulate some processing time
    Future.delayed(Duration(milliseconds: 100), () {
      callback('Processed: $data');
    });
  }
  
  // Using the callback
  processData('user data', (result) {
    print('Callback received: $result');
  });
  
  // Give some time for async callback to complete
  await Future.delayed(Duration(milliseconds: 200));
  print('');

  // 2. SYNCHRONOUS CALLBACKS
  print('2. Synchronous Callbacks:');
  
  // Calculator with operation callback
  double calculate(double a, double b, double Function(double, double) operation) {
    print('Calculating with $a and $b');
    return operation(a, b);
  }
  
  // Different operations as callbacks
  var sum = calculate(10, 5, (a, b) {
    print('Performing addition');
    return a + b;
  });
  
  var product = calculate(10, 5, (a, b) {
    print('Performing multiplication');
    return a * b;
  });
  
  print('Sum: $sum');
  print('Product: $product\n');

  // 3. ASYNCHRONOUS CALLBACKS
  print('3. Asynchronous Callbacks:');
  
  // Simulate API call with success and error callbacks
  void fetchUserData(String userId, {
    required void Function(Map<String, dynamic>) onSuccess,
    required void Function(String) onError,
  }) {
    print('Fetching user data for: $userId');
    
    // Simulate random success/failure
    Future.delayed(Duration(milliseconds: 500), () {
      if (userId.isNotEmpty) {
        onSuccess({'id': userId, 'name': 'John Doe', 'email': 'john@example.com'});
      } else {
        onError('Invalid user ID');
      }
    });
  }
  
  // Using async callbacks
  fetchUserData(
    'user123',
    onSuccess: (userData) {
      print('Success callback: User loaded - ${userData['name']}');
    },
    onError: (error) {
      print('Error callback: $error');
    },
  );
  
  await Future.delayed(Duration(milliseconds: 600));
  print('');

  // 4. EVENT HANDLING WITH CALLBACKS
  print('4. Event Handling:');
  
  // Simple event emitter (imported from dart_advance_concept.dart)
  var emitter = EventEmitter();
  
  // Register event callbacks
  emitter.on('user:login', (user) {
    print('Login callback: Welcome ${user['name']}!');
  });
  
  emitter.on('user:login', (user) {
    print('Analytics callback: User ${user['id']} logged in');
  });
  
  emitter.on('user:logout', (user) {
    print('Logout callback: Goodbye ${user['name']}!');
  });
  
  // Trigger events
  emitter.emit('user:login', {'id': 'user123', 'name': 'Alice'});
  emitter.emit('user:logout', {'id': 'user123', 'name': 'Alice'});
  print('');

  // 5. CALLBACK CHAINING
  print('5. Callback Chaining:');
  
  // Function that processes data in steps with callbacks
  void processInSteps(
    String data,
    String Function(String) step1,
    String Function(String) step2,
    void Function(String) onComplete,
  ) {
    print('Starting processing chain...');
    
    var result1 = step1(data);
    print('Step 1 complete: $result1');
    
    var result2 = step2(result1);
    print('Step 2 complete: $result2');
    
    onComplete(result2);
  }
  
  processInSteps(
    'raw data',
    (data) => 'cleaned: $data',           // Step 1: Clean
    (data) => 'validated: $data',         // Step 2: Validate
    (result) => print('Final result: $result'), // Completion callback
  );
  
  print('');

  // 6. CALLBACK PATTERNS IN COLLECTIONS
  print('6. Collection Callbacks:');
  
  List<int> numbers = [1, 2, 3, 4, 5];
  
  // Custom forEach with callback
  void customForEach<T>(List<T> list, void Function(T, int) callback) {
    for (int i = 0; i < list.length; i++) {
      callback(list[i], i);
    }
  }
  
  // Custom filter with callback
  List<T> customWhere<T>(List<T> list, bool Function(T) callback) {
    List<T> result = [];
    for (T item in list) {
      if (callback(item)) {
        result.add(item);
      }
    }
    return result;
  }
  
  print('Custom forEach:');
  customForEach(numbers, (value, index) {
    print('  Index $index: $value');
  });
  
  var evenNumbers = customWhere(numbers, (n) => n % 2 == 0);
  print('Even numbers: $evenNumbers\n');

  // 7. TIMER AND DELAYED CALLBACKS
  print('7. Timer and Delayed Callbacks:');
  
  // Simple timer implementation
  void setTimer(Duration duration, void Function() callback) {
    print('Timer set for ${duration.inMilliseconds}ms');
    Future.delayed(duration, callback);
  }
  
  // Interval implementation
  void setInterval(Duration duration, void Function() callback, int times) {
    int count = 0;
    void tick() {
      if (count < times) {
        callback();
        count++;
        Future.delayed(duration, tick);
      }
    }
    tick();
  }
  
  setTimer(Duration(milliseconds: 100), () {
    print('Timer callback executed!');
  });
  
  print('Setting up interval...');
  setInterval(Duration(milliseconds: 200), () {
    print('Interval tick at ${DateTime.now().millisecondsSinceEpoch}');
  }, 3);
  
  await Future.delayed(Duration(milliseconds: 800));
  print('');

  // 8. ERROR HANDLING IN CALLBACKS
  print('8. Error Handling in Callbacks:');
  
  // Safe callback execution
  void safeCallback(void Function() callback) {
    try {
      callback();
    } catch (e) {
      print('Callback error caught: $e');
    }
  }
  
  // Function with error and success callbacks
  void riskyOperation(
    void Function(String) onSuccess,
    void Function(String) onError,
  ) {
    try {
      // Simulate some risky operation
      if (DateTime.now().millisecond % 2 == 0) {
        onSuccess('Operation completed successfully!');
      } else {
        throw Exception('Random error occurred');
      }
    } catch (e) {
      onError(e.toString());
    }
  }
  
  riskyOperation(
    (result) => print('Success: $result'),
    (error) => print('Error: $error'),
  );
  
  // Safe callback examples
  safeCallback(() => print('Safe callback 1'));
  safeCallback(() => throw Exception('This will be caught'));
  safeCallback(() => print('Safe callback 2'));
  
  print('');

  // 9. REAL-WORLD EXAMPLES
  print('9. Real-World Examples:');
  
  // HTTP-like request with callbacks (imported from dart_advance_concept.dart)
  var client = HttpClient();
  client.get(
    'https://api.example.com/data',
    onStart: () => print('Request started...'),
    onSuccess: (response) => print('Response: ${response['data']}'),
    onError: (error) => print('Request failed: $error'),
    onComplete: () => print('Request completed'),
  );
  
  await Future.delayed(Duration(milliseconds: 400));
  
  // Form validation with callbacks (imported from dart_advance_concept.dart)
  var validator = FormValidator();
  Map<String, String> formData = {
    'email': 'test@example.com',
    'password': '123', // Invalid - too short
    'name': '', // Invalid - empty
  };
  
  var validationRules = {
    'email': (value) => value.contains('@'),
    'password': (value) => value.length >= 6,
    'name': (value) => value.isNotEmpty,
  };
  
  validator.validate(formData, validationRules, (errors) {
    if (errors.isEmpty) {
      print('Form is valid!');
    } else {
      print('Validation errors: ${errors.join(', ')}');
    }
  });
}

/*
KEY CONCEPTS:

1. WHAT ARE CALLBACKS?
   - Functions passed as arguments to other functions
   - Called back at specific times or conditions
   - Enable asynchronous and event-driven programming

2. TYPES OF CALLBACKS:
   - Synchronous: Executed immediately
   - Asynchronous: Executed later (after delay/event)
   - Success/Error: Handle different outcomes
   - Event: Respond to events

3. COMMON PATTERNS:
   - Event handling
   - API requests (success/error callbacks)
   - Timer and interval operations
   - Collection processing
   - Validation and form handling

4. BENEFITS:
   ✅ Asynchronous programming
   ✅ Event-driven architecture
   ✅ Separation of concerns
   ✅ Flexible response handling
   ✅ Code reusability

5. POTENTIAL ISSUES:
   ❌ Callback hell (nested callbacks)
   ❌ Error handling complexity
   ❌ Memory leaks if not handled properly
   ❌ Debugging difficulties

6. BEST PRACTICES:
   - Keep callbacks simple and focused
   - Handle errors appropriately
   - Avoid deep nesting (callback hell)
   - Consider using Futures/Streams for complex async operations
   - Use named parameters for multiple callbacks
   - Document callback parameters clearly

7. WHEN TO USE:
   ✅ Event handling systems
   ✅ API calls with success/error handling
   ✅ Timer and animation callbacks
   ✅ Custom collection operations
   ✅ Plugin and middleware systems

8. ALTERNATIVES TO CONSIDER:
   - Futures and async/await for asynchronous operations
   - Streams for continuous data
   - State management patterns
   - Observer pattern
*/