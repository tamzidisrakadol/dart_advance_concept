/*
FACTORY CONSTRUCTOR

What is it?
A factory constructor is a special type of constructor that doesn't always create a new instance
of the class. Instead, it can return an existing instance or control the instance creation logic.

How to use it?
- Use the 'factory' keyword before the constructor
- Factory constructors can return instances from cache, singleton patterns, or subtypes
- They cannot access 'this' keyword since they may not create new instances

Where to use it?
- Singleton pattern implementation
- Object caching/pooling
- Returning subtypes based on parameters
- Complex initialization logic
- When you want to control instance creation
*/

// Example 1: Basic Factory Constructor with Caching
class DatabaseConnection {
  static DatabaseConnection? _instance;
  final String connectionString;
  
  // Private constructor
  DatabaseConnection._internal(this.connectionString);
  
  // Factory constructor that implements singleton pattern
  factory DatabaseConnection(String connectionString) {
    _instance ??= DatabaseConnection._internal(connectionString);
    return _instance!;
  }
  
  void connect() {
    print('Connected to database: $connectionString');
  }
}

// Example 2: Factory Constructor Returning Different Subtypes
abstract class Shape {
  factory Shape(String type) {
    switch (type.toLowerCase()) {
      case 'circle':
        return Circle();
      case 'rectangle':
        return Rectangle();
      case 'triangle':
        return Triangle();
      default:
        throw ArgumentError('Unknown shape type: $type');
    }
  }
  
  void draw();
}

class Circle implements Shape {
  @override
  void draw() => print('Drawing a Circle');
}

class Rectangle implements Shape {
  @override
  void draw() => print('Drawing a Rectangle');
}

class Triangle implements Shape {
  @override
  void draw() => print('Drawing a Triangle');
}

// Example 3: Factory Constructor with Object Pool
class ExpensiveObject {
  static final List<ExpensiveObject> _pool = [];
  final String data;
  bool _inUse = false;
  
  ExpensiveObject._internal(this.data);
  
  // Factory constructor that uses object pooling
  factory ExpensiveObject(String data) {
    // Try to reuse an existing object from pool
    for (var obj in _pool) {
      if (!obj._inUse) {
        obj._inUse = true;
        obj._updateData(data);
        return obj;
      }
    }
    
    // Create new object if pool is empty or all objects are in use
    var newObj = ExpensiveObject._internal(data);
    newObj._inUse = true;
    _pool.add(newObj);
    return newObj;
  }
  
  void _updateData(String newData) {
    print('Updating object data to: $newData');
  }
  
  void release() {
    _inUse = false;
    print('Object released back to pool');
  }
  
  void process() {
    print('Processing data: $data');
  }
}

// Example 4: Factory Constructor with JSON Parsing
class User {
  final String name;
  final int age;
  final String email;
  
  User._(this.name, this.age, this.email);
  
  // Factory constructor for creating User from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    if (json['name'] == null || json['age'] == null || json['email'] == null) {
      throw ArgumentError('Invalid JSON: missing required fields');
    }
    
    return User._(
      json['name'] as String,
      json['age'] as int,
      json['email'] as String,
    );
  }
  
  // Factory constructor with validation
  factory User.create(String name, int age, String email) {
    if (name.isEmpty) throw ArgumentError('Name cannot be empty');
    if (age < 0 || age > 150) throw ArgumentError('Invalid age');
    if (!email.contains('@')) throw ArgumentError('Invalid email format');
    
    return User._(name, age, email);
  }
  
  @override
  String toString() => 'User(name: $name, age: $age, email: $email)';
}

void main() {
  print('=== Factory Constructor Examples ===\n');
  
  // Example 1: Singleton Database Connection
  print('1. Singleton Pattern with Factory Constructor:');
  var db1 = DatabaseConnection('localhost:5432');
  var db2 = DatabaseConnection('different-host:3306');
  print('Same instance? ${identical(db1, db2)}'); // true - singleton
  db1.connect();
  print('');
  
  // Example 2: Shape Factory
  print('2. Factory Constructor Returning Different Subtypes:');
  var shapes = ['circle', 'rectangle', 'triangle'];
  for (var shapeType in shapes) {
    var shape = Shape(shapeType);
    shape.draw();
  }
  print('');
  
  // Example 3: Object Pooling
  print('3. Object Pooling with Factory Constructor:');
  var obj1 = ExpensiveObject('data1');
  obj1.process();
  obj1.release();
  
  var obj2 = ExpensiveObject('data2'); // Reuses obj1
  obj2.process();
  print('Same instance reused? ${identical(obj1, obj2)}'); // true
  print('');
  
  // Example 4: JSON Parsing and Validation
  print('4. Factory Constructor with JSON and Validation:');
  try {
    var user1 = User.fromJson({
      'name': 'John Doe',
      'age': 30,
      'email': 'john@example.com'
    });
    print('Created user: $user1');
    
    var user2 = User.create('Jane Smith', 25, 'jane@example.com');
    print('Created user: $user2');
    
    // This will throw an error
    User.create('', -5, 'invalid-email');
  } catch (e) {
    print('Error: $e');
  }
}