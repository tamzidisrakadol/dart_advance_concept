/*
OBJECT CLONING

What is it?
Object cloning is the process of creating a copy of an existing object. There are two
types of cloning: shallow cloning (copies only the object's direct properties) and
deep cloning (copies the object and all objects it references recursively).

How to use it?
- Shallow Clone: Copy primitive values and references to objects
- Deep Clone: Create new instances of all referenced objects
- Use copyWith methods for immutable objects
- Implement clone methods or use serialization/deserialization

Where to use it?
- When you need to create copies of objects without affecting the original
- When implementing the Prototype pattern
- When you want to modify an object while keeping the original unchanged
- When working with state management in applications
- When creating backup copies of data structures
*/

// Example 1: Basic Shallow vs Deep Cloning

import 'dart:convert';
class Address {
  String street;
  String city;
  String zipCode;
  
  Address({required this.street, required this.city, required this.zipCode});
  
  // Shallow clone - creates new Address but doesn't clone nested objects
  Address clone() {
    return Address(street: street, city: city, zipCode: zipCode);
  }
  
  @override
  String toString() => 'Address($street, $city, $zipCode)';
}

class Person {
  String name;
  int age;
  Address address;
  List<String> hobbies;
  
  Person({
    required this.name,
    required this.age,
    required this.address,
    required this.hobbies,
  });
  
  // Shallow clone - shares address and hobbies references
  Person shallowClone() {
    return Person(
      name: name,
      age: age,
      address: address, // Same reference!
      hobbies: hobbies, // Same reference!
    );
  }
  
  // Deep clone - creates new instances of all objects
  Person deepClone() {
    return Person(
      name: name,
      age: age,
      address: address.clone(), // New Address instance
      hobbies: List<String>.from(hobbies), // New List with same elements
    );
  }
  
  @override
  String toString() => 'Person($name, $age, $address, $hobbies)';
}

// Example 2: Immutable Object with copyWith
class ImmutablePerson {
  final String name;
  final int age;
  final String email;
  final List<String> skills;
  
  const ImmutablePerson({
    required this.name,
    required this.age,
    required this.email,
    required this.skills,
  });
  
  // copyWith method for creating modified copies
  ImmutablePerson copyWith({
    String? name,
    int? age,
    String? email,
    List<String>? skills,
  }) {
    return ImmutablePerson(
      name: name ?? this.name,
      age: age ?? this.age,
      email: email ?? this.email,
      skills: skills ?? List<String>.from(this.skills),
    );
  }
  
  // Clone method that creates exact copy
  ImmutablePerson clone() {
    return ImmutablePerson(
      name: name,
      age: age,
      email: email,
      skills: List<String>.from(skills),
    );
  }
  
  @override
  String toString() => 'ImmutablePerson($name, $age, $email, $skills)';
}

// Example 3: Complex Object Cloning with Nested Objects
class Department {
  String name;
  String budget;
  
  Department({required this.name, required this.budget});
  
  Department clone() => Department(name: name, budget: budget);
  
  @override
  String toString() => 'Department($name, $budget)';
}

class Employee {
  String name;
  String position;
  double salary;
  Department department;
  List<String> projects;
  Map<String, dynamic> metadata;
  
  Employee({
    required this.name,
    required this.position,
    required this.salary,
    required this.department,
    required this.projects,
    required this.metadata,
  });
  
  Employee deepClone() {
    return Employee(
      name: name,
      position: position,
      salary: salary,
      department: department.clone(),
      projects: List<String>.from(projects),
      metadata: Map<String, dynamic>.from(metadata),
    );
  }
  
  @override
  String toString() {
    return 'Employee($name, $position, \$${salary}, $department, $projects, $metadata)';
  }
}

// Example 4: Cloneable Interface Pattern
abstract class Cloneable<T> {
  T clone();
}

class Product implements Cloneable<Product> {
  String name;
  double price;
  List<String> categories;
  Map<String, String> specifications;
  
  Product({
    required this.name,
    required this.price,
    required this.categories,
    required this.specifications,
  });
  
