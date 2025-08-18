/*
IMMUTABLE CLASS

What is it?
An immutable class is a class whose instances cannot be modified after creation.
Once an object is created, all its fields remain constant throughout its lifetime.
This ensures thread safety, predictable behavior, and easier debugging.

How to use it?
- Mark all fields as final
- Don't provide setter methods
- Don't allow modification of mutable fields
- Initialize all fields through constructor
- Use copyWith methods to create modified versions
- Make defensive copies of mutable parameters

Where to use it?
- State management in applications (Redux, BLoC patterns)
- Data transfer objects (DTOs)
- Configuration objects
- Value objects that represent concepts like Money, Date, etc.
- When you need thread safety
- When you want to ensure data integrity
- When working with functional programming concepts
*/

// Example 1: Basic Immutable Class
class ImmutablePoint {
  final double x;
  final double y;
  
  const ImmutablePoint(this.x, this.y);
  
  // Named constructor
  const ImmutablePoint.origin() : x = 0, y = 0;
  
  // Method that returns new instance instead of modifying current one
  ImmutablePoint translate(double dx, double dy) {
    return ImmutablePoint(x + dx, y + dy);
  }
  
  ImmutablePoint scale(double factor) {
    return ImmutablePoint(x * factor, y * factor);
  }
  
  double distanceFromOrigin() {
    return (x * x + y * y) / 2; // Simplified distance calculation
  }
  
  @override
  String toString() => 'Point($x, $y)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ImmutablePoint && other.x == x && other.y == y;
  }
  
  @override
  int get hashCode => x.hashCode ^ y.hashCode;
}

// Example 2: Immutable Person with copyWith
class ImmutablePerson {
  final String firstName;
  final String lastName;
  final int age;
  final String email;
  final List<String> hobbies; // Immutable list
  
  const ImmutablePerson({
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.email,
    required this.hobbies,
  });
  
  // Full name getter
  String get fullName => '$firstName $lastName';
  
  // Copy with method for creating modified versions
  ImmutablePerson copyWith({
    String? firstName,
    String? lastName,
    int? age,
    String? email,
    List<String>? hobbies,
  }) {
    return ImmutablePerson(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      age: age ?? this.age,
      email: email ?? this.email,
      hobbies: hobbies ?? this.hobbies,
    );
  }
  
  // Methods that return new instances
  ImmutablePerson addHobby(String hobby) {
    return copyWith(hobbies: [...hobbies, hobby]);
  }
  
  ImmutablePerson removeHobby(String hobby) {
    return copyWith(hobbies: hobbies.where((h) => h != hobby).toList());
  }
  
  ImmutablePerson haveBirthday() {
    return copyWith(age: age + 1);
  }
  
  @override
  String toString() {
    return 'Person($fullName, $age, $email, hobbies: $hobbies)';
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ImmutablePerson &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.age == age &&
        other.email == email &&
        _listEquals(other.hobbies, hobbies);
  }
  
  @override
  int get hashCode {
    return firstName.hashCode ^
        lastName.hashCode ^
        age.hashCode ^
        email.hashCode ^
        hobbies.hashCode;
  }
  
  bool _listEquals(List<String> a, List<String> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}

// Example 3: Immutable Money Class
class Money {
  final double amount;
  final String currency;
  
  const Money(this.amount, this.currency);
  
  // Named constructors for common currencies
  const Money.usd(double amount) : this(amount, 'USD');
  const Money.eur(double amount) : this(amount, 'EUR');
  const Money.gbp(double amount) : this(amount, 'GBP');
  
  // Zero money
  const Money.zero(String currency) : this(0.0, currency);
  
  // Arithmetic operations that return new instances
  Money add(Money other) {
    if (currency != other.currency) {
      throw ArgumentError('Cannot add different currencies');
    }
    return Money(amount + other.amount, currency);
  }
  
