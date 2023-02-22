import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control_car/model/user.dart';

class Car {
  //final int id_Vehicule;
  final String Marque;
  final String Matricule;
  final String Type;
  final String uid;
  final int Unikode;

  const Car({
    //required this.id_Vehicule,
    required this.Marque,
    required this.Matricule,
    required this.Type,
    required this.uid,
    required this.Unikode,


  });

  factory Car.fromMap(Map<String, dynamic> data) {
    return Car(
       // id_Vehicule: data['id_Vehicule,'] ?? '',

        Marque: data['Marque'] ?? '',
        Matricule: data['Matricule'] ?? '',
        Type: data['Type'] ?? '',
        uid : data['uid']?? '',
        Unikode: data['Unikode'] ?? '',
    );
  }

  factory Car.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return Car(
      Marque: data?['Marque'],
      Matricule: data?['Matricule'],
      Type: data?['Type'],
      uid: data?['uid'],
      Unikode: data?['Unikode'],

    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (Marque != null) "name": Marque,
      if (Matricule != null) "state": Matricule,
      if (Type != null) "country": Type,
      if (uid != null) "capital": uid,
      if (Unikode != null) "population": Unikode,

    };
  }
}




