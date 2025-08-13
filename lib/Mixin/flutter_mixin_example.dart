// // FLUTTER MIXINS - PRACTICAL EXAMPLES
// // ====================================

// import 'package:flutter/material.dart';

// // 1. LOADING STATE MIXIN
// // Perfect for widgets that need to show loading indicators
// mixin LoadingStateMixin<T extends StatefulWidget> on State<T> {
//   bool _isLoading = false;
  
//   bool get isLoading => _isLoading;
  
//   void setLoading(bool loading) {
//     if (_isLoading != loading) {
//       setState(() {
//         _isLoading = loading;
//       });
//     }
//   }
  
//   Widget buildLoadingOverlay({Widget? child}) {
//     return Stack(
//       children: [
//         if (child != null) child,
//         if (_isLoading)
//           Container(
//             color: Colors.black.withOpacity(0.3),
//             child: const Center(
//               child: CircularProgressIndicator(),
//             ),
//           ),
//       ],
//     );
//   }
  
//   Future<T> withLoading<T>(Future<T> Function() operation) async {
//     setLoading(true);
//     try {
//       return await operation();
//     } finally {
//       setLoading(false);
//     }
//   }
// }

// // 2. ERROR HANDLING MIXIN
// mixin ErrorHandlingMixin<T extends StatefulWidget> on State<T> {
//   String? _errorMessage;
  
//   String? get errorMessage => _errorMessage;
//   bool get hasError => _errorMessage != null;
  
//   void setError(String? error) {
//     setState(() {
//       _errorMessage = error;
//     });
//   }
  
//   void clearError() => setError(null);
  
//   Widget buildErrorWidget() {
//     if (!hasError) return const SizedBox.shrink();
    
//     return Container(
//       padding: const EdgeInsets.all(16),
//       margin: const EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         color: Colors.red.shade100,
//         border: Border.all(color: Colors.red),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Row(
//         children: [
//           const Icon(Icons.error, color: Colors.red),
//           const SizedBox(width: 8),
//           Expanded(
//             child: Text(
//               _errorMessage!,
//               style: const TextStyle(color: Colors.red),
//             ),
//           ),
//           IconButton(
//             icon: const Icon(Icons.close, color: Colors.red),
//             onPressed: clearError,
//           ),
//         ],
//       ),
//     );
//   }
  
//   void handleAsyncError(Future Function() operation) async {
//     try {
//       clearError();
//       await operation();
//     } catch (e) {
//       setError(e.toString());
//     }
//   }
// }

// // 3. FORM VALIDATION MIXIN
// mixin FormValidationMixin<T extends StatefulWidget> on State<T> {
//   final Map<String, String?> _validationErrors = {};
  
//   Map<String, String?> get validationErrors => Map.unmodifiable(_validationErrors);
//   bool get isFormValid => _validationErrors.values.every((error) => error == null);
  
//   void setFieldError(String field, String? error) {
//     setState(() {
//       _validationErrors[field] = error;
//     });
//   }
  
//   void clearFieldError(String field) => setFieldError(field, null);
  
//   void clearAllErrors() {
//     setState(() {
//       _validationErrors.clear();
//     });
//   }
  
//   String? validateField(String field, String? value, List<String? Function(String?)> validators) {
//     for (var validator in validators) {
//       final error = validator(value);
//       if (error != null) {
//         setFieldError(field, error);
//         return error;
//       }
//     }
//     clearFieldError(field);
//     return null;
//   }
  
//   // Common validators
//   static String? requiredValidator(String? value) {
//     return (value == null || value.isEmpty) ? 'This field is required' : null;
//   }
  
//   static String? emailValidator(String? value) {
//     if (value == null || value.isEmpty) return null;
//     return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)
//         ? null
//         : 'Enter a valid email address';
//   }
  
//   static String? Function(String?) minLengthValidator(int minLength) {
//     return (String? value) {
//       if (value == null || value.isEmpty) return null;
//       return value.length >= minLength
//           ? null
//           : 'Minimum $minLength characters required';
//     };
//   }
// }

// // 4. SNACKBAR HELPER MIXIN
// mixin SnackBarMixin<T extends StatefulWidget> on State<T> {
//   void showSuccessSnackBar(String message) {
//     _showSnackBar(message, Colors.green);
//   }
  
//   void showErrorSnackBar(String message) {
//     _showSnackBar(message, Colors.red);
//   }
  
//   void showInfoSnackBar(String message) {
//     _showSnackBar(message, Colors.blue);
//   }
  
//   void _showSnackBar(String message, Color backgroundColor) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: backgroundColor,
//         behavior: SnackBarBehavior.floating,
//         action: SnackBarAction(
//           label: 'Dismiss',
//           textColor: Colors.white,
//           onPressed: () {
//             ScaffoldMessenger.of(context).hideCurrentSnackBar();
//           },
//         ),
//       ),
//     );
//   }
// }

