void main() {
  print("=== GENERIC CLASSES IN DART ===\n");

  print("1. Simple Generic Stack:");
  Stack<String> stringStack = Stack<String>();
  stringStack.push('First');
  stringStack.push('Second');
  stringStack.push('Third');
  
  print("Stack size: ${stringStack.size}");
  print("Top element: ${stringStack.peek()}");
  print("Popped: ${stringStack.pop()}");
  print("Stack after pop: ${stringStack.getAll()}");
  print("");

  print("2. Generic Repository Pattern:");
  UserRepository userRepo = UserRepository();
  userRepo.save(User(1, 'Alice', 'alice@email.com'));
  userRepo.save(User(2, 'Bob', 'bob@email.com'));
  
  User? user = userRepo.findById(1);
  print("Found user: ${user?.name} (${user?.email})");
  
  List<User> allUsers = userRepo.findAll();
  print("All users: ${allUsers.map((u) => u.name).toList()}");
  print("");

  print("3. Generic Cache System:");
  Cache<String, User> userCache = Cache<String, User>();
  userCache.put('user1', User(1, 'Charlie', 'charlie@email.com'));
  userCache.put('user2', User(2, 'Diana', 'diana@email.com'));
  
  User? cachedUser = userCache.get('user1');
  print("Cached user: ${cachedUser?.name}");
  print("Cache size: ${userCache.size}");
  print("Cache keys: ${userCache.keys}");
  print("");

  print("4. Generic Tree Data Structure:");
  TreeNode<int> root = TreeNode<int>(10);
  root.addChild(TreeNode<int>(5));
  root.addChild(TreeNode<int>(15));
  root.children[0].addChild(TreeNode<int>(3));
  root.children[0].addChild(TreeNode<int>(7));
  
  print("Tree structure:");
  root.printTree();
  print("");

  print("5. Generic Builder Pattern:");
  QueryBuilder<User> userQuery = QueryBuilder<User>();
  List<User> filteredUsers = userQuery
      .where((user) => user.id > 0)
      .orderBy((user) => user.name)
      .limit(10)
      .execute(allUsers);
  
  print("Filtered users: ${filteredUsers.map((u) => u.name).toList()}");
  print("");

  print("6. Generic Event System:");
  EventBus eventBus = EventBus();
  
  eventBus.subscribe<UserCreatedEvent>((event) {
    print("User created: ${event.user.name}");
  });
  
  eventBus.subscribe<UserDeletedEvent>((event) {
    print("User deleted: ${event.userId}");
  });
  
  eventBus.publish(UserCreatedEvent(User(3, 'Eve', 'eve@email.com')));
  eventBus.publish(UserDeletedEvent(1));
  print("");

  print("7. Generic Wrapper Classes:");
  Result<String> successResult = Result.success('Operation completed');
  Result<String> errorResult = Result.error('Something went wrong');
  
  print("Success result: ${successResult.isSuccess} - ${successResult.value}");
  print("Error result: ${errorResult.isSuccess} - ${errorResult.error}");
  
  Optional<String> presentValue = Optional.of('Hello');
  Optional<String> emptyValue = Optional.empty();
  
  print("Present value: ${presentValue.isPresent} - ${presentValue.value}");
  print("Empty value: ${emptyValue.isPresent}");
  print("");

  print("8. Generic Collection Extensions:");
  List<int> numbers = [1, 2, 3, 4, 5];
  GenericList<int> genericNumbers = GenericList.from(numbers);
  
  GenericList<int> evenNumbers = genericNumbers.filter((n) => n % 2 == 0);
  GenericList<String> stringNumbers = genericNumbers.map((n) => 'Number: $n');
  
  print("Original: ${genericNumbers.toList()}");
  print("Even numbers: ${evenNumbers.toList()}");
  print("String numbers: ${stringNumbers.toList()}");
}

class Stack<T> {
  final List<T> _items = [];

  void push(T item) {
    _items.add(item);
  }

  T? pop() {
    if (_items.isEmpty) return null;
    return _items.removeLast();
  }

  T? peek() {
    if (_items.isEmpty) return null;
    return _items.last;
  }

  bool get isEmpty => _items.isEmpty;
  int get size => _items.length;
  
  List<T> getAll() => List.from(_items);
}

abstract class Repository<T, ID> {
  void save(T entity);
  T? findById(ID id);
  List<T> findAll();
  void delete(ID id);
}

class User {
  final int id;
  final String name;
  final String email;

  User(this.id, this.name, this.email);

