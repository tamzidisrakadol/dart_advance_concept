/*
BUILDER PATTERN

What is it?
The Builder pattern is a creational design pattern that allows you to construct complex
objects step by step. It separates the construction of a complex object from its
representation, allowing the same construction process to create different representations.

How to use it?
- Create a builder class with methods for setting each part of the object
- Use method chaining (fluent interface) for easy configuration
- Provide a build() method to create the final object
- Often includes validation in the build() method

Where to use it?
- When creating objects with many optional parameters
- When object construction is complex and involves multiple steps
- When you want to create different representations of the same object
- When you want to make object creation more readable and maintainable
- When you need to validate object state before creation
*/

// Example 1: Basic Builder Pattern - House Construction
class House {
  final String foundation;
  final String structure;
  final String roof;
  final String interior;
  final bool hasGarage;
  final bool hasGarden;
  final bool hasSwimmingPool;
  final int rooms;
  
  House._({
    required this.foundation,
    required this.structure,
    required this.roof,
    required this.interior,
    required this.hasGarage,
    required this.hasGarden,
    required this.hasSwimmingPool,
    required this.rooms,
  });
  
  @override
  String toString() {
    return '''
House Details:
- Foundation: $foundation
- Structure: $structure  
- Roof: $roof
- Interior: $interior
- Rooms: $rooms
- Garage: ${hasGarage ? 'Yes' : 'No'}
- Garden: ${hasGarden ? 'Yes' : 'No'}
- Swimming Pool: ${hasSwimmingPool ? 'Yes' : 'No'}
''';
  }
}

class HouseBuilder {
  String _foundation = 'Concrete';
  String _structure = 'Wood';
  String _roof = 'Tile';
  String _interior = 'Standard';
  bool _hasGarage = false;
  bool _hasGarden = false;
  bool _hasSwimmingPool = false;
  int _rooms = 3;
  
  HouseBuilder foundation(String foundation) {
    _foundation = foundation;
    return this;
  }
  
  HouseBuilder structure(String structure) {
    _structure = structure;
    return this;
  }
  
  HouseBuilder roof(String roof) {
    _roof = roof;
    return this;
  }
  
  HouseBuilder interior(String interior) {
    _interior = interior;
    return this;
  }
  
  HouseBuilder withGarage() {
    _hasGarage = true;
    return this;
  }
  
  HouseBuilder withGarden() {
    _hasGarden = true;
    return this;
  }
  
  HouseBuilder withSwimmingPool() {
    _hasSwimmingPool = true;
    return this;
  }
  
  HouseBuilder rooms(int count) {
    if (count < 1) throw ArgumentError('House must have at least 1 room');
    _rooms = count;
    return this;
  }
  
  House build() {
    return House._(
      foundation: _foundation,
      structure: _structure,
      roof: _roof,
      interior: _interior,
      hasGarage: _hasGarage,
      hasGarden: _hasGarden,
      hasSwimmingPool: _hasSwimmingPool,
      rooms: _rooms,
    );
  }
}

// Example 2: SQL Query Builder
class SqlQuery {
  final String query;
  
  SqlQuery._(this.query);
  
  @override
  String toString() => query;
}

class SqlQueryBuilder {
  String _selectClause = '';
  String _fromClause = '';
  String _whereClause = '';
  String _orderByClause = '';
  String _limitClause = '';
  List<String> _joinClauses = [];
  
  SqlQueryBuilder select(List<String> columns) {
    _selectClause = 'SELECT ${columns.join(', ')}';
    return this;
  }
  
  SqlQueryBuilder from(String table) {
    _fromClause = 'FROM $table';
    return this;
  }
  
  SqlQueryBuilder where(String condition) {
    _whereClause = _whereClause.isEmpty 
        ? 'WHERE $condition' 
        : '$_whereClause AND $condition';
    return this;
  }
  
  SqlQueryBuilder orWhere(String condition) {
    _whereClause = _whereClause.isEmpty 
        ? 'WHERE $condition' 
        : '$_whereClause OR $condition';
    return this;
  }
  
