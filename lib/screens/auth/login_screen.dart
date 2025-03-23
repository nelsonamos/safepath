import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'register_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';  // Import Fluttertoast
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isObscure = true;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize Animation Controller
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    // Slide Animation
    _slideAnimation = Tween<Offset>(begin: Offset(0, 1), end: Offset.zero).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    // Fade Animation
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    // Start Animation
    _animationController.forward();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }



  Future<void> _login(BuildContext context) async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    try {
      // Query Firestore for user details
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('user')
          .where('email', isEqualTo: email)
          .get();

      if (snapshot.docs.isNotEmpty) {
        var userData = snapshot.docs.first.data() as Map<String, dynamic>;
        var userId = snapshot.docs.first.id;

        if (userData['password'] == password) {
          // Save user details locally
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('userId', userId);
          await prefs.setString('email', email);
          await prefs.setString('userName', userData['name'] ?? '');
          await prefs.setString('sobrietyDate', userData['sobrietyDate'] ?? '');

          // Update `isOnline` to true
          await FirebaseFirestore.instance.collection('user').doc(userId).update({
            'isOnline': true,
          });

          // Navigate to home
          Navigator.pushReplacementNamed(context, '/home');

          Fluttertoast.showToast(
            msg: "Login Successful!",
            backgroundColor: Colors.green,
            textColor: Colors.white,
          );
        } else {
          Fluttertoast.showToast(msg: "Incorrect password.", backgroundColor: Colors.red);
        }
      } else {
        Fluttertoast.showToast(msg: "User with this email does not exist.", backgroundColor: Colors.red);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "An error occurred: ${e.toString()}", backgroundColor: Colors.red);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/login.png'),  // Path to your background image
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Email TextField
                      _buildAnimatedTextField(
                        label: 'Email',
                        controller: emailController,
                        isPassword: false,
                      ),
                      SizedBox(height: 16),

                      // Password TextField
                      _buildAnimatedTextField(
                        label: 'Password',
                        controller: passwordController,
                        isPassword: true,
                      ),
                      SizedBox(height: 24),

                      // Login Button
                      GestureDetector(
                        onTapDown: (_) {
                          setState(() {});
                        },
                        onTapUp: (_) {
                          setState(() {
                            _login(context);
                          });
                        },
                        child: ElevatedButton(
                          onPressed: () {
                            _login(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            padding: EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 5,
                          ),
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                      ),
                      SizedBox(height: 16),

                      // Don't have an account? Register Button
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) =>
                                  RegisterScreen(),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                const begin = Offset(1.0, 0.0);
                                const end = Offset.zero;
                                const curve = Curves.easeInOut;

                                var tween = Tween(begin: begin, end: end)
                                    .chain(CurveTween(curve: curve));
                                var offsetAnimation = animation.drive(tween);

                                return SlideTransition(
                                  position: offsetAnimation,
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                        child: Text(
                          'Don’t have an account? Register',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      // Sample Button to Navigate to Home Page
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to Home Page
                          Navigator.pushReplacementNamed(context, '/home');
                        },
                        child: Text('Go to Home Page'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedTextField({
    required String label,
    required TextEditingController controller,
    required bool isPassword,
  }) {
    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {});
      },
      child: TextField(
        controller: controller,
        obscureText: isPassword ? _isObscure : false,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
          suffixIcon: isPassword
              ? IconButton(
            icon: Icon(
              _isObscure ? Icons.visibility : Icons.visibility_off,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () {
              setState(() {
                _isObscure = !_isObscure;
              });
            },
          )
              : null,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2.0),
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        ),
      ),
    );
  }
}
