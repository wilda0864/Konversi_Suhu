import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TemperatureConverter extends StatefulWidget {
  const TemperatureConverter({Key? key}) : super(key: key);

  @override
  _TemperatureConverterState createState() => _TemperatureConverterState();
}

class _TemperatureConverterState extends State<TemperatureConverter> {
  final TextEditingController _fahrenheitController = TextEditingController();
  final TextEditingController _celsiusController = TextEditingController();
  final TextEditingController _reamurController = TextEditingController();
  final TextEditingController _kelvinController = TextEditingController();
  bool _isDarkMode = false;

  void _convertFromFahrenheit(String value) {
    double fahrenheit = double.tryParse(value) ?? 0.0;
    setState(() {
      _celsiusController.text = ((fahrenheit - 32) * 5 / 9).toStringAsFixed(2);
      _reamurController.text = ((fahrenheit - 32) * 4 / 9).toStringAsFixed(2);
      _kelvinController.text = ((fahrenheit - 32) * 5 / 9 + 273.15).toStringAsFixed(2);
    });
  }

  void _convertFromCelsius(String value) {
    double celsius = double.tryParse(value) ?? 0.0;
    setState(() {
      _fahrenheitController.text = ((celsius * 9 / 5) + 32).toStringAsFixed(2);
      _reamurController.text = (celsius * 4 / 5).toStringAsFixed(2);
      _kelvinController.text = (celsius + 273.15).toStringAsFixed(2);
    });
  }

  void _convertFromReamur(String value) {
    double reamur = double.tryParse(value) ?? 0.0;
    setState(() {
      _fahrenheitController.text = ((reamur * 9 / 4) + 32).toStringAsFixed(2);
      _celsiusController.text = (reamur * 5 / 4).toStringAsFixed(2);
      _kelvinController.text = ((reamur * 5 / 4) + 273.15).toStringAsFixed(2);
    });
  }

  void _convertFromKelvin(String value) {
    double kelvin = double.tryParse(value) ?? 0.0;
    setState(() {
      _fahrenheitController.text = ((kelvin - 273.15) * 9 / 5 + 32).toStringAsFixed(2);
      _celsiusController.text = (kelvin - 273.15).toStringAsFixed(2);
      _reamurController.text = ((kelvin - 273.15) * 4 / 5).toStringAsFixed(2);
    });
  }

  void _resetFields() {
    _fahrenheitController.clear();
    _celsiusController.clear();
    _reamurController.clear();
    _kelvinController.clear();
  }

  Widget _buildTemperatureField(String label, TextEditingController controller, Function(String) onChanged, IconData icon) {
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
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*$'))
                ],
                decoration: InputDecoration(
                  labelText: label,
                  border: const OutlineInputBorder(),
                ),
                onChanged: onChanged,
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
        title: const Text('Konversi Suhu'),
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
      backgroundColor: _isDarkMode ? Colors.black : const Color.fromARGB(255, 66, 50, 191), // Ganti warna latar belakang di sini
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTemperatureField('Fahrenheit', _fahrenheitController, _convertFromFahrenheit, Icons.thermostat),
            _buildTemperatureField('Celsius', _celsiusController, _convertFromCelsius, Icons.thermostat),
            _buildTemperatureField('Reamur', _reamurController, _convertFromReamur, Icons.thermostat),
            _buildTemperatureField('Kelvin', _kelvinController, _convertFromKelvin, Icons.thermostat),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _resetFields,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Background color
                foregroundColor: Colors.white, // Text color
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
              child: const Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}