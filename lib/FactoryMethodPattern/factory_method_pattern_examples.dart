/*
FACTORY METHOD PATTERN

What is it?
The Factory Method pattern is a creational design pattern that provides an interface
for creating objects in a superclass, but allows subclasses to alter the type of
objects that will be created. It defines a method for creating objects, but lets
subclasses decide which class to instantiate.

How to use it?
- Create an abstract creator class with a factory method
- Implement concrete creators that override the factory method
- Each concrete creator returns a different type of product
- The creator may also contain some default implementation

Where to use it?
- When you need to delegate object creation to subclasses
- When you want to provide a library of products and reveal only their interfaces
- When you want to save system resources by reusing existing objects
- When you need to choose between different implementations at runtime
- When you want to extend the framework by adding new product types
*/

// Example 1: Document Creation Factory
abstract class Document {
  void open();
  void save();
  void close();
}

class WordDocument implements Document {
  @override
  void open() => print('Opening Word document...');
  
  @override
  void save() => print('Saving Word document...');
  
  @override
  void close() => print('Closing Word document...');
}

class PDFDocument implements Document {
  @override
  void open() => print('Opening PDF document...');
  
  @override
  void save() => print('Saving PDF document...');
  
  @override
  void close() => print('Closing PDF document...');
}

class ExcelDocument implements Document {
  @override
  void open() => print('Opening Excel document...');
  
  @override
  void save() => print('Saving Excel document...');
  
  @override
  void close() => print('Closing Excel document...');
}

// Abstract Creator
abstract class DocumentCreator {
  // Factory method - to be implemented by subclasses
  Document createDocument();
  
  // Common operations that use the factory method
  void newDocument() {
    var doc = createDocument();
    doc.open();
    print('New document created and opened.');
  }
  
  void openExistingDocument(String filename) {
    var doc = createDocument();
    print('Loading file: $filename');
    doc.open();
  }
}

// Concrete Creators
class WordDocumentCreator extends DocumentCreator {
  @override
  Document createDocument() => WordDocument();
}

class PDFDocumentCreator extends DocumentCreator {
  @override
  Document createDocument() => PDFDocument();
}

class ExcelDocumentCreator extends DocumentCreator {
  @override
  Document createDocument() => ExcelDocument();
}

// Example 2: UI Component Factory
abstract class Button {
  void render();
  void onClick();
}

abstract class Checkbox {
  void render();
  void toggle();
}

// Windows UI Components
class WindowsButton implements Button {
  @override
  void render() => print('Rendering Windows-style button');
  
  @override
  void onClick() => print('Windows button clicked');
}

class WindowsCheckbox implements Checkbox {
  @override
  void render() => print('Rendering Windows-style checkbox');
  
  @override
  void toggle() => print('Windows checkbox toggled');
}

// macOS UI Components
class MacButton implements Button {
  @override
  void render() => print('Rendering macOS-style button');
  
  @override
  void onClick() => print('macOS button clicked');
}

class MacCheckbox implements Checkbox {
  @override
  void render() => print('Rendering macOS-style checkbox');
  
  @override
  void toggle() => print('macOS checkbox toggled');
}

// Linux UI Components
class LinuxButton implements Button {
  @override
  void render() => print('Rendering Linux-style button');
  
  @override
  void onClick() => print('Linux button clicked');
}

class LinuxCheckbox implements Checkbox {
  @override
  void render() => print('Rendering Linux-style checkbox');
  
  @override
  void toggle() => print('Linux checkbox toggled');
}

// Abstract Factory
abstract class UIFactory {
  Button createButton();
  Checkbox createCheckbox();
  
  // Common method that uses factory methods
  void createLoginForm() {
    var button = createButton();
    var checkbox = createCheckbox();
    
    print('Creating login form...');
    button.render();
    checkbox.render();
    print('Login form created with platform-specific components.');
  }
}

// Concrete Factories
class WindowsUIFactory extends UIFactory {
  @override
  Button createButton() => WindowsButton();
  
  @override
  Checkbox createCheckbox() => WindowsCheckbox();
}

class MacUIFactory extends UIFactory {
  @override
  Button createButton() => MacButton();
  
  @override
  Checkbox createCheckbox() => MacCheckbox();
}

class LinuxUIFactory extends UIFactory {
  @override
  Button createButton() => LinuxButton();
  
