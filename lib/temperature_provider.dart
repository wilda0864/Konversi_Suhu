// temperature_provider.dart
import 'package:flutter/material.dart';

class TemperatureProvider extends ChangeNotifier {
  // Temperature conversion controllers
  final TextEditingController fahrenheitController = TextEditingController();
  final TextEditingController celsiusController = TextEditingController();
  final TextEditingController reamurController = TextEditingController();
  final TextEditingController kelvinController = TextEditingController();
  
  // Authentication-related properties
  String notificationMessage = "";
  final String validEmail = "wildaaurora4@gmail.com";
  final String validPassword = "080604";
  
  // Theme state
  bool isDarkMode = false;

  // Temperature conversion methods
  void convertFromFahrenheit(String value) {
    if (value.isEmpty) {
      resetFields();
      return;
    }
    
    double fahrenheit = double.tryParse(value) ?? 0.0;
    celsiusController.text = ((fahrenheit - 32) * 5 / 9).toStringAsFixed(2);
    reamurController.text = ((fahrenheit - 32) * 4 / 9).toStringAsFixed(2);
    kelvinController.text = ((fahrenheit - 32) * 5 / 9 + 273.15).toStringAsFixed(2);
    notifyListeners();
  }

  void convertFromCelsius(String value) {
    if (value.isEmpty) {
      resetFields();
      return;
    }
    
    double celsius = double.tryParse(value) ?? 0.0;
    fahrenheitController.text = ((celsius * 9 / 5) + 32).toStringAsFixed(2);
    reamurController.text = (celsius * 4 / 5).toStringAsFixed(2);
    kelvinController.text = (celsius + 273.15).toStringAsFixed(2);
    notifyListeners();
  }

  void convertFromReamur(String value) {
    if (value.isEmpty) {
      resetFields();
      return;
    }
    
    double reamur = double.tryParse(value) ?? 0.0;
    fahrenheitController.text = ((reamur * 9 / 4) + 32).toStringAsFixed(2);
    celsiusController.text = (reamur * 5 / 4).toStringAsFixed(2);
    kelvinController.text = ((reamur * 5 / 4) + 273.15).toStringAsFixed(2);
    notifyListeners();
  }

  void convertFromKelvin(String value) {
    if (value.isEmpty) {
      resetFields();
      return;
    }
    
    double kelvin = double.tryParse(value) ?? 0.0;
    fahrenheitController.text = ((kelvin - 273.15) * 9 / 5 + 32).toStringAsFixed(2);
    celsiusController.text = (kelvin - 273.15).toStringAsFixed(2);
    reamurController.text = ((kelvin - 273.15) * 4 / 5).toStringAsFixed(2);
    notifyListeners();
  }

  void resetFields() {
    fahrenheitController.clear();
    celsiusController.clear();
    reamurController.clear();
    kelvinController.clear();
    notifyListeners();
  }

  // Authentication method
  bool login(String email, String password) {
    if (email == validEmail && password == validPassword) {
      notificationMessage = "";
      notifyListeners();
      return true;
    } else {
      notificationMessage = "Email atau password salah";
      notifyListeners();
      return false;
    }
  }

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }
  
  @override
  void dispose() {
    fahrenheitController.dispose();
    celsiusController.dispose();
    reamurController.dispose();
    kelvinController.dispose();
    super.dispose();
  }
}