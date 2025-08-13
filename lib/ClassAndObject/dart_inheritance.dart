void main() {
  print("=== DART INHERITANCE EXPLAINED ===\n");

  print("1. Basic Inheritance:");
  Dog dog = Dog("Buddy", "Golden Retriever");
  dog.displayInfo();
  dog.makeSound();
  dog.fetch();
  print("");

  print("2. Method Overriding:");
  Cat cat = Cat("Whiskers", "Persian");
  cat.displayInfo();
  cat.makeSound();
  cat.climb();
  print("");

  print("3. Super Keyword Usage:");
  ElectricCar tesla = ElectricCar("Tesla", "Model S", 100);
  tesla.displayInfo();
  tesla.startEngine();
  tesla.charge();
  print("");

  print("4. Abstract Classes:");
  List<Shape> shapes = [
    CircleShape(5),
    RectangleShape(10, 6),
    TriangleShape(8, 12)
  ];
  
  for (Shape shape in shapes) {
    print("${shape.runtimeType}:");
    print("Area: ${shape.calculateArea()}");
    print("Perimeter: ${shape.calculatePerimeter()}");
    shape.draw();
    print("");
  }

  print("5. Multilevel Inheritance:");
  SmartPhone phone = SmartPhone("iPhone", "Apple", "iOS");
  phone.displayInfo();
  phone.makeCall("123-456-7890");
  phone.connectToInternet();
  phone.installApp("WhatsApp");
  print("");

  print("6. Interface Implementation:");
  FlyingCar flyingCar = FlyingCar("SkyRider", "FutureTech");
  flyingCar.displayInfo();
  flyingCar.startEngine();
  flyingCar.takeOff();
  flyingCar.land();
  print("");

  print("7. Mixin Usage:");
  SwimmingDuck duck = SwimmingDuck("Donald");
  duck.displayInfo();
  duck.fly();
  duck.swim();
}

class Animal {
  String name;
  String species;

  Animal(this.name, this.species);

  void displayInfo() {
    print("Name: $name, Species: $species");
  }

  void makeSound() {
    print("$name makes a sound");
  }

  void eat() {
    print("$name is eating");
  }
}

class Dog extends Animal {
  String breed;

  Dog(String name, this.breed) : super(name, "Canine");

  @override
  void makeSound() {
    print("$name barks: Woof! Woof!");
  }

  void fetch() {
    print("$name is fetching the ball");
  }

  @override
  void displayInfo() {
    super.displayInfo();
    print("Breed: $breed");
  }
}

class Cat extends Animal {
  String breed;

  Cat(String name, this.breed) : super(name, "Feline");

  @override
  void makeSound() {
    print("$name meows: Meow! Meow!");
  }

  void climb() {
    print("$name is climbing the tree");
  }

  @override
  void displayInfo() {
    super.displayInfo();
    print("Breed: $breed");
  }
}

class Vehicle {
  String brand;
  String model;

  Vehicle(this.brand, this.model);

  void displayInfo() {
    print("Vehicle: $brand $model");
  }

  void startEngine() {
    print("$brand $model engine started");
  }
}

class Car extends Vehicle {
  Car(String brand, String model) : super(brand, model);

  @override
  void startEngine() {
    print("$brand $model car engine started with a roar!");
  }
}

class ElectricCar extends Car {
  int batteryCapacity;

  ElectricCar(String brand, String model, this.batteryCapacity) 
      : super(brand, model);

  @override
  void startEngine() {
    print("$brand $model electric motor started silently");
    super.startEngine();
  }

  @override
  void displayInfo() {
    super.displayInfo();
    print("Battery Capacity: ${batteryCapacity}kWh");
  }

  void charge() {
    print("$brand $model is charging...");
  }
}

abstract class Shape {
  String color;

  Shape(this.color);

  double calculateArea();
  double calculatePerimeter();

  void draw() {
    print("Drawing a $color ${runtimeType.toString().toLowerCase()}");
  }
}

class CircleShape extends Shape {
  double radius;

  CircleShape(this.radius) : super("Red");

  @override
  double calculateArea() {
    return 3.14159 * radius * radius;
  }

  @override
  double calculatePerimeter() {
    return 2 * 3.14159 * radius;
  }
}

class RectangleShape extends Shape {
  double width;
  double height;

  RectangleShape(this.width, this.height) : super("Blue");

  @override
  double calculateArea() {
    return width * height;
  }

  @override
  double calculatePerimeter() {
    return 2 * (width + height);
  }
}

class TriangleShape extends Shape {
  double base;
  double height;

  TriangleShape(this.base, this.height) : super("Green");

  @override
  double calculateArea() {
    return 0.5 * base * height;
  }

  @override
  double calculatePerimeter() {
    double side = (base * base + height * height) / (2 * base);
    return base + 2 * side;
  }
}

class Device {
  String name;
  String manufacturer;

  Device(this.name, this.manufacturer);

  void displayInfo() {
    print("Device: $name by $manufacturer");
  }
}

class Phone extends Device {
  Phone(String name, String manufacturer) : super(name, manufacturer);

  void makeCall(String number) {
    print("Calling $number from $name");
  }

  void sendMessage(String message, String to) {
    print("Sending '$message' to $to from $name");
  }
}

class SmartPhone extends Phone {
  String operatingSystem;

  SmartPhone(String name, String manufacturer, this.operatingSystem) 
      : super(name, manufacturer);

  @override
  void displayInfo() {
    super.displayInfo();
    print("Operating System: $operatingSystem");
  }

  void connectToInternet() {
    print("$name connected to internet");
  }

  void installApp(String appName) {
    print("Installing $appName on $name");
  }
}

abstract class Flyable {
  void takeOff();
  void land();
  void fly() {
    print("Flying in the sky");
  }
}

abstract class Drivable {
  void startEngine();
  void stopEngine() {
    print("Engine stopped");
  }
}

class FlyingCar extends Vehicle implements Flyable, Drivable {
  FlyingCar(String brand, String model) : super(brand, model);

  @override
  void takeOff() {
    print("$brand $model taking off into the sky");
  }

  @override
  void land() {
    print("$brand $model landing safely");
  }

  @override
  void startEngine() {
    print("$brand $model hybrid engine started");
  }
  
  @override
  void fly() {
    
  }
  
  @override
  void stopEngine() {
    
  }
}

mixin Flying {
  void fly() {
    print("Flying through the air");
  }

  void takeOff() {
    print("Taking off...");
  }

  void land() {
    print("Landing...");
  }
}

mixin Swimming {
  void swim() {
    print("Swimming in water");
  }

  void dive() {
    print("Diving underwater");
  }
}

class Bird extends Animal {
  Bird(String name) : super(name, "Avian");
}

class SwimmingDuck extends Bird with Flying, Swimming {
  SwimmingDuck(String name) : super(name);

  @override
  void makeSound() {
    print("$name quacks: Quack! Quack!");
  }
}