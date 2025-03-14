import 'package:flutter/material.dart';
import 'konversi.dart';
import 'package:flutter/services.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key});

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isDarkMode = false;
  String useremail = "wildaaurora4@gmail.com";
  String pass = "080604";
  String notif = " ";

  void login(String email, String password) {
    if (email == useremail && password == pass) {
      setState(() {
        notif = " ";
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const TemperatureConverter()),
      );
    } else {
      setState(() {
        notif = "Email atau password salah";
      });
    }
  }

  Widget _buildTextField(String label, TextEditingController controller, bool obscureText, IconData icon) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Icon(icon, color: Colors.blue),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: controller,
                obscureText: obscureText,
                keyboardType:
                    obscureText ? TextInputType.text : TextInputType.emailAddress,
                inputFormatters: obscureText
                    ? null
                    : [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
                decoration: InputDecoration(
                  labelText: label,
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        actions: [
          IconButton(
            icon: Icon(_isDarkMode ? Icons.wb_sunny : Icons.nights_stay),
            onPressed: () {
              setState(() {
                _isDarkMode = !_isDarkMode;
              });
            },
          ),
        ],
      ),
      backgroundColor: _isDarkMode ? Colors.black : const Color.fromARGB(255, 66, 50, 191),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTextField('Email', emailController, false, Icons.email),
            _buildTextField('Password', passwordController, true, Icons.lock),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => login(emailController.text, passwordController.text),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
              child: const Text('Login'),
            ),
            const SizedBox(height: 20),
            Text(
              notif,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}