  Money subtract(Money other) {
    if (currency != other.currency) {
      throw ArgumentError('Cannot subtract different currencies');
    }
    return Money(amount - other.amount, currency);
  }
  
  Money multiply(double factor) {
    return Money(amount * factor, currency);
  }
  
  Money divide(double divisor) {
    if (divisor == 0) throw ArgumentError('Cannot divide by zero');
    return Money(amount / divisor, currency);
  }
  
  // Comparison methods
  bool isGreaterThan(Money other) {
    if (currency != other.currency) {
      throw ArgumentError('Cannot compare different currencies');
    }
    return amount > other.amount;
  }
  
  bool isLessThan(Money other) {
    if (currency != other.currency) {
      throw ArgumentError('Cannot compare different currencies');
    }
    return amount < other.amount;
  }
  
  bool get isPositive => amount > 0;
  bool get isNegative => amount < 0;
  bool get isZero => amount == 0;
  
  @override
  String toString() => '$currency ${amount.toStringAsFixed(2)}';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Money && other.amount == amount && other.currency == currency;
  }
  
  @override
  int get hashCode => amount.hashCode ^ currency.hashCode;
}

// Example 4: Immutable Configuration Class
class DatabaseConfig {
  final String host;
  final int port;
  final String database;
  final String username;
  final String password;
  final int maxConnections;
  final Duration connectionTimeout;
  final bool useSSL;
  final Map<String, String> additionalParams;
  
  const DatabaseConfig({
    required this.host,
    required this.port,
    required this.database,
    required this.username,
    required this.password,
    this.maxConnections = 10,
    this.connectionTimeout = const Duration(seconds: 30),
    this.useSSL = true,
    this.additionalParams = const {},
  });
  
  // Named constructor for development
  const DatabaseConfig.development()
      : host = 'localhost',
        port = 5432,
        database = 'dev_db',
        username = 'dev_user',
        password = 'dev_password',
        maxConnections = 5,
        connectionTimeout = const Duration(seconds: 10),
        useSSL = false,
        additionalParams = const {};
  
  // Named constructor for production
  const DatabaseConfig.production({
    required String host,
    required String database,
    required String username,
    required String password,
  }) : this(
          host: host,
          port: 5432,
          database: database,
          username: username,
          password: password,
          maxConnections: 50,
          connectionTimeout: const Duration(seconds: 60),
          useSSL: true,
          additionalParams: const {'sslmode': 'require'},
        );
  
  String get connectionString {
    var params = <String>[
      'host=$host',
      'port=$port',
      'dbname=$database',
      'user=$username',
      if (useSSL) 'sslmode=require',
      ...additionalParams.entries.map((e) => '${e.key}=${e.value}'),
    ];
    return params.join(' ');
  }
  
  DatabaseConfig copyWith({
    String? host,
    int? port,
    String? database,
    String? username,
    String? password,
    int? maxConnections,
    Duration? connectionTimeout,
    bool? useSSL,
    Map<String, String>? additionalParams,
  }) {
    return DatabaseConfig(
      host: host ?? this.host,
      port: port ?? this.port,
      database: database ?? this.database,
      username: username ?? this.username,
      password: password ?? this.password,
      maxConnections: maxConnections ?? this.maxConnections,
      connectionTimeout: connectionTimeout ?? this.connectionTimeout,
      useSSL: useSSL ?? this.useSSL,
      additionalParams: additionalParams ?? this.additionalParams,
    );
  }
  
  @override
  String toString() {
    return 'DatabaseConfig(host: $host, port: $port, database: $database, '
        'maxConnections: $maxConnections, useSSL: $useSSL)';
  }
}

// Example 5: Immutable Address with Validation
class Address {
  final String street;
  final String city;
  final String state;
  final String zipCode;
  final String country;
  
  const Address._({
    required this.street,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.country,
  });
  