  SqlQueryBuilder join(String table, String condition) {
    _joinClauses.add('JOIN $table ON $condition');
    return this;
  }
  
  SqlQueryBuilder leftJoin(String table, String condition) {
    _joinClauses.add('LEFT JOIN $table ON $condition');
    return this;
  }
  
  SqlQueryBuilder orderBy(String column, [String direction = 'ASC']) {
    _orderByClause = _orderByClause.isEmpty 
        ? 'ORDER BY $column $direction'
        : '$_orderByClause, $column $direction';
    return this;
  }
  
  SqlQueryBuilder limit(int count) {
    _limitClause = 'LIMIT $count';
    return this;
  }
  
  SqlQuery build() {
    if (_selectClause.isEmpty || _fromClause.isEmpty) {
      throw StateError('SELECT and FROM clauses are required');
    }
    
    var parts = [_selectClause, _fromClause];
    parts.addAll(_joinClauses);
    if (_whereClause.isNotEmpty) parts.add(_whereClause);
    if (_orderByClause.isNotEmpty) parts.add(_orderByClause);
    if (_limitClause.isNotEmpty) parts.add(_limitClause);
    
    return SqlQuery._(parts.join(' '));
  }
}

// Example 3: HTTP Request Builder
class HttpRequest {
  final String url;
  final String method;
  final Map<String, String> headers;
  final String? body;
  final Duration timeout;
  
  HttpRequest._({
    required this.url,
    required this.method,
    required this.headers,
    this.body,
    required this.timeout,
  });
  
  @override
  String toString() {
    return '''
HTTP Request:
- Method: $method
- URL: $url
- Headers: $headers
- Body: ${body ?? 'None'}
- Timeout: ${timeout.inSeconds}s
''';
  }
}

class HttpRequestBuilder {
  String? _url;
  String _method = 'GET';
  Map<String, String> _headers = {};
  String? _body;
  Duration _timeout = Duration(seconds: 30);
  
  HttpRequestBuilder url(String url) {
    _url = url;
    return this;
  }
  
  HttpRequestBuilder get() {
    _method = 'GET';
    return this;
  }
  
  HttpRequestBuilder post() {
    _method = 'POST';
    return this;
  }
  
  HttpRequestBuilder put() {
    _method = 'PUT';
    return this;
  }
  
  HttpRequestBuilder delete() {
    _method = 'DELETE';
    return this;
  }
  
  HttpRequestBuilder header(String key, String value) {
    _headers[key] = value;
    return this;
  }
  
  HttpRequestBuilder headers(Map<String, String> headers) {
    _headers.addAll(headers);
    return this;
  }
  
  HttpRequestBuilder contentType(String contentType) {
    _headers['Content-Type'] = contentType;
    return this;
  }
  
  HttpRequestBuilder authorization(String token) {
    _headers['Authorization'] = token;
    return this;
  }
  
  HttpRequestBuilder jsonBody(String json) {
    _body = json;
    _headers['Content-Type'] = 'application/json';
    return this;
  }
  
  HttpRequestBuilder body(String body) {
    _body = body;
    return this;
  }
  
  HttpRequestBuilder timeout(Duration timeout) {
    _timeout = timeout;
    return this;
  }
  
  HttpRequest build() {
    if (_url == null) {
      throw StateError('URL is required');
    }
    
    return HttpRequest._(
      url: _url!,
      method: _method,
      headers: Map<String, String>.from(_headers),
      body: _body,
      timeout: _timeout,
    );
  }
}

// Example 4: Email Builder with Validation
class Email {
  final String to;
  final String subject;
  final String body;
  final String? from;
  final List<String> cc;
  final List<String> bcc;
  final List<String> attachments;
  final bool isHtml;
  
  Email._({
    required this.to,
    required this.subject,
    required this.body,
    this.from,
    required this.cc,
    required this.bcc,
    required this.attachments,
    required this.isHtml,
  });
  
