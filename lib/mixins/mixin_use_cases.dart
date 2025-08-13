// DART MIXINS - BEST USE CASES & REAL-WORLD EXAMPLES
// ==================================================

// USE CASE 1: Cross-cutting Concerns (Logging, Validation, etc.)
mixin Validatable {
  Map<String, String> _errors = {};
  
  void addError(String field, String message) {
    _errors[field] = message;
  }
  
  bool get isValid => _errors.isEmpty;
  
  Map<String, String> get errors => Map.unmodifiable(_errors);
  
  void clearErrors() => _errors.clear();
}

mixin Timestampable {
  DateTime? _createdAt;
  DateTime? _updatedAt;
  
  DateTime? get createdAt => _createdAt;
  DateTime? get updatedAt => _updatedAt;
  
  void markCreated() {
    _createdAt = DateTime.now();
    _updatedAt = _createdAt;
  }
  
  void markUpdated() {
    _updatedAt = DateTime.now();
  }
}

class UserModel with Validatable, Timestampable {
  String username;
  String email;
  
  UserModel(this.username, this.email) {
    markCreated();
    _validate();
  }
  
  void _validate() {
    clearErrors();
    
    if (username.isEmpty) {
      addError('username', 'Username cannot be empty');
    }
    
    if (!email.contains('@')) {
      addError('email', 'Invalid email format');
    }
  }
  
  void updateEmail(String newEmail) {
    email = newEmail;
    markUpdated();
    _validate();
  }
}

// USE CASE 2: State Management Patterns
mixin Loadable {
  bool _isLoading = false;
  
  bool get isLoading => _isLoading;
  
  void setLoading(bool loading) {
    _isLoading = loading;
  }
  
  Future<T> withLoading<T>(Future<T> Function() operation) async {
    setLoading(true);
    try {
      return await operation();
    } finally {
      setLoading(false);
    }
  }
}

mixin Cacheable<T> {
  T? _cachedData;
  DateTime? _cacheTime;
  Duration _cacheExpiry = Duration(minutes: 5);
  
  bool get hasCachedData => _cachedData != null && !_isCacheExpired;
  
  bool get _isCacheExpired {
    if (_cacheTime == null) return true;
    return DateTime.now().difference(_cacheTime!) > _cacheExpiry;
  }
  
  T? get cachedData => hasCachedData ? _cachedData : null;
  
  void setCacheData(T data) {
    _cachedData = data;
    _cacheTime = DateTime.now();
  }
  
  void clearCache() {
    _cachedData = null;
    _cacheTime = null;
  }
}

class ApiService with Loadable, Cacheable<List<String>> {
  Future<List<String>> fetchUsers() async {
    return await withLoading(() async {
      // Return cached data if available
      if (hasCachedData) {
        print('Returning cached data');
        return cachedData!;
      }
      
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));
      var users = ['John', 'Jane', 'Bob'];
      
      setCacheData(users);
      print('Fetched fresh data');
      return users;
    });
  }
}

// USE CASE 3: Plugin/Extension Pattern
mixin Serializable {
  Map<String, dynamic> toJson();
  
  String toJsonString() {
    return toJson().toString();
  }
}

mixin Comparable<T> {
  int compareTo(T other);
  
  bool operator >(T other) => compareTo(other) > 0;
  bool operator <(T other) => compareTo(other) < 0;
  bool operator >=(T other) => compareTo(other) >= 0;
  bool operator <=(T other) => compareTo(other) <= 0;
}

class Product with Serializable, Comparable<Product> {
  String name;
  double price;
  
  Product(this.name, this.price);
  
  @override
  Map<String, dynamic> toJson() => {
    'name': name,
    'price': price,
  };
  
  @override
  int compareTo(Product other) {
    return price.compareTo(other.price);
  }
}

// USE CASE 4: Event System
mixin EventEmitter {
  final Map<String, List<Function(dynamic)>> _listeners = {};
  
  void on(String event, Function(dynamic) callback) {
    _listeners.putIfAbsent(event, () => []).add(callback);
  }
  
  void emit(String event, [dynamic data]) {
    _listeners[event]?.forEach((callback) => callback(data));
  }
  
  void off(String event) {
    _listeners.remove(event);
  }
}

class ShoppingCart with EventEmitter {
  List<Product> _items = [];
  