  // Factory constructor with validation
  factory Address({
    required String street,
    required String city,
    required String state,
    required String zipCode,
    String country = 'USA',
  }) {
    if (street.trim().isEmpty) throw ArgumentError('Street cannot be empty');
    if (city.trim().isEmpty) throw ArgumentError('City cannot be empty');
    if (state.trim().isEmpty) throw ArgumentError('State cannot be empty');
    if (zipCode.trim().isEmpty) throw ArgumentError('Zip code cannot be empty');
    if (!RegExp(r'^\d{5}(-\d{4})?$').hasMatch(zipCode)) {
      throw ArgumentError('Invalid zip code format');
    }
    
    return Address._(
      street: street.trim(),
      city: city.trim(),
      state: state.trim().toUpperCase(),
      zipCode: zipCode.trim(),
      country: country.trim().toUpperCase(),
    );
  }
  
  String get fullAddress => '$street, $city, $state $zipCode, $country';
  
  Address copyWith({
    String? street,
    String? city,
    String? state,
    String? zipCode,
    String? country,
  }) {
    return Address(
      street: street ?? this.street,
      city: city ?? this.city,
      state: state ?? this.state,
      zipCode: zipCode ?? this.zipCode,
      country: country ?? this.country,
    );
  }
  
  @override
  String toString() => fullAddress;
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Address &&
        other.street == street &&
        other.city == city &&
        other.state == state &&
        other.zipCode == zipCode &&
        other.country == country;
  }
  
  @override
  int get hashCode {
    return street.hashCode ^
        city.hashCode ^
        state.hashCode ^
        zipCode.hashCode ^
        country.hashCode;
  }
}

// Example 6: Immutable Shopping Cart Item
class CartItem {
  final String productId;
  final String productName;
  final double unitPrice;
  final int quantity;
  final double discount;
  
  const CartItem({
    required this.productId,
    required this.productName,
    required this.unitPrice,
    required this.quantity,
    this.discount = 0.0,
  });
  
  double get subtotal => unitPrice * quantity;
  double get discountAmount => subtotal * (discount / 100);
  double get total => subtotal - discountAmount;
  
  CartItem updateQuantity(int newQuantity) {
    if (newQuantity < 0) throw ArgumentError('Quantity cannot be negative');
    return CartItem(
      productId: productId,
      productName: productName,
      unitPrice: unitPrice,
      quantity: newQuantity,
      discount: discount,
    );
  }
  
  CartItem applyDiscount(double discountPercentage) {
    if (discountPercentage < 0 || discountPercentage > 100) {
      throw ArgumentError('Discount must be between 0 and 100');
    }
    return CartItem(
      productId: productId,
      productName: productName,
      unitPrice: unitPrice,
      quantity: quantity,
      discount: discountPercentage,
    );
  }
  
  @override
  String toString() {
    return 'CartItem($productName x$quantity @ \$${unitPrice.toStringAsFixed(2)} '
        '${discount > 0 ? '(${discount.toStringAsFixed(1)}% off)' : ''} = \$${total.toStringAsFixed(2)})';
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CartItem &&
        other.productId == productId &&
        other.productName == productName &&
        other.unitPrice == unitPrice &&
        other.quantity == quantity &&
        other.discount == discount;
  }
  
  @override
  int get hashCode {
    return productId.hashCode ^
        productName.hashCode ^
        unitPrice.hashCode ^
        quantity.hashCode ^
        discount.hashCode;
  }
}