  @override
  Checkbox createCheckbox() => LinuxCheckbox();
}

// Example 3: Logger Factory
abstract class Logger {
  void log(String message);
  void error(String message);
  void warning(String message);
}

class FileLogger implements Logger {
  final String filename;
  
  FileLogger(this.filename);
  
  @override
  void log(String message) => print('FILE[$filename]: $message');
  
  @override
  void error(String message) => print('FILE[$filename] ERROR: $message');
  
  @override
  void warning(String message) => print('FILE[$filename] WARNING: $message');
}

class DatabaseLogger implements Logger {
  final String connectionString;
  
  DatabaseLogger(this.connectionString);
  
  @override
  void log(String message) => print('DB[$connectionString]: $message');
  
  @override
  void error(String message) => print('DB[$connectionString] ERROR: $message');
  
  @override
  void warning(String message) => print('DB[$connectionString] WARNING: $message');
}

class ConsoleLogger implements Logger {
  @override
  void log(String message) => print('CONSOLE: $message');
  
  @override
  void error(String message) => print('CONSOLE ERROR: $message');
  
  @override
  void warning(String message) => print('CONSOLE WARNING: $message');
}

// Abstract Logger Factory
abstract class LoggerFactory {
  Logger createLogger();
  
  // Common logging operations
  void logApplicationStart() {
    var logger = createLogger();
    logger.log('Application started');
  }
  
  void logError(String error) {
    var logger = createLogger();
    logger.error(error);
  }
}

// Concrete Logger Factories
class FileLoggerFactory extends LoggerFactory {
  final String filename;
  
  FileLoggerFactory(this.filename);
  
  @override
  Logger createLogger() => FileLogger(filename);
}

class DatabaseLoggerFactory extends LoggerFactory {
  final String connectionString;
  
  DatabaseLoggerFactory(this.connectionString);
  
  @override
  Logger createLogger() => DatabaseLogger(connectionString);
}

class ConsoleLoggerFactory extends LoggerFactory {
  @override
  Logger createLogger() => ConsoleLogger();
}

// Example 4: Transport Factory
abstract class Transport {
  void deliver(String package);
  double calculateCost(double weight, double distance);
}

class Truck implements Transport {
  @override
  void deliver(String package) {
    print('Delivering $package by truck on roads');
  }
  
  @override
  double calculateCost(double weight, double distance) {
    return weight * 0.5 + distance * 0.1; // Truck rates
  }
}

class Ship implements Transport {
  @override
  void deliver(String package) {
    print('Delivering $package by ship across water');
  }
  
  @override
  double calculateCost(double weight, double distance) {
    return weight * 0.3 + distance * 0.05; // Ship rates (cheaper for long distances)
  }
}

class Airplane implements Transport {
  @override
  void deliver(String package) {
    print('Delivering $package by airplane through air');
  }
  
  @override
  double calculateCost(double weight, double distance) {
    return weight * 1.0 + distance * 0.2; // Airplane rates (expensive but fast)
  }
}

// Abstract Transport Factory
abstract class TransportFactory {
  Transport createTransport();
  
  // Business logic that uses the factory method
  void deliverPackage(String package, double weight, double distance) {
    var transport = createTransport();
    var cost = transport.calculateCost(weight, distance);
    
    print('Package: $package (${weight}kg, ${distance}km)');
    print('Delivery cost: \$${cost.toStringAsFixed(2)}');
    transport.deliver(package);
    print('Package delivered successfully!\n');
  }
}

// Concrete Transport Factories
class RoadLogistics extends TransportFactory {
  @override
  Transport createTransport() => Truck();
}

class SeaLogistics extends TransportFactory {
  @override
  Transport createTransport() => Ship();
}

class AirLogistics extends TransportFactory {
  @override
  Transport createTransport() => Airplane();
}

// Example 5: Database Connection Factory
abstract class DatabaseConnection {
  void connect();
  void disconnect();
  void executeQuery(String query);
}

class MySQLConnection implements DatabaseConnection {
  final String host;
  final String database;
  
  MySQLConnection(this.host, this.database);
  
  @override
  void connect() => print('Connected to MySQL at $host/$database');
  
  @override
  void disconnect() => print('Disconnected from MySQL');
  
  @override
  void executeQuery(String query) => print('Executing MySQL query: $query');
}

