import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de IMC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const IMCScreen(),
    );
  }
}

class IMCScreen extends StatefulWidget {
  const IMCScreen({super.key});

  @override
  State<IMCScreen> createState() => _IMCScreenState();
}

class _IMCScreenState extends State<IMCScreen> {
  final _formKey = GlobalKey<FormState>();
  final _pesoController = TextEditingController();
  final _alturaController = TextEditingController();

  String _resultado = '';
  String _categoria = '';
  Color _colorCategoria = Colors.black;
  String _icono = '';
  double _imcValor = 0;
  bool _mostrarResultado = false;

  // ─── Lógica IMC ───────────────────────────────────────────
  void _calcularIMC() {
    if (_formKey.currentState!.validate()) {
      final double peso = double.parse(_pesoController.text);
      final double altura = double.parse(_alturaController.text);
      final double imc = peso / (altura * altura);

      String categoria;
      Color color;
      String icono;

      if (imc < 18.5) {
        categoria = 'Bajo peso';
        color = Colors.blue;
        icono = '🧊';
      } else if (imc < 25.0) {
        categoria = 'Peso normal';
        color = Colors.green;
        icono = '✅';
      } else if (imc < 30.0) {
        categoria = 'Sobrepeso';
        color = Colors.red;
        icono = '⚠️';
      } else {
        categoria = 'Obesidad';
        color = const Color(0xFF8B0000);
        icono = '🚨';
      }

      setState(() {
        _imcValor = imc;
        _resultado = 'Tu IMC es: ${imc.toStringAsFixed(2)}';
        _categoria = 'Categoría: $categoria';
        _colorCategoria = color;
        _icono = icono;
        _mostrarResultado = true;
      });
    }
  }

  // ─── Limpiar campos ───────────────────────────────────────
  void _limpiar() {
    _formKey.currentState!.reset();
    _pesoController.clear();
    _alturaController.clear();
    setState(() {
      _resultado = '';
      _categoria = '';
      _icono = '';
      _imcValor = 0;
      _mostrarResultado = false;
    });
  }

  // ─── Barra de progreso IMC ────────────────────────────────
  double get _imcProgreso {
    // Escala de 10 a 40 → 0.0 a 1.0
    final clamped = _imcValor.clamp(10.0, 40.0);
    return (clamped - 10) / 30;
  }

  @override
  void dispose() {
    _pesoController.dispose();
    _alturaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de IMC'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Ingresa tu peso y altura para calcular tu IMC.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),

              // ── Campo Peso ──────────────────────────────────
              TextFormField(
                controller: _pesoController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                ],
                decoration: const InputDecoration(
                  labelText: 'Peso (kg)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.monitor_weight),
                  helperText: 'Ingresa tu peso entre 1 y 500 kg',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El campo no puede estar vacío';
                  }
                  final numero = double.tryParse(value);
                  if (numero == null) {
                    return 'Ingresa un número válido';
                  }
                  if (numero <= 0) {
                    return 'El peso debe ser un valor positivo';
                  }
                  if (numero < 1 || numero > 500) {
                    return 'El peso debe estar entre 1 y 500 kg';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // ── Campo Altura ────────────────────────────────
              TextFormField(
                controller: _alturaController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                ],
                decoration: const InputDecoration(
                  labelText: 'Altura (m)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.height),
                  helperText: 'Ingresa tu altura entre 0.5 y 3.0 m',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El campo no puede estar vacío';
                  }
                  final numero = double.tryParse(value);
                  if (numero == null) {
                    return 'Ingresa un número válido';
                  }
                  if (numero <= 0) {
                    return 'La altura debe ser un valor positivo';
                  }
                  if (numero < 0.5 || numero > 3.0) {
                    return 'La altura debe estar entre 0.5 y 3.0 m';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // ── Botones ─────────────────────────────────────
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _calcularIMC,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Calcular IMC', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: _limpiar,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                      backgroundColor: Colors.grey.shade300,
                      foregroundColor: Colors.black87,
                    ),
                    child: const Icon(Icons.refresh),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // ── Resultado ───────────────────────────────────
              if (_mostrarResultado) ...[
                // Ícono de categoría
                Text(
                  _icono,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 48),
                ),
                const SizedBox(height: 8),

                // Texto IMC y categoría
                Text(
                  _resultado,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: _colorCategoria,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _categoria,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: _colorCategoria,
                  ),
                ),
                const SizedBox(height: 20),

                // ── Barra de progreso IMC ───────────────────
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Posición en la escala IMC (10 - 40):',
                      style: TextStyle(fontSize: 13, color: Colors.black54),
                    ),
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: _imcProgreso,
                        minHeight: 16,
                        backgroundColor: Colors.grey.shade200,
                        valueColor: AlwaysStoppedAnimation<Color>(_colorCategoria),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('10', style: TextStyle(fontSize: 11, color: Colors.black45)),
                        Text('18.5', style: TextStyle(fontSize: 11, color: Colors.black45)),
                        Text('25', style: TextStyle(fontSize: 11, color: Colors.black45)),
                        Text('30', style: TextStyle(fontSize: 11, color: Colors.black45)),
                        Text('40', style: TextStyle(fontSize: 11, color: Colors.black45)),
                      ],
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}