void main() {
  print('=== Immutable Class Examples ===\n');
  
  // Example 1: Immutable Point
  print('1. Immutable Point:');
  var point1 = ImmutablePoint(3, 4);
  var point2 = point1.translate(2, 1);
  var point3 = point1.scale(2);
  
  print('Original point: $point1');
  print('Translated point: $point2');
  print('Scaled point: $point3');
  print('Original unchanged: $point1');
  print('Distance from origin: ${point1.distanceFromOrigin()}');
  print('');
  
  // Example 2: Immutable Person
  print('2. Immutable Person:');
  var person = ImmutablePerson(
    firstName: 'John',
    lastName: 'Doe',
    age: 30,
    email: 'john@example.com',
    hobbies: const ['reading', 'swimming'],
  );
  
  var olderPerson = person.haveBirthday();
  var hobbyPerson = person.addHobby('cycling');
  var updatedPerson = person.copyWith(email: 'john.doe@newcompany.com');
  
  print('Original: $person');
  print('After birthday: $olderPerson');
  print('With new hobby: $hobbyPerson');
  print('With new email: $updatedPerson');
  print('');
  
  // Example 3: Money Operations
  print('3. Immutable Money:');
  var price1 = Money.usd(99.99);
  var price2 = Money.usd(49.99);
  var tax = Money.usd(7.50);
  
  var subtotal = price1.add(price2);
  var total = subtotal.add(tax);
  var discounted = total.multiply(0.9); // 10% discount
  
  print('Price 1: $price1');
  print('Price 2: $price2');
  print('Tax: $tax');
  print('Subtotal: $subtotal');
  print('Total: $total');
  print('After 10% discount: $discounted');
  print('Is total greater than \$100? ${total.isGreaterThan(Money.usd(100))}');
  print('');
  
  // Example 4: Database Configuration
  print('4. Immutable Database Configuration:');
  var devConfig = DatabaseConfig.development();
  var prodConfig = DatabaseConfig.production(
    host: 'prod-db.company.com',
    database: 'production_db',
    username: 'prod_user',
    password: 'secure_password',
  );
  
  var customConfig = devConfig.copyWith(
    maxConnections: 20,
    useSSL: true,
  );
  
  print('Development Config: $devConfig');
  print('Production Config: $prodConfig');
  print('Custom Config: $customConfig');
  print('Prod Connection String: ${prodConfig.connectionString}');
  print('');
  
  // Example 5: Address Validation
  print('5. Immutable Address with Validation:');
  try {
    var address1 = Address(
      street: '123 Main Street',
      city: 'Anytown',
      state: 'ca',
      zipCode: '90210',
    );
    
    var address2 = address1.copyWith(
      street: '456 Oak Avenue',
      zipCode: '90211-1234',
    );
    
    print('Address 1: $address1');
    print('Address 2: $address2');
    
    // This will throw an error
    Address(
      street: '',
      city: 'Invalid',
      state: 'XX',
      zipCode: 'invalid',
    );
  } catch (e) {
    print('Validation error: $e');
  }
  print('');
  
  // Example 6: Shopping Cart Items
  print('6. Immutable Shopping Cart Items:');
  var item1 = CartItem(
    productId: 'LAPTOP-001',
    productName: 'Gaming Laptop',
    unitPrice: 1299.99,
    quantity: 1,
  );
  
  var item2 = item1.updateQuantity(2);
  var item3 = item2.applyDiscount(15.0); // 15% discount
  
  print('Original item: $item1');
  print('Updated quantity: $item2');
  print('With discount: $item3');
  
  // Create a list of items
  var cartItems = [
    CartItem(
      productId: 'MOUSE-001',
      productName: 'Wireless Mouse',
      unitPrice: 29.99,
      quantity: 2,
    ),
    CartItem(
      productId: 'KEYBOARD-001',
      productName: 'Mechanical Keyboard',
      unitPrice: 149.99,
      quantity: 1,
      discount: 10.0,
    ),
  ];
  
  var cartTotal = cartItems.fold(0.0, (sum, item) => sum + item.total);
  print('\nCart Items:');
  for (var item in cartItems) {
    print('  $item');
  }
  print('Cart Total: \$${cartTotal.toStringAsFixed(2)}');
  
  print('\nImmutable Class Benefits:');
  print('- Thread safety without synchronization');
  print('- Predictable behavior and easier debugging');
  print('- Safe to use as keys in Maps and Sets');
  print('- Prevents accidental state modifications');
  print('- Enables functional programming patterns');
  print('- Better caching and optimization opportunities');
}