  @override
  String toString() {
    return '''
Email:
- From: ${from ?? 'Default Sender'}
- To: $to
- CC: ${cc.isEmpty ? 'None' : cc.join(', ')}
- BCC: ${bcc.isEmpty ? 'None' : bcc.join(', ')}
- Subject: $subject
- Body Type: ${isHtml ? 'HTML' : 'Plain Text'}
- Attachments: ${attachments.isEmpty ? 'None' : attachments.length}
- Body: ${body.length > 50 ? '${body.substring(0, 50)}...' : body}
''';
  }
}

class EmailBuilder {
  String? _to;
  String? _subject;
  String? _body;
  String? _from;
  List<String> _cc = [];
  List<String> _bcc = [];
  List<String> _attachments = [];
  bool _isHtml = false;
  
  EmailBuilder to(String email) {
    if (!_isValidEmail(email)) {
      throw ArgumentError('Invalid email address: $email');
    }
    _to = email;
    return this;
  }
  
  EmailBuilder from(String email) {
    if (!_isValidEmail(email)) {
      throw ArgumentError('Invalid email address: $email');
    }
    _from = email;
    return this;
  }
  
  EmailBuilder subject(String subject) {
    _subject = subject;
    return this;
  }
  
  EmailBuilder body(String body) {
    _body = body;
    _isHtml = false;
    return this;
  }
  
  EmailBuilder htmlBody(String htmlBody) {
    _body = htmlBody;
    _isHtml = true;
    return this;
  }
  
  EmailBuilder cc(String email) {
    if (!_isValidEmail(email)) {
      throw ArgumentError('Invalid email address: $email');
    }
    _cc.add(email);
    return this;
  }
  
  EmailBuilder bcc(String email) {
    if (!_isValidEmail(email)) {
      throw ArgumentError('Invalid email address: $email');
    }
    _bcc.add(email);
    return this;
  }
  
  EmailBuilder attachment(String filePath) {
    _attachments.add(filePath);
    return this;
  }
  
  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
  
  Email build() {
    if (_to == null) {
      throw StateError('Recipient email is required');
    }
    if (_subject == null || _subject!.isEmpty) {
      throw StateError('Subject is required');
    }
    if (_body == null || _body!.isEmpty) {
      throw StateError('Body is required');
    }
    
    return Email._(
      to: _to!,
      subject: _subject!,
      body: _body!,
      from: _from,
      cc: List<String>.from(_cc),
      bcc: List<String>.from(_bcc),
      attachments: List<String>.from(_attachments),
      isHtml: _isHtml,
    );
  }
}

// Example 5: Pizza Builder (Classic Example)
class Pizza {
  final String size;
  final String crust;
  final List<String> toppings;
  final bool extraCheese;
  final String sauce;
  final double price;
  
  Pizza._({
    required this.size,
    required this.crust,
    required this.toppings,
    required this.extraCheese,
    required this.sauce,
    required this.price,
  });
  
  @override
  String toString() {
    return '''
Pizza Order:
- Size: $size
- Crust: $crust  
- Sauce: $sauce
- Toppings: ${toppings.join(', ')}
- Extra Cheese: ${extraCheese ? 'Yes' : 'No'}
- Total Price: \$${price.toStringAsFixed(2)}
''';
  }
}

class PizzaBuilder {
  String _size = 'Medium';
  String _crust = 'Regular';
  List<String> _toppings = [];
  bool _extraCheese = false;
  String _sauce = 'Tomato';
  
  static const Map<String, double> _sizePrices = {
    'Small': 8.99,
    'Medium': 12.99,
    'Large': 16.99,
    'Extra Large': 20.99,
  };
  
  static const Map<String, double> _toppingPrices = {
    'Pepperoni': 1.50,
    'Mushrooms': 1.00,
    'Sausage': 1.75,
    'Peppers': 1.00,
    'Onions': 0.75,
    'Olives': 1.25,
    'Bacon': 2.00,
    'Ham': 1.75,
  };
  
  PizzaBuilder size(String size) {
    if (!_sizePrices.containsKey(size)) {
      throw ArgumentError('Invalid size: $size');
    }
    _size = size;
    return this;
  }
  
