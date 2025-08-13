void main() {
  print("=== DART CONSTRUCTORS EXPLAINED ===\n");

  print("1. Default Constructor:");
  Car car1 = Car();
  car1.displayInfo();
  print("");

  print("2. Parameterized Constructor:");
  Car car2 = Car.withParameters("Toyota", "Camry", 2022);
  car2.displayInfo();
  print("");

  print("3. Named Constructor:");
  Car car3 = Car.electric("Tesla", "Model 3");
  car3.displayInfo();
  print("");

  print("4. Constructor with Optional Parameters:");
  Car car4 = Car.flexible("Honda", model: "Civic");
  car4.displayInfo();
  print("");

  print("5. Constant Constructor:");
  Point p1 = const Point(10, 20);
  Point p2 = const Point(10, 20);
  print("Points are identical: ${identical(p1, p2)}");
  print("");

  print("6. Factory Constructor:");
  DatabaseConnection db1 = DatabaseConnection.getInstance();
  DatabaseConnection db2 = DatabaseConnection.getInstance();
  print("Database connections are same: ${identical(db1, db2)}");
  print("");

  print("7. Constructor with Initializer List:");
  Circle circle = Circle(5);
  print("Circle area: ${circle.area}");
}

class Car {
  String? brand;
  String? model;
  int? year;
  String? type;

  Car() {
    print("Default constructor called");
    brand = "Unknown";
    model = "Unknown";
    year = 0;
    type = "Regular";
  }

  Car.withParameters(this.brand, this.model, this.year) {
    type = "Regular";
    print("Parameterized constructor called");
  }

  Car.electric(this.brand, this.model) {
    type = "Electric";
    year = DateTime.now().year;
    print("Named constructor for electric car called");
  }

  Car.flexible(this.brand, {this.model, this.year}) {
    type = "Flexible";
    model ??= "Default Model";
    year ??= DateTime.now().year;
    print("Constructor with optional parameters called");
  }

  void displayInfo() {
    print("Brand: $brand, Model: $model, Year: $year, Type: $type");
  }
}

class Point {
  final int x;
  final int y;

  const Point(this.x, this.y);

  @override
  String toString() => 'Point($x, $y)';
}

class DatabaseConnection {
  static DatabaseConnection? _instance;

  DatabaseConnection._internal();

  factory DatabaseConnection.getInstance() {
    _instance ??= DatabaseConnection._internal();
    return _instance!;
  }

  void connect() {
    print("Connected to database");
  }
}

class Circle {
  final double radius;
  late final double area;

  Circle(this.radius) : area = 3.14159 * radius * radius {
    print("Circle created with radius: $radius");
  }
}