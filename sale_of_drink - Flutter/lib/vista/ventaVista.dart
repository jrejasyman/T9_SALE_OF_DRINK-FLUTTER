import 'package:flutter/material.dart';
import 'package:sale_of_drink/modelo/venta.dart';

import '../services/ventaService.dart';

class ventaVista extends StatefulWidget {
  const ventaVista({super.key});

  @override
  _ListaVentaState VentacreateState() => _ListaVentaState();

  @override
  // TODO: implement createState
  State<StatefulWidget> get createState => _ListaVentaState();
}

class _ListaVentaState extends State<ventaVista> {
  final _ventaService = VentaService();
  late Future<List<Venta>> _ventaFuture;
  @override
  void initState() {
    super.initState();
    _ventaFuture = _ventaService.fetchVenta();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LISTA DE VENTAS REGISTRADAS'),
      ),
      body: FutureBuilder<List<Venta>>(
        future: _ventaFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final venta = snapshot.data!;
            return ListView.builder(
              itemCount: venta.length,
              itemBuilder: (context, index) {
                final ventas = venta[index];
                return ListTile(
                  title: Text(
                      '${ventas.idven}   :     ${ventas.fecven}      ${ventas.tippagven}        ${ventas.estven}'),
                  onTap: () {
                    // Handle tapping on the venta item
                    _showVentaDialog(ventas);
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
          // Handle adding a new venta
          _showVentaDialog(null);
        },
      ),
    );
  }

  Future<void> _showVentaDialog(Venta? vent) async {
    final isEditing = vent != null;
    final title = isEditing ? 'Editar' : 'Agregar';
    final TextEditingController fecvenController =
        TextEditingController(text: vent?.fecven);
    final TextEditingController tippagvenController =
        TextEditingController(text: vent?.tippagven);
    final TextEditingController estvenController =
        TextEditingController(text: vent?.estven);

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: fecvenController,
                  decoration: const InputDecoration(labelText: 'Fecha'),
                ),
                TextField(
                  controller: tippagvenController,
                  decoration: const InputDecoration(labelText: 'Tipo de Pago'),
                ),
                TextField(
                  controller: estvenController,
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
                final newVenta = Venta(
                  idven: 0,
                  fecven: fecvenController.text,
                  tippagven: tippagvenController.text,
                  estven: estvenController.text,
                );

                if (isEditing) {
                  // Handle updating the persona
                  _updateVent(newVenta);
                } else {
                  // Handle adding a new persona
                  _addVent(newVenta);
                }

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _addVent(Venta vent) async {
    // Handle adding a new venta
    try {
      await _ventaService.createVenta(vent);
      // Refresh the list of venta
      setState(() {
        _ventaFuture = _ventaService.fetchVenta();
      });
    } catch (e) {
      // Handle error
      print('Error adding Venta: $e');
    }
  }

  Future<void> _updateVent(Venta vent) async {
    // Handle updating the Venta
    try {
      await _ventaService.updateVenta(vent);
      // Refresh the list of Venta
      setState(() {
        _ventaFuture = _ventaService.fetchVenta();
      });
    } catch (e) {
      // Handle error
      print('Error updating Venta: $e');
    }
  }
}

class paginaAnterior extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('REGISTRO DE CLIENTES')),
      body: Center(
        child: ElevatedButton(
          child: Text('Regresar'),
          onPressed: () {
            // Go back to the previous screen
            Navigator.pop(context,
                MaterialPageRoute(builder: (context) => paginaAnterior()));
          },
        ),
      ),
    );
  }
}