  List<Product> get items => List.unmodifiable(_items);
  
  void addItem(Product product) {
    _items.add(product);
    emit('itemAdded', product);
    emit('cartChanged', _items.length);
  }
  
  void removeItem(Product product) {
    _items.remove(product);
    emit('itemRemoved', product);
    emit('cartChanged', _items.length);
  }
  
  double get total => _items.fold(0, (sum, item) => sum + item.price);
}

// USE CASE 5: Authentication & Authorization
mixin Authenticatable {
  String? _token;
  String? _userId;
  
  bool get isAuthenticated => _token != null;
  String? get token => _token;
  String? get userId => _userId;
  
  void authenticate(String token, String userId) {
    _token = token;
    _userId = userId;
  }
  
  void logout() {
    _token = null;
    _userId = null;
  }
}

mixin Authorizable {
  Set<String> _permissions = {};
  
  void grantPermission(String permission) {
    _permissions.add(permission);
  }
  
  bool hasPermission(String permission) {
    return _permissions.contains(permission);
  }
  
  bool hasAnyPermission(List<String> permissions) {
    return permissions.any((p) => _permissions.contains(p));
  }
}

class AdminUser with Authenticatable, Authorizable {
  String name;
  
  AdminUser(this.name);
  
  void performAdminAction() {
    if (!isAuthenticated) {
      throw Exception('Must be authenticated');
    }
    
    if (!hasPermission('admin')) {
      throw Exception('Insufficient permissions');
    }
    
    print('Admin action performed by $name');
  }
}

void main() {
  print('=== Use Case 1: Validation & Timestamps ===');
  
  var user = UserModel('john_doe', 'john@example.com');
  print('User valid: ${user.isValid}');
  print('Created at: ${user.createdAt}');
  
  user.updateEmail('invalid-email');
  print('After invalid email - Valid: ${user.isValid}');
  print('Errors: ${user.errors}');
  
  print('\n=== Use Case 2: Loading & Caching ===');
  
  var apiService = ApiService();
  
  // First call - will load from "API"
  apiService.fetchUsers().then((users) {
    print('First call: $users');
    
    // Second call - will use cache
    return apiService.fetchUsers();
  }).then((users) {
    print('Second call (cached): $users');
  });
  
  print('\n=== Use Case 3: Serialization & Comparison ===');
  
  var product1 = Product('iPhone', 999.99);
  var product2 = Product('Samsung', 799.99);
  
  print('Product JSON: ${product1.toJsonString()}');
  print('iPhone > Samsung: ${product1 > product2}');
  
  print('\n=== Use Case 4: Event System ===');
  
  var cart = ShoppingCart();
  
  cart.on('itemAdded', (product) {
    print('Added to cart: ${product.name}');
  });
  
  cart.on('cartChanged', (itemCount) {
    print('Cart now has $itemCount items');
  });
  
  cart.addItem(product1);
  cart.addItem(product2);
  
  print('Total: \$${cart.total}');
  
  print('\n=== Use Case 5: Authentication & Authorization ===');
  
  var admin = AdminUser('Alice');
  admin.authenticate('jwt-token-123', 'user-456');
  admin.grantPermission('admin');
  
  try {
    admin.performAdminAction();
  } catch (e) {
    print('Error: $e');
  }
}

/*
WHEN TO USE MIXINS:

1. ✅ Cross-cutting Concerns
   - Logging, validation, caching
   - Functionality needed across unrelated classes

2. ✅ Optional Features
   - Adding capabilities without changing class hierarchy
   - Plugin-like functionality

3. ✅ State Management
   - Loading states, error handling
   - Reactive patterns

4. ✅ Event Systems
   - Observer patterns
   - Pub/sub mechanisms

5. ✅ Authentication/Authorization
   - User permissions
   - Session management

WHEN NOT TO USE MIXINS:

1. ❌ Core Business Logic
   - Keep business logic in main classes
   - Mixins should be supporting functionality

2. ❌ Strong IS-A Relationships
   - Use inheritance for true parent-child relationships
   - Dog IS-A Animal (inheritance)
   - Dog CAN-BARK (mixin)

3. ❌ Complex Dependencies
   - Avoid mixins that depend heavily on each other
   - Keep mixins independent

4. ❌ Performance Critical Code
   - Mixins add slight overhead
   - Use direct implementation for hot paths
*/