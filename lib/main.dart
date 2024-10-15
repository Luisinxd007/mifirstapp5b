import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Persona> _personas = [
    Persona('Luis Antonio', 'Torres', '20182065'),
    Persona('Luis Jose', 'Moran', '20182589'),
    Persona('Diego Andres', 'Denis', '20184521'),
    Persona('Jesus Fernando', 'Palomino', '20182567'),
    Persona('Ivan Elias', 'Chavez', '20185431'),
  ];

  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _cuentaController = TextEditingController();

  void _agregarPersona() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Agregar Persona'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                controller: _apellidoController,
                decoration: const InputDecoration(labelText: 'Apellido'),
              ),
              TextField(
                controller: _cuentaController,
                decoration: const InputDecoration(labelText: 'Cuenta'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                if (_nombreController.text.isNotEmpty &&
                    _apellidoController.text.isNotEmpty &&
                    _cuentaController.text.isNotEmpty) {
                  setState(() {
                    _personas.add(Persona(
                      _nombreController.text,
                      _apellidoController.text,
                      _cuentaController.text,
                    ));
                  });
                  _nombreController.clear();
                  _apellidoController.clear();
                  _cuentaController.clear();
                }
                Navigator.of(context).pop();
              },
              child: const Text('Agregar'),
            ),
          ],
        );
      },
    );
  }

  void _mostrarDialogoEliminar(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Eliminar Persona'),
          content:
              const Text('¿Estás seguro de que deseas eliminar esta persona?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _personas.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi primer App en Flutter'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: _agregarPersona,
        child: const Icon(Icons.people_alt_outlined),
      ),
      body: ListView.builder(
        itemCount: _personas.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title:
                Text('${_personas[index].name} ${_personas[index].lastname}'),
            subtitle: Text(_personas[index].cuenta),
            leading: CircleAvatar(
              child: Text(_personas[index].name.substring(0, 1)),
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              _mostrarDialogoEliminar(index);
            },
          );
        },
      ),
    );
  }
}

class Persona {
  String name;
  String lastname;
  String cuenta;
  Persona(this.name, this.lastname, this.cuenta);
}
