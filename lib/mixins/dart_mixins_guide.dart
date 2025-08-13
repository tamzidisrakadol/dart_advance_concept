// DART MIXINS - Complete Guide
// =============================

// What is a Mixin?
// A mixin is a way to reuse code in multiple class hierarchies without using inheritance.
// Think of it as "ingredients" that you can add to classes to give them specific abilities.

// Basic Mixin Example
mixin Flyable {
  void fly() {
    print('I can fly!');
  }
  
  double get maxAltitude => 1000.0;
}

mixin Swimmable {
  void swim() {
    print('I can swim!');
  }
  
  double get maxDepth => 50.0;
}

mixin Walkable {
  void walk() {
    print('I can walk!');
  }
  
  double get maxSpeed => 10.0;
}

// Using mixins with classes
class Bird with Flyable, Walkable {
  String species;
  
  Bird(this.species);
  
  void introduce() {
    print('I am a $species');
  }
}

class Fish with Swimmable {
  String type;
  
  Fish(this.type);
  
  void introduce() {
    print('I am a $type fish');
  }
}

class Duck with Flyable, Swimmable, Walkable {
  String name;
  
  Duck(this.name);
  
  void introduce() {
    print('I am $name the duck - I can do it all!');
  }
}

// Advanced Mixin with 'on' keyword
// Use 'on' when your mixin needs specific functionality from a base class
class Animal {
  String name;
  Animal(this.name);
  
  void breathe() {
    print('$name is breathing');
  }
}

mixin Carnivore on Animal {
  void hunt() {
    print('$name is hunting for prey');
  }
  
  void eat(String prey) {
    print('$name is eating $prey');
  }
}

class Lion extends Animal with Carnivore {
  Lion(String name) : super(name);
}

// Mixin with abstract methods
mixin Debuggable {
  void log(String message) {
    print('[${runtimeType}] $message');
  }
  
  // Abstract method that must be implemented
  String get debugInfo;
  
  void debug() {
    log(debugInfo);
  }
}

class User with Debuggable {
  String username;
  int age;
  
  User(this.username, this.age);
  
  @override
  String get debugInfo => 'User: $username, Age: $age';
}

// Practical Example: Database Operations
mixin Cacheable {
  final Map<String, dynamic> _cache = {};
  
  void cache(String key, dynamic value) {
    _cache[key] = value;
    print('Cached: $key');
  }
  
  T? getCached<T>(String key) {
    return _cache[key] as T?;
  }
  
  void clearCache() {
    _cache.clear();
    print('Cache cleared');
  }
}

mixin Loggable {
  void logOperation(String operation) {
    print('[${DateTime.now()}] $operation');
  }
}

class UserRepository with Cacheable, Loggable {
  List<User> findUsers() {
    logOperation('Finding users');
    
    // Check cache first
    var cached = getCached<List<User>>('users');
    if (cached != null) {
      logOperation('Retrieved users from cache');
      return cached;
    }
    
    // Simulate database call
    var users = [User('John', 25), User('Jane', 30)];
    cache('users', users);
    
    return users;
  }
}

void main() {
  print('=== Basic Mixin Usage ===');
  
  var bird = Bird('Eagle');
  bird.introduce();
  bird.fly();
  bird.walk();
  print('Max altitude: ${bird.maxAltitude}m');
  
  print('\n=== Multiple Mixins ===');
  
  var duck = Duck('Donald');
  duck.introduce();
  duck.fly();
  duck.swim();
  duck.walk();
  
  print('\n=== Mixin with "on" keyword ===');
  
  var lion = Lion('Simba');
  lion.breathe();
  lion.hunt();
  lion.eat('gazelle');
  
  print('\n=== Debuggable Mixin ===');
  
  var user = User('Alice', 28);
  user.debug();
  user.log('User created successfully');
  
  print('\n=== Practical Example ===');
  
  var userRepo = UserRepository();
  var users = userRepo.findUsers();
  
  // Second call will use cache
  users = userRepo.findUsers();
  
  userRepo.clearCache();
}

/*
KEY CONCEPTS:

1. WHAT IS A MIXIN?
   - A way to share code between classes without inheritance
   - Like adding "superpowers" to your classes
   - Multiple mixins can be used on one class

2. HOW TO USE IT?
   - Define with 'mixin' keyword
   - Apply with 'with' keyword
   - Use 'on' keyword to restrict which classes can use the mixin

3. WHERE TO USE IT?
   - When multiple classes need similar functionality
   - Cross-cutting concerns (logging, caching, validation)
   - Adding optional features to classes
   - Avoiding deep inheritance hierarchies

BEST PRACTICES:
- Keep mixins focused on one responsibility
- Use descriptive names ending in -able, -ible (Flyable, Cacheable)
- Prefer composition over inheritance
- Use 'on' keyword when mixin depends on specific class features
*/