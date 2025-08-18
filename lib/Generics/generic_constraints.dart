void main() {
  print("=== GENERIC CONSTRAINTS (BOUNDED GENERICS) ===\n");

  print("What are Generic Constraints?");
  print("Constraints limit which types can be used as generic parameters.");
  print("This ensures type safety while providing specific functionality.\n");

  print("1. Basic Type Constraints (extends):");
  
  NumberProcessor<int> intProcessor = NumberProcessor<int>();
  NumberProcessor<double> doubleProcessor = NumberProcessor<double>();
  
  print("Processing integers:");
  print("Sum: ${intProcessor.sum([1, 2, 3, 4, 5])}");
  print("Max: ${intProcessor.findMax([10, 5, 8, 15, 3])}");
  
  print("\nProcessing doubles:");
  print("Sum: ${doubleProcessor.sum([1.1, 2.2, 3.3])}");
  print("Max: ${doubleProcessor.findMax([3.14, 2.71, 1.41])}");
  print("");

  print("2. Comparable Constraint:");
  
  SortedList<int> sortedNumbers = SortedList<int>();
  sortedNumbers.addAll([5, 2, 8, 1, 9, 3]);
  print("Sorted numbers: ${sortedNumbers.getItems()}");
  
  SortedList<String> sortedWords = SortedList<String>();
  sortedWords.addAll(["zebra", "apple", "banana", "cherry"]);
  print("Sorted words: ${sortedWords.getItems()}");
  print("");

  print("3. Multiple Constraints:");
  
  SerializableCache<User> userCache = SerializableCache<User>();
  userCache.put("user1", User(1, "Alice"));
  userCache.put("user2", User(2, "Bob"));
  
  print("Cached users:");
  userCache.getAllKeys().forEach((key) {
    User? user = userCache.get(key);
    print("  $key: ${user?.toJson()}");
  });
  
  String serialized = userCache.serialize();
  print("Serialized cache: $serialized");
  print("");

  print("4. Abstract Class Constraints:");
  
  ShapeCalculator<Circle> circleCalc = ShapeCalculator<Circle>();
  ShapeCalculator<Rectangle> rectCalc = ShapeCalculator<Rectangle>();
  
  List<Circle> circles = [Circle(5), Circle(3), Circle(8)];
  List<Rectangle> rectangles = [Rectangle(4, 6), Rectangle(3, 5)];
  
  print("Total circle area: ${circleCalc.calculateTotalArea(circles)}");
  print("Average circle area: ${circleCalc.calculateAverageArea(circles)}");
  
  print("Total rectangle area: ${rectCalc.calculateTotalArea(rectangles)}");
  print("Average rectangle area: ${rectCalc.calculateAverageArea(rectangles)}");
  print("");

  print("5. Interface Constraints:");
  
  FlyableManager<Bird> birdManager = FlyableManager<Bird>();
  FlyableManager<Airplane> airplaneManager = FlyableManager<Airplane>();
  
  birdManager.add(Bird("Eagle"));
  birdManager.add(Bird("Hawk"));
  
  airplaneManager.add(Airplane("Boeing 747"));
  airplaneManager.add(Airplane("Airbus A380"));
  
  print("Making birds fly:");
  birdManager.makeAllFly();
  
  print("\nMaking airplanes fly:");
  airplaneManager.makeAllFly();
  print("");

  print("6. Generic Repository with Constraints:");
  
  EntityRepository<Product> productRepo = EntityRepository<Product>();
  productRepo.save(Product(1, "Laptop"));
  productRepo.save(Product(2, "Mouse"));
  
  Product? product = productRepo.findById(1);
  print("Found product: ${product?.name}");
  
  List<Product> allProducts = productRepo.findAll();
  print("All products: ${allProducts.map((p) => p.name).toList()}");
  print("");

  print("7. Constraint with Factory Constructor:");
  
  DataProcessor<ApiResponse> apiProcessor = DataProcessor<ApiResponse>();
  
  Map<String, dynamic> responseData = {
    'id': 1,
    'message': 'Success',
    'data': {'key': 'value'}
  };
  
  ApiResponse response = apiProcessor.createFromJson(responseData);
  print("Created API response: ${response.toJson()}");
  print("");

  print("8. Advanced Constraint Example - Event System:");
  
  TypedEventBus eventBus = TypedEventBus();
  
  eventBus.subscribe<UserLoginEvent>((event) {
    print("User logged in: ${event.userId} at ${event.timestamp}");
  });
  
  eventBus.subscribe<OrderCreatedEvent>((event) {
    print("Order created: ${event.orderId} for \$${event.amount}");
  });
  
  eventBus.publish(UserLoginEvent("user123", DateTime.now()));
  eventBus.publish(OrderCreatedEvent("order456", 99.99, DateTime.now()));
  print("");

  print("9. Constraint with Enum:");
  
  StatusManager<UserStatus> userStatusManager = StatusManager<UserStatus>();
  StatusManager<OrderStatus> orderStatusManager = StatusManager<OrderStatus>();
  
  userStatusManager.setStatus(UserStatus.active);
  orderStatusManager.setStatus(OrderStatus.processing);
  
  print("User status: ${userStatusManager.getCurrentStatus()}");
  print("Order status: ${orderStatusManager.getCurrentStatus()}");
  print("User status transitions: ${userStatusManager.getValidTransitions()}");
}

