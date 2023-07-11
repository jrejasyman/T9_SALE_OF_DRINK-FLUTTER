import 'package:flutter/material.dart';
import 'package:sale_of_drink/modelo/Persona.dart';
import 'package:sale_of_drink/vista/ventaVista.dart';

import '../services/personaService.dart';

class personaVista extends StatefulWidget {
  @override
  _ListaPersonaState PersonacreateState() => _ListaPersonaState();

  @override
  // TODO: implement createState
  State<StatefulWidget> get createState => _ListaPersonaState();
}

class _ListaPersonaState extends State<personaVista> {
  final _personaService = PersonaService();
  late Future<List<Persona>> _personaFuture;
  @override
  void initState() {
    super.initState();
    _personaFuture = _personaService.fetchPersona();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' LISTA DE CLIENTES REGISTRADOS'),
        actions: [
          ElevatedButton(
            child: Text('Siguiente'),
            onPressed: () {
              // Navigate to the next screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ventaVista()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Persona>>(
        future: _personaFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final persona = snapshot.data!;
            return ListView.builder(
              itemCount: persona.length,
              itemBuilder: (context, index) {
                final personas = persona[index];
                return ListTile(
                  title: Text(
                      '${personas.idper} ${personas.nomper} ${personas.apeper} ${personas.celper} ${personas.corper}  ${personas.dniper} ${personas.estper}'),
                  onTap: () {
                    // Handle tapping on the person item
                    _showPersonDialog(personas);
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // Handle adding a new person
          _showPersonDialog(null);
        },
      ),
    );
  }

  Future<void> _showPersonDialog(Persona? person) async {
    final isEditing = person != null;
    final title = isEditing ? 'Editar' : 'Agregar';
    final TextEditingController nomperController =
        TextEditingController(text: person?.nomper);
    final TextEditingController apeperController =
        TextEditingController(text: person?.apeper);
    final TextEditingController celperController =
        TextEditingController(text: person?.celper);
    final TextEditingController corperController =
        TextEditingController(text: person?.corper);
    final TextEditingController dniperController =
        TextEditingController(text: person?.dniper);
    final TextEditingController estperController =
        TextEditingController(text: person?.estper);

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nomperController,
                  decoration: const InputDecoration(labelText: 'Nombres'),
                ),
                TextField(
                  controller: apeperController,
                  decoration: const InputDecoration(labelText: 'Apellidos'),
                ),
                TextField(
                  controller: celperController,
                  decoration: const InputDecoration(labelText: 'Celular'),
                ),
                TextField(
                  controller: corperController,
                  decoration: const InputDecoration(labelText: 'Correo'),
                ),
                TextField(
                  controller: dniperController,
                  decoration:
                      const InputDecoration(labelText: 'Doc. Identidad'),
                ),
                TextField(
                  controller: estperController,
                  decoration: const InputDecoration(labelText: 'Estado'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(isEditing ? 'Acualizar' : 'Agregar'),
              onPressed: () {
                final newPersona = Persona(
                  idper: 0,
                  nomper: nomperController.text,
                  apeper: apeperController.text,
                  celper: celperController.text,
                  corper: corperController.text,
                  dniper: dniperController.text,
                  estper: estperController.text,
                );

                if (isEditing) {
                  // Handle updating the person
                  _updatePerson(newPersona);
                } else {
                  // Handle adding a new person
                  _addPerson(newPersona);
                }

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _addPerson(Persona person) async {
    // Handle adding a new person
    try {
      await _personaService.createPersona(person);
      // Refresh the list of persons
      setState(() {
        _personaFuture = _personaService.fetchPersona();
      });
    } catch (e) {
      // Handle error
      print('Error adding person: $e');
    }
  }

  Future<void> _updatePerson(Persona person) async {
    // Handle updating the person
    try {
      await _personaService.updatePersona(person);
      // Refresh the list of persons
      setState(() {
        _personaFuture = _personaService.fetchPersona();
      });
    } catch (e) {
      // Handle error
      print('Error updating person: $e');
    }
  }
}
