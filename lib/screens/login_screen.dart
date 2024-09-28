import "package:flutter/material.dart";
import "package:malopolskie_dwa_kolka/widgets/appbar.dart";

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bike Themed Login'),
        centerTitle: true,
        backgroundColor: Colors.green[700],  // Bike theme color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Bike icon or image at the top
            Icon(
              Icons.directions_bike,
              size: 100,
              color: Colors.green[700],
            ),
            SizedBox(height: 20),

            // Username (email) input field
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
            ),
            SizedBox(height: 20),

            // Password input field
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            SizedBox(height: 20),

            // Login button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.green[700], // Set the button's background color
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Rounded corners
                ),
              ),
              onPressed: () {
                // Handle login action
                print('Login Pressed');
              },
              child: Text(
                'Login',
                style: TextStyle(fontSize: 18),
              ),
            ),

            SizedBox(height: 20),

            // Extra: Forgot Password or Sign up link
            TextButton(
              onPressed: () {
                // Navigate to the Forgot Password page or Sign Up page
              },
              child: Text(
                'Forgot Password?',
                style: TextStyle(color: Colors.green[700]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