class NumberProcessor<T extends num> {
  T sum(List<T> numbers) {
    T total = numbers.first.runtimeType == int ? 0 as T : 0.0 as T;
    for (T number in numbers) {
      total = (total + number) as T;
    }
    return total;
  }

  T findMax(List<T> numbers) {
    if (numbers.isEmpty) throw ArgumentError("List cannot be empty");
    
    T max = numbers.first;
    for (T number in numbers) {
      if (number > max) max = number;
    }
    return max;
  }

  T findMin(List<T> numbers) {
    if (numbers.isEmpty) throw ArgumentError("List cannot be empty");
    
    T min = numbers.first;
    for (T number in numbers) {
      if (number < min) min = number;
    }
    return min;
  }

  double average(List<T> numbers) {
    if (numbers.isEmpty) return 0.0;
    return sum(numbers).toDouble() / numbers.length;
  }
}

class SortedList<T extends Comparable> {
  final List<T> _items = [];

  void add(T item) {
    _items.add(item);
    _items.sort();
  }

  void addAll(List<T> items) {
    _items.addAll(items);
    _items.sort();
  }

  bool remove(T item) {
    return _items.remove(item);
  }

  List<T> getItems() => List.from(_items);

  T? findClosest(T target) {
    if (_items.isEmpty) return null;
    
    T closest = _items.first;
    for (T item in _items) {
      if ((item.compareTo(target) - 0).abs() < (closest.compareTo(target) - 0).abs()) {
        closest = item;
      }
    }
    return closest;
  }
}

abstract class Serializable {
  Map<String, dynamic> toJson();
  static fromJson(Map<String, dynamic> json) => throw UnimplementedError();
}

class User implements Serializable {
  final int id;
  final String name;

  User(this.id, this.name);

  @override
  Map<String, dynamic> toJson() => {'id': id, 'name': name};

  static User fromJson(Map<String, dynamic> json) {
    return User(json['id'], json['name']);
  }
}

class SerializableCache<T extends Serializable> {
  final Map<String, T> _cache = {};

  void put(String key, T value) {
    _cache[key] = value;
  }

  T? get(String key) {
    return _cache[key];
  }

  List<String> getAllKeys() {
    return _cache.keys.toList();
  }

  String serialize() {
    Map<String, Map<String, dynamic>> serializedData = {};
    _cache.forEach((key, value) {
      serializedData[key] = value.toJson();
    });
    return serializedData.toString();
  }
}

abstract class Shape {
  double calculateArea();
  double calculatePerimeter();
}

class Circle extends Shape {
  final double radius;

  Circle(this.radius);

  @override
  double calculateArea() => 3.14159 * radius * radius;

  @override
  double calculatePerimeter() => 2 * 3.14159 * radius;
}

class Rectangle extends Shape {
  final double width;
  final double height;

  Rectangle(this.width, this.height);

  @override
  double calculateArea() => width * height;

