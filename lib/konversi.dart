// konversi.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'temperature_provider.dart';

class TemperatureConverter extends StatelessWidget {
  const TemperatureConverter({Key? key}) : super(key: key);

  Widget _buildTemperatureField(
    String label, 
    TextEditingController controller, 
    Function(String) onChanged, 
    IconData icon
  ) {
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
    return Consumer<TemperatureProvider>(
      builder: (context, tempProvider, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Konversi Suhu'),
            actions: [
              IconButton(
                icon: Icon(tempProvider.isDarkMode ? Icons.wb_sunny : Icons.nights_stay),
                onPressed: () => tempProvider.toggleTheme(),
              ),
            ],
          ),
          backgroundColor: tempProvider.isDarkMode 
              ? Colors.black 
              : const Color.fromARGB(255, 66, 50, 191),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTemperatureField(
                  'Fahrenheit', 
                  tempProvider.fahrenheitController, 
                  tempProvider.convertFromFahrenheit, 
                  Icons.thermostat
                ),
                _buildTemperatureField(
                  'Celsius', 
                  tempProvider.celsiusController, 
                  tempProvider.convertFromCelsius, 
                  Icons.thermostat
                ),
                _buildTemperatureField(
                  'Reamur', 
                  tempProvider.reamurController, 
                  tempProvider.convertFromReamur, 
                  Icons.thermostat
                ),
                _buildTemperatureField(
                  'Kelvin', 
                  tempProvider.kelvinController, 
                  tempProvider.convertFromKelvin, 
                  Icons.thermostat
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => tempProvider.resetFields(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  ),
                  child: const Text('Reset'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}