import 'package:flutter/material.dart';
import 'pages/ejercicio4.1.dart';
import 'pages/ejercicio4.2.dart';
import 'pages/ejercicio4.3.dart';
import 'pages/ejercicio4.4.dart';
import 'pages/ejercicio4.5.dart';
import 'pages/ejercicio4.6.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ejercicios Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/', // Ruta inicial
      routes: {
        '/': (context) => const PantallaPrincipal(),
        '/ejercicio41': (context) => const Ejercicio4_1Pantalla(),
        '/ejercicio42': (context) => const Ejercicio4_2Pantalla(),
        '/ejercicio43': (context) => const Ejercicio4_3Pantalla(),
        '/ejercicio44': (context) => const Ejercicio4_4Pantalla(),
        '/ejercicio45': (context) => const Ejercicio4_5Pantalla(),
        '/ejercicio46': (context) => const Ejercicio4_6Pantalla(),
      },
    );
  }
}

// Pantalla principal con botones para cada ejercicio
class PantallaPrincipal extends StatelessWidget {
  const PantallaPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menú de Ejercicios"),
        backgroundColor: Colors.purple,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            leading: const Icon(Icons.code, color: Colors.deepPurple),
            title: const Text("Ejercicio 41: Números al azar"),
            onTap: () {
              Navigator.pushNamed(context, '/ejercicio41');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.format_list_numbered, color: Colors.deepPurple),
            title: const Text("Ejercicio 42: Determinar si un número es primo"),
            onTap: () {
              Navigator.pushNamed(context, '/ejercicio42');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.people, color: Colors.deepPurple),
            title: const Text("Ejercicio 43: Estadísticas de participantes"),
            onTap: () {
              Navigator.pushNamed(context, '/ejercicio43');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.calculate, color: Colors.deepPurple),
            title: const Text("Ejercicio 44: Análisis de números"),
            onTap: () {
              Navigator.pushNamed(context, '/ejercicio44');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.thermostat, color: Colors.deepPurple),
            title: const Text("Ejercicio 45: Temperaturas promedio"),
            onTap: () {
              Navigator.pushNamed(context, '/ejercicio45');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.summarize, color: Colors.deepPurple),
            title: const Text("Ejercicio 46: Suma y análisis de números"),
            onTap: () {
              Navigator.pushNamed(context, '/ejercicio46');
            },
          ),
        ],
      ),
    );
  }
}
