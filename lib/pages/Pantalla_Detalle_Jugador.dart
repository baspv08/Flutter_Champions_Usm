import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Pantalla_Detalle_Jugador extends StatelessWidget {
  final Map<String, dynamic> jugador;

  Pantalla_Detalle_Jugador({Key? key, required this.jugador}) : super(key: key);

  final DateFormat formatofecha = DateFormat('dd-MM-yyyy');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${jugador['Nombre']} ${jugador['Apellido']}'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            cajaTexto(
              icon: MdiIcons.account,
              label: 'Nombre Completo',
              value: '${jugador['Nombre']} ${jugador['Apellido']}',
            ),
            SizedBox(height: 16),
            cajaTexto(
              icon: MdiIcons.cake,
              label: 'Edad',
              value: '${jugador['Edad']} años',
            ),
            SizedBox(height: 16),
            cajaTexto(
              icon: MdiIcons.soccer,
              label: 'Equipo',
              value: '${jugador['Equipo']}',
            ),
            SizedBox(height: 16),
            cajaTexto(
              icon: MdiIcons.calendarAccount,
              label: 'Fecha de Nacimiento',
              value: formatofecha.format(jugador['Fecha de nacimiento'].toDate()),
            ),
          ],
        ),
      ),
    );
  }

  Widget cajaTexto({
    required IconData icon, 
    required String label, 
    required String value})
    {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 28, color: Colors.blue),
                SizedBox(width: 12),
                Text(
                  label,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
