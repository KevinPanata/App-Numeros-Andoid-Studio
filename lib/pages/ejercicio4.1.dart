import 'package:flutter/material.dart';
import 'dart:math'; // Importar para generar números aleatorios

class Ejercicio4_1Pantalla extends StatelessWidget {
  const Ejercicio4_1Pantalla({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Números Aleatorios Múltiplos de 5"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: GeneradorNumeros(),
      ),
    );
  }
}

class GeneradorNumeros extends StatefulWidget {
  const GeneradorNumeros({super.key});

  @override
  State<GeneradorNumeros> createState() => _GeneradorNumerosState();
}

class _GeneradorNumerosState extends State<GeneradorNumeros> {
  final Random _random = Random();
  List<int> _numerosGenerados = [];
  bool _mostrarBotones = true;

  void _generarNumero() {
    setState(() {
      int numero = _random.nextInt(100) * 5; // Genera múltiplos de 5
      _numerosGenerados.add(numero);
    });
  }

  void _salir() {
    setState(() {
      //direccionar a la pagina de inicio
      Navigator.pushNamed(context, '/');
      _mostrarBotones = false;
       // Oculta los botones y muestra el mensaje final
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (_numerosGenerados.isNotEmpty)
          Text(
            "Números generados:\n${_numerosGenerados.join(", ")}",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18),
          ),
        const SizedBox(height: 20),
        if (_mostrarBotones) ...[
          ElevatedButton(
            onPressed: _generarNumero,
            child: const Text("Generar número múltiplo de 5"),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _salir,
            child: const Text("Volver al menú"),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          ),
        ] else
          const Text(
            "Has salido de la generación de números.",
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
      ],
    );
  }
}