  PizzaBuilder crust(String crust) {
    _crust = crust;
    return this;
  }
  
  PizzaBuilder sauce(String sauce) {
    _sauce = sauce;
    return this;
  }
  
  PizzaBuilder addTopping(String topping) {
    if (!_toppingPrices.containsKey(topping)) {
      throw ArgumentError('Invalid topping: $topping');
    }
    _toppings.add(topping);
    return this;
  }
  
  PizzaBuilder addToppings(List<String> toppings) {
    for (var topping in toppings) {
      addTopping(topping);
    }
    return this;
  }
  
  PizzaBuilder extraCheese() {
    _extraCheese = true;
    return this;
  }
  
  double _calculatePrice() {
    double price = _sizePrices[_size]!;
    
    for (var topping in _toppings) {
      price += _toppingPrices[topping]!;
    }
    
    if (_extraCheese) {
      price += 1.50;
    }
    
    return price;
  }
  
  Pizza build() {
    return Pizza._(
      size: _size,
      crust: _crust,
      toppings: List<String>.from(_toppings),
      extraCheese: _extraCheese,
      sauce: _sauce,
      price: _calculatePrice(),
    );
  }
}

void main() {
  print('=== Builder Pattern Examples ===\n');
  
  // Example 1: House Builder
  print('1. House Builder Pattern:');
  var mansion = HouseBuilder()
      .foundation('Stone')
      .structure('Brick')
      .roof('Slate')
      .interior('Luxury')
      .rooms(8)
      .withGarage()
      .withGarden()
      .withSwimmingPool()
      .build();
  
  var simpleHouse = HouseBuilder()
      .rooms(3)
      .withGarden()
      .build();
  
  print('Mansion:$mansion');
  print('Simple House:$simpleHouse');
  
  // Example 2: SQL Query Builder
  print('2. SQL Query Builder:');
  var complexQuery = SqlQueryBuilder()
      .select(['u.name', 'u.email', 'p.title'])
      .from('users u')
      .leftJoin('posts p', 'u.id = p.user_id')
      .where('u.active = 1')
      .where('u.created_at > "2023-01-01"')
      .orderBy('u.name')
      .orderBy('p.created_at', 'DESC')
      .limit(10)
      .build();
  
  print('Complex Query: $complexQuery\n');
  
  // Example 3: HTTP Request Builder
  print('3. HTTP Request Builder:');
  var apiRequest = HttpRequestBuilder()
      .url('https://api.example.com/users')
      .post()
      .contentType('application/json')
      .authorization('Bearer token123')
      .header('X-API-Version', '2.0')
      .jsonBody('{"name": "John", "email": "john@example.com"}')
      .timeout(Duration(seconds: 60))
      .build();
  
  print(apiRequest);
  
  // Example 4: Email Builder
  print('4. Email Builder with Validation:');
  try {
    var email = EmailBuilder()
        .to('recipient@example.com')
        .from('sender@example.com')
        .subject('Important Update')
        .htmlBody('<h1>Hello!</h1><p>This is an important update.</p>')
        .cc('manager@example.com')
        .bcc('archive@example.com')
        .attachment('/path/to/document.pdf')
        .build();
    
    print(email);
  } catch (e) {
    print('Email validation error: $e');
  }
  
  // Example 5: Pizza Builder
  print('5. Pizza Builder (Classic Example):');
  var meatLovers = PizzaBuilder()
      .size('Large')
      .crust('Thick')
      .sauce('BBQ')
      .addToppings(['Pepperoni', 'Sausage', 'Bacon', 'Ham'])
      .extraCheese()
      .build();
  
  var veggie = PizzaBuilder()
      .size('Medium')
      .addToppings(['Mushrooms', 'Peppers', 'Onions', 'Olives'])
      .build();
  
  print(meatLovers);
  print(veggie);
  
  print('Available toppings: ${PizzaBuilder._toppingPrices.keys.join(', ')}');
  print('Available sizes: ${PizzaBuilder._sizePrices.keys.join(', ')}');
}