  @override
  Product clone() {
    return Product(
      name: name,
      price: price,
      categories: List<String>.from(categories),
      specifications: Map<String, String>.from(specifications),
    );
  }
  
  // Convenience method for creating variations
  Product createVariation({
    String? newName,
    double? newPrice,
    List<String>? additionalCategories,
    Map<String, String>? additionalSpecs,
  }) {
    var cloned = clone();
    
    if (newName != null) cloned.name = newName;
    if (newPrice != null) cloned.price = newPrice;
    if (additionalCategories != null) cloned.categories.addAll(additionalCategories);
    if (additionalSpecs != null) cloned.specifications.addAll(additionalSpecs);
    
    return cloned;
  }
  
  @override
  String toString() => 'Product($name, \$${price}, $categories, $specifications)';
}

// Example 5: JSON Serialization-based Deep Cloning


class JsonCloneable {
  static T deepCloneViaJson<T>(T object, T Function(Map<String, dynamic>) fromJson) {
    // Convert object to JSON string and back to object
    var jsonString = json.encode(object);
    var jsonMap = json.decode(jsonString) as Map<String, dynamic>;
    return fromJson(jsonMap);
  }
}

class User {
  final String id;
  final String name;
  final String email;
  final Map<String, dynamic> preferences;
  final List<String> roles;
  
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.preferences,
    required this.roles,
  });
  
  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'preferences': preferences,
      'roles': roles,
    };
  }
  
  // Create from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      preferences: Map<String, dynamic>.from(json['preferences']),
      roles: List<String>.from(json['roles']),
    );
  }
  
  // JSON-based deep clone
  User deepClone() {
    return JsonCloneable.deepCloneViaJson(this, User.fromJson);
  }
  
  @override
  String toString() => 'User($id, $name, $email, $preferences, $roles)';
}

// Example 6: State Management with Cloning
class AppState implements Cloneable<AppState> {
  final String currentUser;
  final List<String> notifications;
  final Map<String, bool> features;
  final int sessionTimeout;
  
  AppState({
    required this.currentUser,
    required this.notifications,
    required this.features,
    required this.sessionTimeout,
  });
  
  @override
  AppState clone() {
    return AppState(
      currentUser: currentUser,
      notifications: List<String>.from(notifications),
      features: Map<String, bool>.from(features),
      sessionTimeout: sessionTimeout,
    );
  }
  
  // State modification methods that return new instances
  AppState addNotification(String notification) {
    var newState = clone();
    newState.notifications.add(notification);
    return newState;
  }
  
  AppState removeNotification(String notification) {
    var newState = clone();
    newState.notifications.remove(notification);
    return newState;
  }
  
  AppState toggleFeature(String feature) {
    var newState = clone();
    newState.features[feature] = !(newState.features[feature] ?? false);
    return newState;
  }
  
  AppState updateUser(String newUser) {
    var newState = clone();
    return AppState(
      currentUser: newUser,
      notifications: newState.notifications,
      features: newState.features,
      sessionTimeout: newState.sessionTimeout,
    );
  }
  
  @override
  String toString() {
    return 'AppState(user: $currentUser, notifications: ${notifications.length}, features: $features, timeout: ${sessionTimeout}s)';
  }
}

