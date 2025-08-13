// Recursive Functions - Comprehensive Guide
// What is Recursion? How to use it? Where to use it?

void main() {
  print('🔄 RECURSIVE FUNCTIONS - COMPLETE GUIDE\n');
  
  demonstrateRecursionConcepts();
}

void demonstrateRecursionConcepts() {
  print('📚 WHAT IS RECURSION?');
  print('───────────────────────');
  print('• A recursive function is a function that calls itself');
  print('• It breaks down complex problems into smaller, similar problems');
  print('• Must have a BASE CASE to stop the recursion');
  print('• Each recursive call should move closer to the base case\n');

  print('🏗️ STRUCTURE OF RECURSIVE FUNCTION:');
  print('──────────────────────────────────');
  print('1. BASE CASE - When to stop recursion');
  print('2. RECURSIVE CASE - Function calls itself with modified input');
  print('3. PROGRESS - Each call should be closer to base case\n');

  print('✅ WHEN TO USE RECURSION:');
  print('────────────────────────');
  print('• Tree/Graph traversal');
  print('• Mathematical calculations (factorial, fibonacci)');
  print('• Divide and conquer algorithms');
  print('• Parsing nested structures');
  print('• Backtracking problems');
  print('• When problem can be broken into similar subproblems\n');

  print('❌ WHEN NOT TO USE RECURSION:');
  print('───────────────────────────');
  print('• Simple loops would be more efficient');
  print('• Deep recursion causing stack overflow');
  print('• When iterative solution is clearer');
  print('• Performance-critical code with many calls\n');

  print('⚡ RECURSION vs ITERATION:');
  print('────────────────────────');
  demonstrateRecursionVsIteration();
  
  print('\n🔧 BEST PRACTICES:');
  print('─────────────────');
  print('• Always define clear base case');
  print('• Ensure progress toward base case');
  print('• Consider tail recursion for efficiency');
  print('• Use memoization for overlapping subproblems');
  print('• Watch out for stack overflow with deep recursion\n');

  print('🎯 PRACTICAL EXAMPLES:');
  print('────────────────────');
  practicalRecursionExamples();
}

void demonstrateRecursionVsIteration() {
  print('Example: Calculate 5! (factorial)');
  print('');
  
  // Recursive approach
  print('RECURSIVE APPROACH:');
  print('factorial(5) calls factorial(4)');
  print('factorial(4) calls factorial(3)');
  print('factorial(3) calls factorial(2)');
  print('factorial(2) calls factorial(1)');
  print('factorial(1) returns 1 (base case)');
  print('Result: ${factorialRecursive(5)}');
  print('');
  
  // Iterative approach
  print('ITERATIVE APPROACH:');
  print('Start with result = 1');
  print('Loop: result *= i for i from 1 to 5');
  print('Result: ${factorialIterative(5)}');
}

int factorialRecursive(int n) {
  if (n <= 1) return 1;
  return n * factorialRecursive(n - 1);
}

int factorialIterative(int n) {
  int result = 1;
  for (int i = 1; i <= n; i++) {
    result *= i;
  }
  return result;
}

void practicalRecursionExamples() {
  print('1. FILE SYSTEM TRAVERSAL:');
  simulateFileSystemTraversal();
  print('');
  
  print('2. JSON PARSING:');
  simulateJsonParsing();
  print('');
  
  print('3. MAZE SOLVING:');
  simulateMazeSolving();
}

// Practical Example 1: File system traversal
void simulateFileSystemTraversal() {
  print('Searching for .dart files in project:');
  List<String> foundFiles = [];
  searchDartFiles('/project', foundFiles);
  print('Found files: ${foundFiles.join(', ')}');
}

void searchDartFiles(String path, List<String> foundFiles) {
  // Simulated file system structure
  Map<String, List<String>> fileSystem = {
    '/project': ['main.dart', '/lib', '/test'],
    '/lib': ['utils.dart', 'models.dart', '/widgets'],
    '/widgets': ['button.dart', 'card.dart'],
    '/test': ['main_test.dart']
  };
  
  List<String>? contents = fileSystem[path];
  if (contents == null) return;
  
  for (String item in contents) {
    if (item.endsWith('.dart')) {
      foundFiles.add('$path/$item');
    } else if (item.startsWith('/')) {
      // Recursive call for subdirectories
      searchDartFiles(item, foundFiles);
    }
  }
}

// Practical Example 2: JSON structure validation
void simulateJsonParsing() {
  print('Validating nested JSON structure:');
  Map<String, dynamic> jsonData = {
    'user': {
      'name': 'John',
      'profile': {
        'age': 25,
        'settings': {
          'theme': 'dark'
        }
      }
    }
  };
  
  int depth = calculateJsonDepth(jsonData);
  print('Maximum nesting depth: $depth levels');
}

int calculateJsonDepth(dynamic obj) {
  if (obj is Map) {
    int maxDepth = 0;
    for (dynamic value in obj.values) {
      int depth = calculateJsonDepth(value);
      if (depth > maxDepth) {
        maxDepth = depth;
      }
    }
    return maxDepth + 1;
  } else if (obj is List) {
    int maxDepth = 0;
    for (dynamic item in obj) {
      int depth = calculateJsonDepth(item);
      if (depth > maxDepth) {
        maxDepth = depth;
      }
    }
    return maxDepth + 1;
  }
  return 0; // Base case: primitive value
}

// Practical Example 3: Maze solving (simplified)
void simulateMazeSolving() {
  print('Finding path through maze using backtracking:');
  List<List<int>> maze = [
    [0, 1, 0, 0],
    [0, 1, 0, 1],
    [0, 0, 0, 1],
    [1, 1, 0, 0]
  ];
  
  bool pathExists = solveMaze(maze, 0, 0, 3, 3);
  print('Path from (0,0) to (3,3): ${pathExists ? 'Found!' : 'Not found'}');
}

bool solveMaze(List<List<int>> maze, int x, int y, int targetX, int targetY) {
  // Base cases
  if (x < 0 || y < 0 || x >= maze.length || y >= maze[0].length) {
    return false; // Out of bounds
  }
  if (maze[x][y] == 1) {
    return false; // Wall
  }
  if (x == targetX && y == targetY) {
    return true; // Reached target
  }
  
  // Mark current cell as visited
  maze[x][y] = 1;
  
  // Try all four directions (recursive calls)
  bool canReach = solveMaze(maze, x + 1, y, targetX, targetY) ||
                  solveMaze(maze, x - 1, y, targetX, targetY) ||
                  solveMaze(maze, x, y + 1, targetX, targetY) ||
                  solveMaze(maze, x, y - 1, targetX, targetY);
  
  // Backtrack: unmark current cell
  maze[x][y] = 0;
  
  return canReach;
}