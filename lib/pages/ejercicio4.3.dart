import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Ejercicio4_3Pantalla extends StatefulWidget {
  const Ejercicio4_3Pantalla({super.key});

  @override
  State<Ejercicio4_3Pantalla> createState() => _Ejercicio43ScreenState();
}

class _Ejercicio43ScreenState extends State<Ejercicio4_3Pantalla> {
  final List<Map<String, dynamic>> _participantes = [];
  final TextEditingController _alturaController = TextEditingController();
  final TextEditingController _edadController = TextEditingController();
  final TextEditingController _sexoController = TextEditingController();

  double? promedioAlturaMujeres;
  double? promedioAlturaHombres;
  double? promedioEdad;

  // Calcular los promedios de altura y edad
  void _calcularPromedios() {
    double sumaAlturaMujeres = 0, sumaAlturaHombres = 0, sumaEdades = 0;
    int mujeresCount = 0, hombresCount = 0;

    for (var participante in _participantes) {
      sumaEdades += participante['edad'];
      if (participante['sexo'] == 'F') {
        sumaAlturaMujeres += participante['altura'];
        mujeresCount++;
      } else if (participante['sexo'] == 'M') {
        sumaAlturaHombres += participante['altura'];
        hombresCount++;
      }
    }

    setState(() {
      promedioAlturaMujeres =
          mujeresCount > 0 ? sumaAlturaMujeres / mujeresCount : null;
      promedioAlturaHombres =
          hombresCount > 0 ? sumaAlturaHombres / hombresCount : null;
      promedioEdad = _participantes.isNotEmpty
          ? sumaEdades / _participantes.length
          : null;
    });
  }

  // Agregar un nuevo participante
  void _agregarParticipante() {
    double? altura = double.tryParse(_alturaController.text);
    int? edad = int.tryParse(_edadController.text);
    String sexo = _sexoController.text.toUpperCase();

    if (altura == null || edad == null || (sexo != 'F' && sexo != 'M')) {
      _mostrarAlerta("Datos inválidos", "Por favor, ingresa datos válidos.");
      return;
    }

    if (altura < 0) {
      _calcularPromedios(); // Calcular promedios al ingresar altura negativa
      return;
    }

    setState(() {
      _participantes.add({'altura': altura, 'edad': edad, 'sexo': sexo});
      _alturaController.clear();
      _edadController.clear();
      _sexoController.clear();
      _calcularPromedios(); // Calcular promedios tras agregar un participante
    });
  }

  // Mostrar alerta
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

  // Limpiar datos
  void _limpiarDatos() {
    setState(() {
      _participantes.clear();
      promedioAlturaMujeres = null;
      promedioAlturaHombres = null;
      promedioEdad = null;
    });
  }

  void _salir() {
    Navigator.pushNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejercicio 43: Promedio Estadístico'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ingrese los datos de los participantes:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _alturaController,
              decoration: const InputDecoration(
                labelText: 'Altura (cm)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _edadController,
              decoration: const InputDecoration(
                labelText: 'Edad',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _sexoController,
              decoration: const InputDecoration(
                labelText: 'Sexo (F/M)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _agregarParticipante,
              child: const Text('Agregar Participante'),
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
            if (promedioAlturaMujeres != null ||
                promedioAlturaHombres != null ||
                promedioEdad != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (promedioAlturaMujeres != null)
                    Text(
                      'Promedio altura Mujeres: ${promedioAlturaMujeres!.toStringAsFixed(2)} cm',
                      style: const TextStyle(fontSize: 16),
                    ),
                  if (promedioAlturaHombres != null)
                    Text(
                      'Promedio altura Hombres: ${promedioAlturaHombres!.toStringAsFixed(2)} cm',
                      style: const TextStyle(fontSize: 16),
                    ),
                  if (promedioEdad != null)
                    Text(
                      'Promedio Edad: ${promedioEdad!.toStringAsFixed(2)} años',
                      style: const TextStyle(fontSize: 16),
                    ),
                ],
              ),
            const SizedBox(height: 20),
            if (_participantes.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Lista de Participantes:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  DataTable(
                    columns: const [
                      DataColumn(label: Text('Altura')),
                      DataColumn(label: Text('Edad')),
                      DataColumn(label: Text('Sexo')),
                    ],
                    rows: _participantes
                        .map(
                          (p) => DataRow(
                            cells: [
                              DataCell(Text(p['altura'].toString())),
                              DataCell(Text(p['edad'].toString())),
                              DataCell(Text(p['sexo'])),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
