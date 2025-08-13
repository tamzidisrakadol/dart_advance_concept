void main() {
  print("=== WHY WE NEED SUPER KEYWORD IN INHERITANCE ===\n");

  print("1. Problem without super - Constructor chaining:");
  print("Without super, child constructor cannot call parent constructor properly\n");

  print("2. Accessing parent class constructor:");
  Student student = Student("Alice", 20, "Computer Science", "S12345");
  student.displayInfo();
  print("");

  print("3. Calling parent methods from overridden methods:");
  Manager manager = Manager("Bob", 35, 75000, "Engineering");
  manager.work();
  print("");

  print("4. Accessing parent properties when overridden:");
  SportsCar car = SportsCar("Ferrari", "F8", 340);
  car.displaySpecs();
  print("");

  print("5. Super in method overriding - extending functionality:");
  Rectangle rect = Rectangle(10, 5);
  rect.displayArea();
  print("");
  
  Square square = Square(8);
  square.displayArea();
  print("");

  print("6. Super with getter/setter inheritance:");
  BankAccount account = BankAccount("12345", 1000);
  print("Initial balance: \$${account.balance}");
  
  SavingsAccount savings = SavingsAccount("67890", 2000, 0.05);
  print("Savings balance: \$${savings.balance}");
  print("Interest earned: \$${savings.calculateInterest()}");
  print("");

  print("7. Complex inheritance chain:");
  Smartphone phone = Smartphone("iPhone", "Apple", "iOS", "Pro Max");
  phone.displayFullInfo();
}

class Person {
  String name;
  int age;

  Person(this.name, this.age) {
    print("Person constructor called for $name");
  }

  void displayInfo() {
    print("Name: $name, Age: $age");
  }

  void work() {
    print("$name is working");
  }
}

class Student extends Person {
  String major;
  String studentId;

  Student(String name, int age, this.major, this.studentId) : super(name, age) {
    print("Student constructor called for $name");
  }

  @override
  void displayInfo() {
    super.displayInfo();
    print("Major: $major, Student ID: $studentId");
  }
}

class Employee extends Person {
  double salary;

  Employee(String name, int age, this.salary) : super(name, age) {
    print("Employee constructor called for $name");
  }

  @override
  void displayInfo() {
    super.displayInfo();
    print("Salary: \$${salary.toStringAsFixed(2)}");
  }

  @override
  void work() {
    super.work();
    print("$name is completing assigned tasks");
  }
}

class Manager extends Employee {
  String department;

  Manager(String name, int age, double salary, this.department) 
      : super(name, age, salary) {
    print("Manager constructor called for $name");
  }

  @override
  void work() {
    super.work();
    print("$name is managing the $department department");
  }

  @override
  void displayInfo() {
    super.displayInfo();
    print("Department: $department");
  }
}

class Vehicle {
  String brand;
  String model;

  Vehicle(this.brand, this.model);

  void displaySpecs() {
    print("Vehicle: $brand $model");
  }
}

class Car extends Vehicle {
  Car(String brand, String model) : super(brand, model);

  @override
  void displaySpecs() {
    super.displaySpecs();
    print("Type: Car");
  }
}

class SportsCar extends Car {
  int topSpeed;

  SportsCar(String brand, String model, this.topSpeed) 
      : super(brand, model);

  @override
  void displaySpecs() {
    super.displaySpecs();
    print("Type: Sports Car");
    print("Top Speed: ${topSpeed} km/h");
  }
}

class Shape {
  double width;
  double height;

  Shape(this.width, this.height);

  double calculateArea() {
    return width * height;
  }

  void displayArea() {
    print("Area of ${runtimeType}: ${calculateArea()}");
  }
}

class Rectangle extends Shape {
  Rectangle(double width, double height) : super(width, height);

  @override
  void displayArea() {
    print("Rectangle dimensions: ${width} x ${height}");
    super.displayArea();
  }
}

class Square extends Rectangle {
  Square(double side) : super(side, side);

  @override
  void displayArea() {
    print("Square side length: $width");
    super.displayArea();
  }
}

class BankAccount {
  String accountNumber;
  double _balance;

  BankAccount(this.accountNumber, this._balance);

  double get balance => _balance;

  set balance(double value) {
    if (value >= 0) {
      _balance = value;
    }
  }

  void deposit(double amount) {
    if (amount > 0) {
      _balance += amount;
    }
  }
}

class SavingsAccount extends BankAccount {
  double interestRate;

  SavingsAccount(String accountNumber, double balance, this.interestRate) 
      : super(accountNumber, balance);

  @override
  double get balance {
    return super.balance;
  }

  @override
  set balance(double value) {
    super.balance = value;
    print("Savings account balance updated to: \$${value}");
  }

  double calculateInterest() {
    return super.balance * interestRate;
  }
}

class Device {
  String name;
  String manufacturer;

  Device(this.name, this.manufacturer) {
    print("Device created: $name by $manufacturer");
  }

  void displayInfo() {
    print("Device: $name");
    print("Manufacturer: $manufacturer");
  }
}

class Phone extends Device {
  String operatingSystem;

  Phone(String name, String manufacturer, this.operatingSystem) 
      : super(name, manufacturer) {
    print("Phone features initialized");
  }

  @override
  void displayInfo() {
    super.displayInfo();
    print("OS: $operatingSystem");
  }

  void makeCall() {
    print("Making a call from $name");
  }
}

class Smartphone extends Phone {
  String model;

  Smartphone(String name, String manufacturer, String os, this.model) 
      : super(name, manufacturer, os) {
    print("Smartphone advanced features initialized");
  }

  @override
  void displayInfo() {
    super.displayInfo();
    print("Model: $model");
  }

  void displayFullInfo() {
    print("=== Complete Device Information ===");
    super.displayInfo();
    print("Advanced Features: Touchscreen, Apps, Internet");
  }

  void installApp(String appName) {
    print("Installing $appName on $name $model");
  }
}