// login_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'temperature_provider.dart';
import 'konversi.dart';

class MyLoginPage extends StatelessWidget {
  const MyLoginPage({Key? key}) : super(key: key);

  Widget _buildTextField(String label, bool obscureText, IconData icon) {
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
                controller: null, // We'll use local controllers
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    
    return Consumer<TemperatureProvider>(
      builder: (context, temperatureProvider, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Login'),
            actions: [
              IconButton(
                icon: Icon(temperatureProvider.isDarkMode ? Icons.wb_sunny : Icons.nights_stay),
                onPressed: () => temperatureProvider.toggleTheme(),
              ),
            ],
          ),
          backgroundColor: temperatureProvider.isDarkMode 
              ? Colors.black 
              : const Color.fromARGB(255, 66, 50, 191),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Icon(Icons.email, color: Colors.blue),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: emailController,
                            obscureText: false,
                            keyboardType: TextInputType.emailAddress,
                            inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Icon(Icons.lock, color: Colors.blue),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (temperatureProvider.login(emailController.text, passwordController.text)) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const TemperatureConverter()),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  ),
                  child: const Text('Login'),
                ),
                const SizedBox(height: 20),
                Text(
                  temperatureProvider.notificationMessage,
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
      },
    );
  }
}