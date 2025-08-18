/*
PROTOTYPE PATTERN

What is it?
The Prototype pattern is a creational design pattern that allows you to create new objects
by cloning existing objects (prototypes) instead of creating them from scratch. This is
useful when object creation is expensive or complex.

How to use it?
- Create a prototype interface with a clone method
- Implement the clone method in concrete classes
- Use the clone method to create new instances
- Can be shallow or deep cloning

Where to use it?
- When object creation is expensive (database objects, network connections)
- When you need multiple similar objects with slight variations
- When you want to avoid subclassing for object creation
- When the classes to instantiate are specified at runtime
- When you want to reduce the number of classes
*/

// Example 1: Basic Prototype Pattern
abstract class Prototype {
  Prototype clone();
}

class Document implements Prototype {
  String title;
  String content;
  List<String> tags;
  
  Document(this.title, this.content, this.tags);
  
  // Shallow clone - shares the same tags list reference
  @override
  Document clone() {
    return Document(title, content, tags);
  }
  
  // Deep clone - creates new tags list
  Document deepClone() {
    return Document(title, content, List<String>.from(tags));
  }
  
  @override
  String toString() => 'Document(title: $title, content: $content, tags: $tags)';
}

// Example 2: Game Character Prototype
abstract class GameCharacter implements Prototype {
  String name;
  int health;
  int level;
  Map<String, int> attributes;
  
  GameCharacter(this.name, this.health, this.level, this.attributes);
  
  void displayInfo() {
    print('Character: $name, Health: $health, Level: $level');
    print('Attributes: $attributes');
  }
}

class Warrior extends GameCharacter {
  String weaponType;
  
  Warrior(String name, int health, int level, Map<String, int> attributes, this.weaponType)
      : super(name, health, level, attributes);
  
  @override
  Warrior clone() {
    return Warrior(
      name,
      health,
      level,
      Map<String, int>.from(attributes), // Deep clone of attributes
      weaponType,
    );
  }
  
  @override
  void displayInfo() {
    super.displayInfo();
    print('Weapon: $weaponType');
  }
}

class Mage extends GameCharacter {
  String spellSchool;
  int mana;
  
  Mage(String name, int health, int level, Map<String, int> attributes, this.spellSchool, this.mana)
      : super(name, health, level, attributes);
  
  @override
  Mage clone() {
    return Mage(
      name,
      health,
      level,
      Map<String, int>.from(attributes),
      spellSchool,
      mana,
    );
  }
  
  @override
  void displayInfo() {
    super.displayInfo();
    print('Spell School: $spellSchool, Mana: $mana');
  }
}

// Example 3: Configuration Prototype
class DatabaseConfig implements Prototype {
  String host;
  int port;
  String database;
  String username;
  Map<String, String> connectionParams;
  
  DatabaseConfig({
    required this.host,
    required this.port,
    required this.database,
    required this.username,
    required this.connectionParams,
  });
  
  @override
  DatabaseConfig clone() {
    return DatabaseConfig(
      host: host,
      port: port,
      database: database,
      username: username,
      connectionParams: Map<String, String>.from(connectionParams),
    );
  }
  
  String getConnectionString() {
    return '$host:$port/$database?${connectionParams.entries.map((e) => '${e.key}=${e.value}').join('&')}';
  }
  
  @override
  String toString() => 'DatabaseConfig(${getConnectionString()})';
}

// Example 4: Prototype Registry Pattern
class PrototypeRegistry {
  static final Map<String, Prototype> _prototypes = {};
  
  static void registerPrototype(String key, Prototype prototype) {
    _prototypes[key] = prototype;
  }
  
  static T? getPrototype<T extends Prototype>(String key) {
    var prototype = _prototypes[key];
    return prototype?.clone() as T?;
  }
  
  static List<String> getRegisteredKeys() {
    return _prototypes.keys.toList();
  }
}

// Example 5: Complex Object with Prototype
class GraphicalShape implements Prototype {
  String type;
  double x, y;
  String color;
  Map<String, dynamic> properties;
  
  GraphicalShape(this.type, this.x, this.y, this.color, this.properties);
  
  @override
  GraphicalShape clone() {
    return GraphicalShape(
      type,
      x,
      y,
      color,
      Map<String, dynamic>.from(properties),
    );
  }
  
  void move(double newX, double newY) {
    x = newX;
    y = newY;
  }
  
  void changeColor(String newColor) {
    color = newColor;
  }
  