class PostgreSQLConnection implements DatabaseConnection {
  final String host;
  final String database;
  
  PostgreSQLConnection(this.host, this.database);
  
  @override
  void connect() => print('Connected to PostgreSQL at $host/$database');
  
  @override
  void disconnect() => print('Disconnected from PostgreSQL');
  
  @override
  void executeQuery(String query) => print('Executing PostgreSQL query: $query');
}

class MongoDBConnection implements DatabaseConnection {
  final String host;
  final String database;
  
  MongoDBConnection(this.host, this.database);
  
  @override
  void connect() => print('Connected to MongoDB at $host/$database');
  
  @override
  void disconnect() => print('Disconnected from MongoDB');
  
  @override
  void executeQuery(String query) => print('Executing MongoDB query: $query');
}

// Abstract Database Factory
abstract class DatabaseFactory {
  DatabaseConnection createConnection(String host, String database);
  
  // Common database operations
  void performDatabaseOperation(String host, String database, String query) {
    var connection = createConnection(host, database);
    
    connection.connect();
    connection.executeQuery(query);
    connection.disconnect();
    print('Database operation completed.\n');
  }
}

// Concrete Database Factories
class MySQLFactory extends DatabaseFactory {
  @override
  DatabaseConnection createConnection(String host, String database) {
    return MySQLConnection(host, database);
  }
}

class PostgreSQLFactory extends DatabaseFactory {
  @override
  DatabaseConnection createConnection(String host, String database) {
    return PostgreSQLConnection(host, database);
  }
}

class MongoDBFactory extends DatabaseFactory {
  @override
  DatabaseConnection createConnection(String host, String database) {
    return MongoDBConnection(host, database);
  }
}

void main() {
  print('=== Factory Method Pattern Examples ===\n');
  
  // Example 1: Document Creation
  print('1. Document Creation Factory:');
  var wordCreator = WordDocumentCreator();
  var pdfCreator = PDFDocumentCreator();
  var excelCreator = ExcelDocumentCreator();
  
  wordCreator.newDocument();
  pdfCreator.openExistingDocument('report.pdf');
  excelCreator.newDocument();
  print('');
  
  // Example 2: UI Component Factory
  print('2. Cross-Platform UI Factory:');
  var currentPlatform = 'Windows'; // Could be determined at runtime
  
  UIFactory uiFactory;
  switch (currentPlatform) {
    case 'Windows':
      uiFactory = WindowsUIFactory();
      break;
    case 'macOS':
      uiFactory = MacUIFactory();
      break;
    case 'Linux':
      uiFactory = LinuxUIFactory();
      break;
    default:
      uiFactory = WindowsUIFactory();
  }
  
  uiFactory.createLoginForm();
  
  var button = uiFactory.createButton();
  button.onClick();
  print('');
  
  // Example 3: Logger Factory
  print('3. Logger Factory:');
  var loggers = <LoggerFactory>[
    FileLoggerFactory('app.log'),
    DatabaseLoggerFactory('localhost:5432/logs'),
    ConsoleLoggerFactory(),
  ];
  
  for (var loggerFactory in loggers) {
    loggerFactory.logApplicationStart();
    loggerFactory.logError('Sample error message');
  }
  print('');
  
  // Example 4: Transport Factory
  print('4. Transport/Logistics Factory:');
  var package = 'Electronics Package';
  var weight = 15.0; // kg
  var distance = 500.0; // km
  
  var transportFactories = <TransportFactory>[
    RoadLogistics(),
    SeaLogistics(),
    AirLogistics(),
  ];
  
  for (var factory in transportFactories) {
    factory.deliverPackage(package, weight, distance);
  }
  
  // Example 5: Database Connection Factory
  print('5. Database Connection Factory:');
  var databases = <DatabaseFactory>[
    MySQLFactory(),
    PostgreSQLFactory(),
    MongoDBFactory(),
  ];
  
  var query = 'SELECT * FROM users WHERE active = 1';
  
  for (var dbFactory in databases) {
    dbFactory.performDatabaseOperation('localhost', 'myapp', query);
  }
  
  print('Factory Method Pattern allows for:');
  print('- Easy addition of new product types');
  print('- Loose coupling between creator and products');
  print('- Adherence to Open/Closed Principle');
  print('- Runtime selection of object types');
}