  @override
  double calculatePerimeter() => 2 * (width + height);
}

class ShapeCalculator<T extends Shape> {
  double calculateTotalArea(List<T> shapes) {
    return shapes.fold(0.0, (sum, shape) => sum + shape.calculateArea());
  }

  double calculateAverageArea(List<T> shapes) {
    if (shapes.isEmpty) return 0.0;
    return calculateTotalArea(shapes) / shapes.length;
  }

  T findLargestByArea(List<T> shapes) {
    if (shapes.isEmpty) throw ArgumentError("List cannot be empty");
    
    return shapes.reduce((current, next) {
      return current.calculateArea() > next.calculateArea() ? current : next;
    });
  }
}

abstract class Flyable {
  void fly();
  String get name;
}

class Bird implements Flyable {
  @override
  final String name;

  Bird(this.name);

  @override
  void fly() {
    print("$name is flying with wings");
  }
}

class Airplane implements Flyable {
  @override
  final String name;

  Airplane(this.name);

  @override
  void fly() {
    print("$name is flying with engines");
  }
}

class FlyableManager<T extends Flyable> {
  final List<T> _flyables = [];

  void add(T flyable) {
    _flyables.add(flyable);
  }

  void makeAllFly() {
    for (T flyable in _flyables) {
      flyable.fly();
    }
  }

  List<String> getAllNames() {
    return _flyables.map((f) => f.name).toList();
  }
}

abstract class Entity {
  int get id;
}

class Product implements Entity {
  @override
  final int id;
  final String name;

  Product(this.id, this.name);
}

class EntityRepository<T extends Entity> {
  final Map<int, T> _entities = {};

  void save(T entity) {
    _entities[entity.id] = entity;
  }

  T? findById(int id) {
    return _entities[id];
  }

  List<T> findAll() {
    return _entities.values.toList();
  }

  void delete(int id) {
    _entities.remove(id);
  }
}

abstract class JsonSerializable {
  Map<String, dynamic> toJson();
}

class ApiResponse implements JsonSerializable {
  final int id;
  final String message;
  final Map<String, dynamic> data;

  ApiResponse(this.id, this.message, this.data);

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      json['id'],
      json['message'],
      json['data'] ?? {}
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'data': data
    };
  }
}

class DataProcessor<T extends JsonSerializable> {
  T createFromJson(Map<String, dynamic> json) {
    if (T == ApiResponse) {
      return ApiResponse.fromJson(json) as T;
    }
    throw UnsupportedError("Type $T not supported");
  }

  List<Map<String, dynamic>> serializeList(List<T> items) {
    return items.map((item) => item.toJson()).toList();
  }
}

abstract class Event {
  DateTime get timestamp;
}

class UserLoginEvent implements Event {
  final String userId;
  @override
  final DateTime timestamp;

  UserLoginEvent(this.userId, this.timestamp);
}

class OrderCreatedEvent implements Event {
  final String orderId;
  final double amount;
  @override
  final DateTime timestamp;

  OrderCreatedEvent(this.orderId, this.amount, this.timestamp);
}

class TypedEventBus {
  final Map<Type, List<Function>> _handlers = {};

  void subscribe<T extends Event>(void Function(T) handler) {
    _handlers.putIfAbsent(T, () => []).add(handler);
  }

  void publish<T extends Event>(T event) {
    final handlers = _handlers[T];
    if (handlers != null) {
      for (var handler in handlers) {
        handler(event);
      }
    }
  }
}

enum UserStatus { active, inactive, suspended, deleted }
enum OrderStatus { pending, processing, shipped, delivered, cancelled }

class StatusManager<T extends Enum> {
  T? _currentStatus;

  void setStatus(T status) {
    _currentStatus = status;
  }

  T? getCurrentStatus() => _currentStatus;

  List<T> getValidTransitions() {
    if (T == UserStatus) {
      return UserStatus.values.cast<T>();
    } else if (T == OrderStatus) {
      return OrderStatus.values.cast<T>();
    }
    return [];
  }

  bool canTransitionTo(T newStatus) {
    return getValidTransitions().contains(newStatus);
  }
}