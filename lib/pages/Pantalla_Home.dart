import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_champions/pages/Pantalla_Agregar_Jugador.dart';
import 'package:flutter_champions/pages/Pantalla_Detalle_Jugador.dart';
import 'package:flutter_champions/services/firestore_service.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Pantalla_Home extends StatefulWidget {
  const Pantalla_Home({super.key});

  @override
  State<Pantalla_Home> createState() => _Pantalla_HomeState();
}

class _Pantalla_HomeState extends State<Pantalla_Home> {
  DateTime fecha_de_nacimiento = DateTime.now();
  final formatofecha = DateFormat('dd-MM-yyyy');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Champions League'),
        leading: Icon(MdiIcons.soccer, color: Colors.white,),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: StreamBuilder(
          stream: FirestoreService().Jugadores(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting){
            //esperando datos
            return Center(child: CircularProgressIndicator());
          }else{
            //datos llegaron, mostrar en pagina
            return ListView.separated(
              separatorBuilder: (context, index) => Divider(),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index){
                var jugadores = snapshot.data!.docs[index];
                return Slidable(
                  endActionPane: ActionPane(
                    motion: ScrollMotion(),
                    children: [
                      SlidableAction(
                        icon: MdiIcons.trashCan,
                        label: 'Borrar',
                        backgroundColor: Colors.red,
                        onPressed: (context) {
                          _mostrarDialogoConfirmacion(jugadores.id);
                        },
                      )
                    ],
                  ),
                  child: ListTile(
                    leading: Icon(MdiIcons.account),
                    title: Text('${jugadores['Nombre']} ${jugadores['Apellido']} (${jugadores['Edad']})'),
                    subtitle: Text('${jugadores['Equipo']}'),
                    onTap: (){
                      mostrarInformacionJugador(context, jugadores);
                    },
                  ),
                );
              },
            );
          }
        },
        ),
      ),
      floatingActionButton:  FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        MaterialPageRoute route =
          MaterialPageRoute(builder: (context) => Pantalla_Agregar_Jugador());
          Navigator.push(context, route);
      },
      ),
    );
  }

void mostrarInformacionJugador(BuildContext context, QueryDocumentSnapshot<Object?> jugadorSnapshot) {
  var jugador = jugadorSnapshot.data() as Map<String, dynamic>;
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Pantalla_Detalle_Jugador(jugador: jugador),
    ),
  );
}


    void _mostrarDialogoConfirmacion(String jugadorId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Eliminar Jugador'),
        content: Text('¿Estás seguro de que quieres eliminar este jugador?'),
        actions: <Widget>[
          TextButton(
            child: Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Eliminar'),
            onPressed: () {
              // Lógica para eliminar el jugador
              FirestoreService().jugadorBorrar(jugadorId);
              Navigator.of(context).pop(); // Cerrar diálogo
            },
          ),
        ],
      ),
    );
  }
}