// // 5. KEYBOARD HANDLING MIXIN
// mixin KeyboardHandlingMixin<T extends StatefulWidget> on State<T> {
//   bool _keyboardVisible = false;
  
//   bool get keyboardVisible => _keyboardVisible;
  
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _setupKeyboardListener();
//     });
//   }
  
//   void _setupKeyboardListener() {
//     final view = WidgetsBinding.instance.platformDispatcher.views.first;
//     view.viewInsets.addListener(() {
//       final newKeyboardVisible = view.viewInsets.bottom > 0;
//       if (_keyboardVisible != newKeyboardVisible) {
//         setState(() {
//           _keyboardVisible = newKeyboardVisible;
//         });
//         onKeyboardToggle(newKeyboardVisible);
//       }
//     });
//   }
  
//   void onKeyboardToggle(bool visible) {
//     // Override this method to handle keyboard visibility changes
//   }
  
//   void hideKeyboard() {
//     FocusScope.of(context).unfocus();
//   }
// }

// // 6. EXAMPLE WIDGET USING MULTIPLE MIXINS
// class UserRegistrationScreen extends StatefulWidget {
//   const UserRegistrationScreen({Key? key}) : super(key: key);
  
//   @override
//   State<UserRegistrationScreen> createState() => _UserRegistrationScreenState();
// }

// class _UserRegistrationScreenState extends State<UserRegistrationScreen>
//     with LoadingStateMixin, ErrorHandlingMixin, FormValidationMixin, SnackBarMixin, KeyboardHandlingMixin {
  
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
  
//   @override
//   void initState() {
//     super.initState();
    
//     // Setup field validation listeners
//     _nameController.addListener(() {
//       validateField('name', _nameController.text, [
//         FormValidationMixin.requiredValidator,
//       ]);
//     });
    
//     _emailController.addListener(() {
//       validateField('email', _emailController.text, [
//         FormValidationMixin.requiredValidator,
//         FormValidationMixin.emailValidator,
//       ]);
//     });
    
//     _passwordController.addListener(() {
//       validateField('password', _passwordController.text, [
//         FormValidationMixin.requiredValidator,
//         FormValidationMixin.minLengthValidator(6),
//       ]);
//     });
//   }
  
//   @override
//   void onKeyboardToggle(bool visible) {
//     print('Keyboard ${visible ? 'shown' : 'hidden'}');
//   }
  
//   Future<void> _register() async {
//     if (!isFormValid) {
//       showErrorSnackBar('Please fix validation errors');
//       return;
//     }
    
//     await withLoading(() async {
//       // Simulate API call
//       await Future.delayed(const Duration(seconds: 2));
      
//       // Simulate random success/failure
//       if (DateTime.now().millisecond % 2 == 0) {
//         throw Exception('Registration failed: Email already exists');
//       }
      
//       showSuccessSnackBar('Registration successful!');
      
//       // Clear form
//       _nameController.clear();
//       _emailController.clear();
//       _passwordController.clear();
//       clearAllErrors();
//     }).catchError((error) {
//       setError(error.toString());
//     });
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('User Registration'),
//       ),
//       body: buildLoadingOverlay(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 // Error display
//                 buildErrorWidget(),
                
//                 const SizedBox(height: 16),
                
//                 // Name field
//                 TextFormField(
//                   controller: _nameController,
//                   decoration: InputDecoration(
//                     labelText: 'Full Name',
//                     errorText: validationErrors['name'],
//                     border: const OutlineInputBorder(),
//                   ),
//                 ),
                
//                 const SizedBox(height: 16),
                
//                 // Email field
//                 TextFormField(
//                   controller: _emailController,
//                   keyboardType: TextInputType.emailAddress,
//                   decoration: InputDecoration(
//                     labelText: 'Email',
//                     errorText: validationErrors['email'],
//                     border: const OutlineInputBorder(),
//                   ),
//                 ),
                
//                 const SizedBox(height: 16),
                
//                 // Password field
//                 TextFormField(
//                   controller: _passwordController,
//                   obscureText: true,
//                   decoration: InputDecoration(
//                     labelText: 'Password',
//                     errorText: validationErrors['password'],
//                     border: const OutlineInputBorder(),
//                   ),
//                 ),
                
//                 const SizedBox(height: 24),
                
//                 // Register button
//                 ElevatedButton(
//                   onPressed: isLoading ? null : _register,
//                   child: Text(isLoading ? 'Registering...' : 'Register'),
//                 ),
                
//                 const SizedBox(height: 16),
                