  @override
  String toString() => 'User(id: $id, name: $name, email: $email)';
}

class UserRepository extends Repository<User, int> {
  final Map<int, User> _users = {};

  @override
  void save(User user) {
    _users[user.id] = user;
  }

  @override
  User? findById(int id) {
    return _users[id];
  }

  @override
  List<User> findAll() {
    return _users.values.toList();
  }

  @override
  void delete(int id) {
    _users.remove(id);
  }
}

class Cache<K, V> {
  final Map<K, V> _cache = {};

  void put(K key, V value) {
    _cache[key] = value;
  }

  V? get(K key) {
    return _cache[key];
  }

  bool containsKey(K key) {
    return _cache.containsKey(key);
  }

  void remove(K key) {
    _cache.remove(key);
  }

  void clear() {
    _cache.clear();
  }

  int get size => _cache.length;
  
  Iterable<K> get keys => _cache.keys;
  
  Iterable<V> get values => _cache.values;
}

class TreeNode<T> {
  T value;
  List<TreeNode<T>> children = [];
  TreeNode<T>? parent;

  TreeNode(this.value);

  void addChild(TreeNode<T> child) {
    child.parent = this;
    children.add(child);
  }

  void removeChild(TreeNode<T> child) {
    child.parent = null;
    children.remove(child);
  }

  void printTree([int depth = 0]) {
    String indent = '  ' * depth;
    print('$indent$value');
    for (TreeNode<T> child in children) {
      child.printTree(depth + 1);
    }
  }
}

class QueryBuilder<T> {
  List<bool Function(T)> _filters = [];
  int Function(T, T)? _sorter;
  int? _limitCount;

  QueryBuilder<T> where(bool Function(T) predicate) {
    _filters.add(predicate);
    return this;
  }

  QueryBuilder<T> orderBy(Comparable Function(T) keySelector) {
    _sorter = (a, b) => keySelector(a).compareTo(keySelector(b));
    return this;
  }

  QueryBuilder<T> limit(int count) {
    _limitCount = count;
    return this;
  }

  List<T> execute(List<T> data) {
    List<T> result = List.from(data);
    
    for (var filter in _filters) {
      result = result.where(filter).toList();
    }
    
    if (_sorter != null) {
      result.sort(_sorter);
    }
    
    if (_limitCount != null) {
      result = result.take(_limitCount!).toList();
    }
    
    return result;
  }
}

abstract class Event {}

class UserCreatedEvent extends Event {
  final User user;
  UserCreatedEvent(this.user);
}

class UserDeletedEvent extends Event {
  final int userId;
  UserDeletedEvent(this.userId);
}

class EventBus {
  final Map<Type, List<Function>> _subscribers = {};

  void subscribe<T extends Event>(void Function(T) handler) {
    _subscribers.putIfAbsent(T, () => []).add(handler);
  }

  void publish<T extends Event>(T event) {
    final handlers = _subscribers[T];
    if (handlers != null) {
      for (var handler in handlers) {
        handler(event);
      }
    }
  }
}

class Result<T> {
  final T? _value;
  final String? _error;
  final bool _isSuccess;

  Result.success(T value) 
      : _value = value, _error = null, _isSuccess = true;
      
  Result.error(String error) 
      : _value = null, _error = error, _isSuccess = false;

  bool get isSuccess => _isSuccess;
  bool get isError => !_isSuccess;
  
  T? get value => _value;
  String? get error => _error;
}

class Optional<T> {
  final T? _value;

  Optional.of(T value) : _value = value;
  Optional.empty() : _value = null;

  bool get isPresent => _value != null;
  bool get isEmpty => _value == null;
  
  T? get value => _value;
  
  T orElse(T defaultValue) => _value ?? defaultValue;
}

class GenericList<T> {
  final List<T> _items;

  GenericList(this._items);
  
  GenericList.from(List<T> items) : _items = List.from(items);

  GenericList<T> filter(bool Function(T) predicate) {
    return GenericList(_items.where(predicate).toList());
  }

  GenericList<U> map<U>(U Function(T) transform) {
    return GenericList(_items.map(transform).toList());
  }

  T? find(bool Function(T) predicate) {
    for (T item in _items) {
      if (predicate(item)) return item;
    }
    return null;
  }

  bool any(bool Function(T) predicate) {
    return _items.any(predicate);
  }

  bool all(bool Function(T) predicate) {
    return _items.every(predicate);
  }

  int get length => _items.length;
  
  List<T> toList() => List.from(_items);
}