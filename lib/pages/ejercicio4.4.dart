import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Ejercicio4_4Pantalla extends StatefulWidget {
  const Ejercicio4_4Pantalla({super.key});

  @override
  State<Ejercicio4_4Pantalla> createState() => _Ejercicio44ScreenState();
}

class _Ejercicio44ScreenState extends State<Ejercicio4_4Pantalla> {
  final List<int> _numeros = [];
  final TextEditingController _numeroController = TextEditingController();

  int cantidadImpares = 0;
  double promedioPares = 0;
  int cantidadEnRango = 0;
  int numeroMaximo = 0;

  void _calcularResultados() {
    int sumaPares = 0;
    int conteoPares = 0;

    cantidadImpares = 0;
    cantidadEnRango = 0;
    numeroMaximo = _numeros.isNotEmpty ? _numeros[0] : 0;

    for (var numero in _numeros) {
      if (numero % 2 != 0) {
        cantidadImpares++;
      } else if (numero != 0) {
        sumaPares += numero;
        conteoPares++;
      }
      if (numero >= 13 && numero <= 24) {
        cantidadEnRango++;
      }
      if (numero > numeroMaximo) {
        numeroMaximo = numero;
      }
    }

    promedioPares = conteoPares > 0 ? sumaPares / conteoPares : 0;

    setState(() {});
  }

  void _agregarNumero() {
    int? numero = int.tryParse(_numeroController.text);
    if (numero == null || numero < 0 || numero > 36) {
      _mostrarAlerta("Número inválido", "Por favor, ingresa un número entre 0 y 36.");
      return;
    }

    setState(() {
      _numeros.add(numero);
      _numeroController.clear();
    });

    _calcularResultados();
  }

  void _mostrarAlerta(String titulo, String contenido) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(titulo),
        content: Text(contenido),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }

  void _limpiarDatos() {
    setState(() {
      _numeros.clear();
      cantidadImpares = 0;
      promedioPares = 0;
      cantidadEnRango = 0;
      numeroMaximo = 0;
    });
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
        title: const Text('Ejercicio 44: Análisis de Números'),
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ingrese números entre 0 y 36:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _numeroController,
              decoration: const InputDecoration(
                labelText: 'Número (0-36)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _agregarNumero,
              child: const Text('Agregar Número'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _limpiarDatos,
              child: const Text('Limpiar Datos'),
            ),
            ElevatedButton(
            onPressed: _salir,
            child: const Text("Volver al menú"),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
            const SizedBox(height: 20),
            if (_numeros.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Números ingresados:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Wrap(
                    spacing: 8.0,
                    children: _numeros.map((numero) {
                      return Chip(
                        label: Text(numero.toString()),
                      );
                    }).toList(),
                  ),
                ],
              ),
            const SizedBox(height: 20),
            if (_numeros.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Resultados:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text('Cantidad de números impares: $cantidadImpares'),
                  Text('Promedio de números pares: ${promedioPares.toStringAsFixed(2)}'),
                  Text('Cantidad de números en el rango 13-24: $cantidadEnRango'),
                  Text('Número más grande ingresado: $numeroMaximo'),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
