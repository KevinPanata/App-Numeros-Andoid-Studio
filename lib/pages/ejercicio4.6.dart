import 'package:flutter/material.dart';

class Ejercicio4_6Pantalla extends StatefulWidget {
  const Ejercicio4_6Pantalla({super.key});

  @override
  _Ejercicio4_6PantallaState createState() => _Ejercicio4_6PantallaState();
}

class _Ejercicio4_6PantallaState extends State<Ejercicio4_6Pantalla> {
  final TextEditingController _numeroController = TextEditingController();
  int _suma = 0;
  int _multiplosDe6 = 0;
  int _sumaEntre1y10 = 0;
  List<int> _numerosIngresados = []; // Lista para guardar los números ingresados

  void _agregarNumero() {
    int numero = int.tryParse(_numeroController.text) ?? 0;

    if (numero == 0) {
      return;
    }

    _numerosIngresados.add(numero); // Agregar el número a la lista
    _suma += numero;

    if (numero % 6 == 0) {
      _multiplosDe6++;
    }

    if (numero >= 1 && numero <= 10) {
      _sumaEntre1y10 += numero;
    }

    if (_suma >= 1000) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Resultado"),
          content: Text(
              "Suma total: $_suma\nMúltiplos de 6: $_multiplosDe6\nSuma entre 1 y 10: $_sumaEntre1y10"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _reiniciar();
              },
              child: const Text("Cerrar"),
            ),
          ],
        ),
      );
    }

    _numeroController.clear();
    setState(() {});
  }

  void _reiniciar() {
    _suma = 0;
    _multiplosDe6 = 0;
    _sumaEntre1y10 = 0;
    _numerosIngresados.clear(); // Vaciar la lista de números
  }

  void _salir() {
    Navigator.pushNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ejercicio 46: Suma y análisis de números"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _numeroController,
              decoration: const InputDecoration(labelText: "Ingrese un número"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _agregarNumero,
              child: const Text("Agregar Número"),
            ),
            ElevatedButton(
              onPressed: _salir,
              child: const Text("Volver al menú"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
            const SizedBox(height: 20),
            Text("Suma total: $_suma"),
            Text("Múltiplos de 6: $_multiplosDe6"),
            Text("Suma entre 1 y 10: $_sumaEntre1y10"),
            const SizedBox(height: 20),
            const Text(
              "Números ingresados:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _numerosIngresados.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_numerosIngresados[index].toString()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
