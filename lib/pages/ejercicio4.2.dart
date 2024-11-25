import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Ejercicio4_2Pantalla extends StatefulWidget {
  const Ejercicio4_2Pantalla({super.key});

  @override
  State<Ejercicio4_2Pantalla> createState() => _Ejercicio42ScreenState();
}

class _Ejercicio42ScreenState extends State<Ejercicio4_2Pantalla> {
  final TextEditingController _controller = TextEditingController();
  bool? _esPrimo; // Variable para guardar el resultado de la verificación

  // Método para verificar si un número es primo
  bool esNumeroPrimo(int numero) {
    if (numero <= 1) return false;
    for (int i = 2; i <= numero ~/ 2; i++) {
      if (numero % i == 0) return false;
    }
    return true;
  }

void _salir() {
    setState(() {
      Navigator.pushNamed(context, '/');
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejercicio 42: Número Primo'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Verificar si un número es primo',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Ingrese un número',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly], // Solo números
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _verificar,
              child: const Text('Verificar'),
            ),
            ElevatedButton(
            onPressed: _salir,
            child: const Text("Volver al menú"),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          ),
            const SizedBox(height: 20.0),
            if (_esPrimo != null)
              Text(
                _esPrimo! ? 'El número es primo' : 'El número no es primo',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: _esPrimo! ? Colors.green : Colors.red,
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Método para verificar el número ingresado
  void _verificar() {
    int? numero = int.tryParse(_controller.text);

    if (numero != null) {
      setState(() {
        _esPrimo = esNumeroPrimo(numero);
      });
    } else {
      setState(() {
        _esPrimo = null;
      });

      // Mostrar un cuadro de diálogo en caso de entrada inválida
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Entrada inválida"),
          content: const Text("Por favor, ingresa un número válido."),
          actions: [
            TextButton(
              child: const Text("Aceptar"),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }
  }
}
