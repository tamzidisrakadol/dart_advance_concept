void main() {
  print("=== DART GETTERS AND SETTERS EXPLAINED ===\n");

  print("1. Basic Getter and Setter:");
  Person person = Person();
  person.name = "John Doe";
  person.age = 25;
  print("Name: ${person.name}");
  print("Age: ${person.age}");
  print("Is Adult: ${person.isAdult}");
  print("");

  print("2. Validation in Setter:");
  try {
    person.age = -5;
  } catch (e) {
    print("Error: $e");
  }
  print("");

  print("3. Computed Property (Getter only):");
  Rectangle rect = Rectangle(10, 5);
  print("Width: ${rect.width}");
  print("Height: ${rect.height}");
  print("Area: ${rect.area}");
  print("Perimeter: ${rect.perimeter}");
  print("");

  print("4. Private Variables with Getters/Setters:");
  BankAccount account = BankAccount("123456");
  print("Account Number: ${account.accountNumber}");
  account.deposit(1000);
  print("Balance: \$${account.balance}");
  account.withdraw(200);
  print("Balance after withdrawal: \$${account.balance}");
  print("");

  print("5. Setter with Data Transformation:");
  Product product = Product();
  product.name = "  laptop computer  ";
  product.price = 999.99;
  print("Product: ${product.name}");
  print("Price: \$${product.price}");
  print("Formatted Price: ${product.formattedPrice}");
  print("");

  print("6. Complex Getter/Setter Logic:");
  Temperature temp = Temperature();
  temp.celsius = 25;
  print("Celsius: ${temp.celsius}°C");
  print("Fahrenheit: ${temp.fahrenheit}°F");
  temp.fahrenheit = 86;
  print("After setting Fahrenheit to 86°F:");
  print("Celsius: ${temp.celsius}°C");
  print("Fahrenheit: ${temp.fahrenheit}°F");
}

class Person {
  String? _name;
  int? _age;

  String? get name => _name;
  
  set name(String? value) {
    if (value == null || value.isEmpty) {
      throw ArgumentError("Name cannot be null or empty");
    }
    _name = value.trim();
  }

  int? get age => _age;
  
  set age(int? value) {
    if (value == null || value < 0) {
      throw ArgumentError("Age cannot be negative or null");
    }
    if (value > 150) {
      throw ArgumentError("Age cannot be more than 150");
    }
    _age = value;
  }

  bool get isAdult => _age != null && _age! >= 18;
}

class Rectangle {
  final double width;
  final double height;

  Rectangle(this.width, this.height);

  double get area => width * height;
  
  double get perimeter => 2 * (width + height);
}

class BankAccount {
  final String _accountNumber;
  double _balance = 0;

  BankAccount(this._accountNumber);

  String get accountNumber => _accountNumber;
  
  double get balance => _balance;

  void deposit(double amount) {
    if (amount <= 0) {
      throw ArgumentError("Deposit amount must be positive");
    }
    _balance += amount;
  }

  void withdraw(double amount) {
    if (amount <= 0) {
      throw ArgumentError("Withdrawal amount must be positive");
    }
    if (amount > _balance) {
      throw ArgumentError("Insufficient funds");
    }
    _balance -= amount;
  }
}

class Product {
  String? _name;
  double? _price;

  String? get name => _name;
  
  set name(String? value) {
    if (value != null) {
      _name = value.trim().toLowerCase();
    }
  }

  double? get price => _price;
  
  set price(double? value) {
    if (value != null && value >= 0) {
      _price = value;
    }
  }

  String get formattedPrice {
    if (_price == null) return "Price not set";
    return "\$${_price!.toStringAsFixed(2)}";
  }
}

class Temperature {
  double _celsius = 0;

  double get celsius => _celsius;
  
  set celsius(double value) {
    _celsius = value;
  }

  double get fahrenheit => (_celsius * 9 / 5) + 32;
  
  set fahrenheit(double value) {
    _celsius = (value - 32) * 5 / 9;
  }

  double get kelvin => _celsius + 273.15;
  
  set kelvin(double value) {
    _celsius = value - 273.15;
  }
}