  @override
  String toString() => '$type at ($x, $y) - Color: $color, Properties: $properties';
}

void main() {
  print('=== Prototype Pattern Examples ===\n');
  
  // Example 1: Document Cloning
  print('1. Basic Document Prototype:');
  var originalDoc = Document('Original Title', 'Original Content', ['tag1', 'tag2']);
  var shallowClone = originalDoc.clone();
  var deepClone = originalDoc.deepClone();
  
  print('Original: $originalDoc');
  
  shallowClone.title = 'Shallow Clone Title';
  shallowClone.tags.add('new-tag'); // This affects original too!
  
  deepClone.title = 'Deep Clone Title';
  deepClone.tags.add('deep-tag'); // This doesn't affect original
  
  print('After modification:');
  print('Original: $originalDoc');
  print('Shallow Clone: $shallowClone');
  print('Deep Clone: $deepClone');
  print('');
  
  // Example 2: Game Character Prototypes
  print('2. Game Character Prototypes:');
  var warriorTemplate = Warrior(
    'Warrior Template',
    100,
    1,
    {'strength': 15, 'agility': 10, 'intelligence': 5},
    'Sword',
  );
  
  var mageTemplate = Mage(
    'Mage Template',
    80,
    1,
    {'strength': 5, 'agility': 8, 'intelligence': 20},
    'Fire',
    150,
  );
  
  // Create specific characters from prototypes
  var warrior1 = warriorTemplate.clone();
  warrior1.name = 'Conan';
  warrior1.level = 5;
  warrior1.attributes['strength'] = 20;
  
  var mage1 = mageTemplate.clone();
  mage1.name = 'Gandalf';
  mage1.level = 10;
  mage1.mana = 300;
  
  print('Created Characters:');
  warrior1.displayInfo();
  print('');
  mage1.displayInfo();
  print('');
  
  // Example 3: Configuration Cloning
  print('3. Database Configuration Prototype:');
  var baseConfig = DatabaseConfig(
    host: 'localhost',
    port: 5432,
    database: 'myapp',
    username: 'user',
    connectionParams: {'ssl': 'true', 'timeout': '30'},
  );
  
  var prodConfig = baseConfig.clone();
  prodConfig.host = 'prod-server.com';
  prodConfig.connectionParams['pool_size'] = '20';
  
  var testConfig = baseConfig.clone();
  testConfig.database = 'myapp_test';
  testConfig.connectionParams['ssl'] = 'false';
  
  print('Base Config: $baseConfig');
  print('Prod Config: $prodConfig');
  print('Test Config: $testConfig');
  print('');
  
  // Example 4: Prototype Registry
  print('4. Prototype Registry Pattern:');
  
  // Register prototypes
  PrototypeRegistry.registerPrototype('basic-warrior', warriorTemplate);
  PrototypeRegistry.registerPrototype('basic-mage', mageTemplate);
  PrototypeRegistry.registerPrototype('default-config', baseConfig);
  
  print('Registered prototypes: ${PrototypeRegistry.getRegisteredKeys()}');
  
  // Create objects from registry
  var newWarrior = PrototypeRegistry.getPrototype<Warrior>('basic-warrior');
  var newMage = PrototypeRegistry.getPrototype<Mage>('basic-mage');
  
  if (newWarrior != null) {
    newWarrior.name = 'Barbarian';
    print('Created from registry:');
    newWarrior.displayInfo();
  }
  print('');
  
  // Example 5: Graphical Shapes
  print('5. Graphical Shape Prototypes:');
  var circlePrototype = GraphicalShape(
    'Circle',
    0,
    0,
    'blue',
    {'radius': 10.0, 'fill': true},
  );
  
  var rectanglePrototype = GraphicalShape(
    'Rectangle',
    0,
    0,
    'red',
    {'width': 20.0, 'height': 15.0, 'fill': false},
  );
  
  // Create multiple shapes from prototypes
  var shapes = <GraphicalShape>[];
  
  for (int i = 0; i < 3; i++) {
    var circle = circlePrototype.clone();
    circle.move(i * 50.0, i * 50.0);
    circle.changeColor('blue-$i');
    shapes.add(circle);
    
    var rectangle = rectanglePrototype.clone();
    rectangle.move(i * 30.0 + 100, i * 30.0);
    rectangle.changeColor('red-$i');
    shapes.add(rectangle);
  }
  
  print('Created shapes:');
  for (var shape in shapes) {
    print(shape);
  }
}