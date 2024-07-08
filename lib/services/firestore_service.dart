import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService{
  //obtener lista de jugadores
  Stream<QuerySnapshot> Jugadores(){
    return FirebaseFirestore.instance.collection('Jugadores').snapshots();
  }

  //obtener lista de equipos
  Future<QuerySnapshot> Equipo() {
    return FirebaseFirestore.instance.collection('Equipo').get();
  }

  //insertar nuevo Jugador en bd
  Future<void> jugadorAgregar(String Nombre,String Apellido,int Edad,String Equipo,DateTime Fecha_de_nacimiento){
    return FirebaseFirestore.instance.collection('Jugadores').doc().set({
      'Nombre' : Nombre,
      'Apellido' : Apellido,
      'Edad' : Edad,
      'Equipo': Equipo,
      'Fecha de nacimiento' : Fecha_de_nacimiento,
    });
  }

  //borrar jugadores
  Future<void> jugadorBorrar(String docId){
    return FirebaseFirestore.instance.collection('Jugadores').doc(docId).delete();
  }
}