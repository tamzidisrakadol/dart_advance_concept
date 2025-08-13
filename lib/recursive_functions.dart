// Recursive Functions in Dart
// A recursive function is a function that calls itself to solve a problem

void main() {
  print('=== Recursive Functions Examples ===\n');

  // Example 1: Factorial
  print('1. Factorial Examples:');
  print('Factorial of 5: ${factorial(5)}');
  print('Factorial of 0: ${factorial(0)}');
  print('');

  // Example 2: Fibonacci
  print('2. Fibonacci Examples:');
  print('Fibonacci sequence (first 8 numbers):');
  for (int i = 0; i < 8; i++) {
    print('F($i) = ${fibonacci(i)}');
  }
  print('');

  // Example 3: Sum of digits
  print('3. Sum of Digits:');
  print('Sum of digits in 12345: ${sumOfDigits(12345)}');
  print('Sum of digits in 987: ${sumOfDigits(987)}');
  print('');

  // Example 4: Power calculation
  print('4. Power Calculation:');
  print('2^8 = ${power(2, 8)}');
  print('3^4 = ${power(3, 4)}');
  print('');  

  // Example 5: List sum
  print('5. List Sum (Recursive):');
  List<int> numbers = [1, 2, 3, 4, 5];
  print('Sum of $numbers = ${sumList(numbers, 0)}');
  print('');

  // Example 6: Binary tree traversal
  print('6. Binary Tree Example:');
  TreeNode root = TreeNode(1);
  root.left = TreeNode(2);
  root.right = TreeNode(3);
  root.left!.left = TreeNode(4);
  root.left!.right = TreeNode(5);
  
  print('Tree traversal (in-order): ');
  inOrderTraversal(root);
  print('');
}

// 1. FACTORIAL - Classic recursive example
int factorial(int n) {
  // Base case: factorial of 0 or 1 is 1
  if (n <= 1) {
    return 1;
  }
  
  // Recursive case: n! = n * (n-1)!
  return n * factorial(n - 1);
}

// 2. FIBONACCI - Another classic recursive example
int fibonacci(int n) {
  // Base cases
  if (n <= 0) return 0;
  if (n == 1) return 1;
  
  // Recursive case: F(n) = F(n-1) + F(n-2)
  return fibonacci(n - 1) + fibonacci(n - 2);
}

// 3. SUM OF DIGITS - Breaking down a number
int sumOfDigits(int n) {
  // Base case: single digit
  if (n < 10) {
    return n;
  }
  
  // Recursive case: last digit + sum of remaining digits
  return (n % 10) + sumOfDigits(n ~/ 10);
}

// 4. POWER CALCULATION - Mathematical operation
int power(int base, int exponent) {
  // Base case: any number to power 0 is 1
  if (exponent == 0) {
    return 1;
  }
  
  // Recursive case: base^exp = base * base^(exp-1)
  return base * power(base, exponent - 1);
}

// 5. LIST SUM - Working with collections
int sumList(List<int> list, int index) {
  // Base case: reached end of list
  if (index >= list.length) {
    return 0;
  }
  
  // Recursive case: current element + sum of rest
  return list[index] + sumList(list, index + 1);
}

// 6. TREE NODE - For tree traversal example
class TreeNode {
  int value;
  TreeNode? left;
  TreeNode? right;
  
  TreeNode(this.value);
}

// TREE TRAVERSAL - In-order traversal
void inOrderTraversal(TreeNode? node) {
  if (node == null) {
    return; // Base case: null node
  }
  
  // Recursive case: left -> root -> right
  inOrderTraversal(node.left);
  print('${node.value} ');
  inOrderTraversal(node.right);
}

// ADVANCED EXAMPLE: Directory-like structure traversal
class Directory {
  String name;
  List<Directory> subdirectories;
  
  Directory(this.name) : subdirectories = [];
  
  void addSubdirectory(Directory dir) {
    subdirectories.add(dir);
  }
}

void printDirectoryStructure(Directory dir, [int depth = 0]) {
  // Print current directory with indentation
  print('${'  ' * depth}${dir.name}/');
  
  // Recursively print subdirectories
  for (Directory subdir in dir.subdirectories) {
    printDirectoryStructure(subdir, depth + 1);
  }
}

// TAIL RECURSION EXAMPLE - More efficient
int factorialTailRecursive(int n, [int accumulator = 1]) {
  if (n <= 1) {
    return accumulator;
  }
  
  // Tail recursive call - last operation is the recursive call
  return factorialTailRecursive(n - 1, n * accumulator);
}