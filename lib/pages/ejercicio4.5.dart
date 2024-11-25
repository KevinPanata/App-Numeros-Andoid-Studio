import 'package:flutter/material.dart';

class Ejercicio4_5Pantalla extends StatefulWidget {
  const Ejercicio4_5Pantalla({super.key});

  @override
  _Ejercicio4_5PantallaState createState() => _Ejercicio4_5PantallaState();
}

class _Ejercicio4_5PantallaState extends State<Ejercicio4_5Pantalla> {
  final TextEditingController _temp1Controller = TextEditingController();
  final TextEditingController _temp2Controller = TextEditingController();

  double _suma = 0;
  int _contador = 0;
  bool _finalizado = false;
  List<double> _temperaturasValidas = [];
  List<double> _temperaturasFueraDeRango = [];

  void _calcularPromedio() {
    double t1 = double.tryParse(_temp1Controller.text) ?? 0;
    double t2 = double.tryParse(_temp2Controller.text) ?? 0;

    if (t1 == 0) {
      // Marcar como finalizado y detener el ingreso
      setState(() {
        _finalizado = true;
      });
      return;
    }

    // Procesar T1
    if (t1 >= 5 && t1 <= 15) {
      _suma += t1;
      _contador++;
      _temperaturasValidas.add(t1);
    } else {
      _temperaturasFueraDeRango.add(t1);
    }

    // Procesar T2 solo si T1 no es 0
    if (t2 >= 5 && t2 <= 15) {
      _suma += t2;
      _contador++;
      _temperaturasValidas.add(t2);
    } else {
      _temperaturasFueraDeRango.add(t2);
    }

    // Limpiar campos de entrada
    _temp1Controller.clear();
    _temp2Controller.clear();

    setState(() {});
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
        title: const Text("Ejercicio 45: Temperaturas promedio"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!_finalizado) ...[
              TextField(
                controller: _temp1Controller,
                decoration: const InputDecoration(labelText: "Temperatura T1"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _temp2Controller,
                decoration: const InputDecoration(labelText: "Temperatura T2"),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _calcularPromedio,
                child: const Text("Ingresar Temperaturas"),
              ),
              ElevatedButton(
            onPressed: _salir,
            child: const Text("Volver al menú"),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
            ],
            if (_finalizado) ...[
              const Text(
                "Ingreso finalizado. Resultado:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                "Promedio: ${_contador > 0 ? (_suma / _contador).toStringAsFixed(2) : 'N/A'}",
                style: const TextStyle(fontSize: 18),
              ),
            ],
            const SizedBox(height: 20),
            const Text(
              "Temperaturas válidas (5° - 15°):",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _temperaturasValidas.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("${_temperaturasValidas[index]}°C"),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Temperaturas fuera de rango:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _temperaturasFueraDeRango.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("${_temperaturasFueraDeRango[index]}°C"),
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