void main() {
  print('=== Object Cloning Examples ===\n');
  
  // Example 1: Shallow vs Deep Cloning
  print('1. Shallow vs Deep Cloning:');
  var address = Address(street: '123 Main St', city: 'Anytown', zipCode: '12345');
  var originalPerson = Person(
    name: 'John Doe',
    age: 30,
    address: address,
    hobbies: ['reading', 'swimming'],
  );
  
  var shallowClone = originalPerson.shallowClone();
  var deepClone = originalPerson.deepClone();
  
  print('Original: $originalPerson');
  
  // Modify shallow clone
  shallowClone.name = 'John Smith';
  shallowClone.address.street = '456 Oak Ave'; // This affects original!
  shallowClone.hobbies.add('cycling'); // This affects original!
  
  // Modify deep clone
  deepClone.name = 'John Johnson';
  deepClone.address.street = '789 Pine Rd'; // This doesn't affect original
  deepClone.hobbies.add('hiking'); // This doesn't affect original
  
  print('After shallow clone modification:');
  print('Original: $originalPerson');
  print('Shallow Clone: $shallowClone');
  print('Deep Clone: $deepClone');
  print('');
  
  // Example 2: Immutable Object with copyWith
  print('2. Immutable Object Cloning:');
  var person = ImmutablePerson(
    name: 'Jane Doe',
    age: 25,
    email: 'jane@example.com',
    skills: ['Dart', 'Flutter', 'JavaScript'],
  );
  
  var modifiedPerson = person.copyWith(
    age: 26,
    skills: [...person.skills, 'Python'],
  );
  
  var clonedPerson = person.clone();
  
  print('Original: $person');
  print('Modified: $modifiedPerson');
  print('Cloned: $clonedPerson');
  print('');
  
  // Example 3: Complex Object Cloning
  print('3. Complex Object Cloning:');
  var department = Department(name: 'Engineering', budget: '\$500,000');
  var employee = Employee(
    name: 'Alice Smith',
    position: 'Senior Developer',
    salary: 95000.0,
    department: department,
    projects: ['Project A', 'Project B'],
    metadata: {'level': 'senior', 'team': 'backend'},
  );
  
  var clonedEmployee = employee.deepClone();
  clonedEmployee.name = 'Alice Johnson';
  clonedEmployee.department.name = 'DevOps';
  clonedEmployee.projects.add('Project C');
  
  print('Original Employee: $employee');
  print('Cloned Employee: $clonedEmployee');
  print('');
  
  // Example 4: Product Variations using Cloning
  print('4. Product Variations:');
  var baseProduct = Product(
    name: 'Smartphone',
    price: 599.99,
    categories: ['Electronics', 'Mobile'],
    specifications: {'RAM': '8GB', 'Storage': '128GB'},
  );
  
  var proVersion = baseProduct.createVariation(
    newName: 'Smartphone Pro',
    newPrice: 899.99,
    additionalSpecs: {'RAM': '12GB', 'Storage': '256GB', 'Camera': '108MP'},
  );
  
  var liteVersion = baseProduct.createVariation(
    newName: 'Smartphone Lite',
    newPrice: 399.99,
    additionalSpecs: {'RAM': '6GB', 'Storage': '64GB'},
  );
  
  print('Base Product: $baseProduct');
  print('Pro Version: $proVersion');
  print('Lite Version: $liteVersion');
  print('');
  
  // Example 5: JSON-based Deep Cloning
  print('5. JSON-based Deep Cloning:');
  var user = User(
    id: 'user123',
    name: 'Bob Wilson',
    email: 'bob@example.com',
    preferences: {'theme': 'dark', 'language': 'en', 'notifications': true},
    roles: ['user', 'moderator'],
  );
  
  var clonedUser = user.deepClone();
  clonedUser.preferences['theme'] = 'light';
  clonedUser.roles.add('admin');
  
  print('Original User: $user');
  print('Cloned User: $clonedUser');
  print('');
  
  // Example 6: State Management with Cloning
  print('6. State Management with Cloning:');
  var initialState = AppState(
    currentUser: 'user123',
    notifications: ['Welcome!'],
    features: {'dark_mode': false, 'beta_features': true},
    sessionTimeout: 3600,
  );
  
  print('Initial State: $initialState');
  
  var state1 = initialState.addNotification('New message received');
  print('After adding notification: $state1');
  
  var state2 = state1.toggleFeature('dark_mode');
  print('After toggling dark mode: $state2');
  
  var state3 = state2.updateUser('admin456');
  print('After updating user: $state3');
  
  // Original state remains unchanged
  print('Original state unchanged: $initialState');
  
  print('\nCloning Best Practices:');
  print('- Use deep cloning when objects contain references to other objects');
  print('- Use shallow cloning for simple objects or when references should be shared');
  print('- Consider using copyWith for immutable objects');
  print('- JSON serialization can be used for complex deep cloning');
  print('- Cloning is essential for state management and data integrity');
}