//                 // Show keyboard status
//                 if (keyboardVisible)
//                   const Card(
//                     color: Colors.blue,
//                     child: Padding(
//                       padding: EdgeInsets.all(8),
//                       child: Text(
//                         'Keyboard is visible',
//                         style: TextStyle(color: Colors.white),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                   ),
                
//                 // Hide keyboard button
//                 TextButton(
//                   onPressed: hideKeyboard,
//                   child: const Text('Hide Keyboard'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
  
//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
// }

// // 7. DIALOG HELPER MIXIN
// mixin DialogMixin<T extends StatefulWidget> on State<T> {
//   Future<bool?> showConfirmDialog({
//     required String title,
//     required String message,
//     String confirmText = 'Yes',
//     String cancelText = 'No',
//   }) {
//     return showDialog<bool>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(title),
//         content: Text(message),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(false),
//             child: Text(cancelText),
//           ),
//           ElevatedButton(
//             onPressed: () => Navigator.of(context).pop(true),
//             child: Text(confirmText),
//           ),
//         ],
//       ),
//     );
//   }
  
//   void showInfoDialog(String title, String message) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(title),
//         content: Text(message),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: const Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // 8. EXAMPLE WIDGET USING DIALOG MIXIN
// class SettingsScreen extends StatefulWidget {
//   const SettingsScreen({Key? key}) : super(key: key);
  
//   @override
//   State<SettingsScreen> createState() => _SettingsScreenState();
// }

// class _SettingsScreenState extends State<SettingsScreen>
//     with DialogMixin, SnackBarMixin {
  
//   Future<void> _deleteAccount() async {
//     final confirmed = await showConfirmDialog(
//       title: 'Delete Account',
//       message: 'Are you sure you want to delete your account? This action cannot be undone.',
//       confirmText: 'Delete',
//       cancelText: 'Cancel',
//     );
    
//     if (confirmed == true) {
//       showSuccessSnackBar('Account deletion initiated');
//     }
//   }
  
//   void _showAppInfo() {
//     showInfoDialog(
//       'About App',
//       'This is a Flutter app demonstrating mixin usage.\n\nVersion: 1.0.0',
//     );
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Settings'),
//       ),
//       body: ListView(
//         children: [
//           ListTile(
//             leading: const Icon(Icons.info),
//             title: const Text('About'),
//             onTap: _showAppInfo,
//           ),
//           const Divider(),
//           ListTile(
//             leading: const Icon(Icons.delete_forever, color: Colors.red),
//             title: const Text('Delete Account'),
//             titleTextStyle: const TextStyle(color: Colors.red),
//             onTap: _deleteAccount,
//           ),
//         ],
//       ),
//     );
//   }
// }

// // MAIN APP
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
  
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Mixin Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MainScreen(),
//     );
//   }
// }

// class MainScreen extends StatelessWidget {
//   const MainScreen({Key? key}) : super(key: key);
  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Flutter Mixin Examples'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => const UserRegistrationScreen(),
//                   ),
//                 );
//               },
//               child: const Text('User Registration (Multiple Mixins)'),
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => const SettingsScreen(),
//                   ),
//                 );
//               },
//               child: const Text('Settings (Dialog Mixin)'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// /*
// FLUTTER MIXIN BENEFITS:

// 1. REUSABLE UI LOGIC
//    ✅ Loading states across multiple screens
//    ✅ Error handling patterns
//    ✅ Form validation logic
//    ✅ Dialog and snackbar utilities

// 2. SEPARATION OF CONCERNS
//    ✅ Keep widget code focused on UI
//    ✅ Extract common functionality
//    ✅ Easier testing of individual mixins
//    ✅ Better code organization

// 3. COMMON FLUTTER MIXINS:
//    - TickerProviderStateMixin (animations)
//    - SingleTickerProviderStateMixin (single animation)
//    - AutomaticKeepAliveClientMixin (preserve state)
//    - WidgetsBindingObserver (app lifecycle)

// 4. BEST PRACTICES:
//    - Use mixins for cross-cutting UI concerns
//    - Keep mixins focused on one responsibility
//    - Document mixin dependencies
//    - Test mixins separately
//    - Consider state management alternatives for complex state

// 5. WHEN TO USE IN FLUTTER:
//    ✅ Common UI patterns (loading, error handling)
//    ✅ Form validation across multiple forms
//    ✅ Dialog and notification utilities
//    ✅ Keyboard and focus management
//    ✅ Animation helpers
//    ✅ Navigation patterns

// 6. AVOID:
//    ❌ Business logic in mixins
//    ❌ Heavy state management
//    ❌ Widget-specific logic
//    ❌ Complex dependencies between mixins
// */

// void main() {
//   runApp(const MyApp());
// }