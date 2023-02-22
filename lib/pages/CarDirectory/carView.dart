import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control_car/repositories/car_repository.dart';
import 'package:flutter/material.dart';
import 'package:control_car/model/car.dart';
import 'package:control_car/utils/images_assets.dart';
import 'package:control_car/ui/theme.dart';
import 'package:control_car/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:control_car/services/authentification.dart';
import 'package:control_car/ui/widgets/textfields/car_textfield.dart';

import '../../utils/MenuItem.dart';
import '../../utils/MenuItems.dart';

class ListCarView extends StatefulWidget {
  @override
  ListCarViewState createState() => ListCarViewState();
}

class ListCarViewState extends State<ListCarView> {
  //final car = CarRepository().loadCar(Car.fromMap(FirebaseFirestore.instance.collection('car').doc()));
  final TextEditingController _MarqueController = TextEditingController();
  final TextEditingController _MatriculeController = TextEditingController();
  final TextEditingController _TypeController = TextEditingController();
  final TextEditingController _Unikode = TextEditingController();
  final CollectionReference CarsRef =
      FirebaseFirestore.instance.collection('car');

  final uid = UserRepository().currentUser?.uid;

  //add new car
  Future<void> _createNewCar([DocumentSnapshot? documentSnapshot]) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarTextField(
                  controller: _MarqueController,
                  label: 'Marque de la voiture',
                ),
                CarTextField(
                  controller: _MatriculeController,
                  label: 'Matricule de la voiture',
                ),
                CarTextField(
                  controller: _TypeController,
                  label: 'Type de voiture',
                ),
                CarTextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: false),
                  controller: _Unikode,
                  label: 'Code unique d' + 'accès',
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Enregistrer'),
                  onPressed: () async {
                    final String Marque = _MarqueController.text;
                    final String Matricule = _MatriculeController.text;
                    final String Type = _TypeController.text;
                    final int Unikode = int.parse(_Unikode.text);

                    if (Unikode != null &&
                        Marque != null &&
                        Matricule != null) {
                      await CarsRef.add({
                        "Marque": Marque,
                        "Matricule": Matricule,
                        "Type": Type,
                        "Unikode": Unikode,
                        "uid": auth.FirebaseAuth.instance.currentUser?.uid
                      });
                      _MarqueController.text = '';
                      _MatriculeController.text = '';
                      _TypeController.text = '';
                      _Unikode.text = '';
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  //Function delete car
  Future<void> _deleteCar(String Id) async {
    await CarsRef.doc(Id).delete();

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You have successfully deleted a car')));
  }

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _MatriculeController.text = documentSnapshot['Matricule'];
      _MarqueController.text = documentSnapshot['Marque'];
      _TypeController.text = documentSnapshot['Type'];
      _Unikode.text = documentSnapshot['Unikode'].toString();
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarTextField(
                  controller: _MarqueController,
                  label: 'Marque de la voiture',
                ),
                CarTextField(
                  controller: _MatriculeController,
                  label: 'Matricule de la voiture',
                ),
                CarTextField(
                  controller: _TypeController,
                  label: 'Type de voiture',
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Valider'),
                  onPressed: () async {
                    final String Marque = _MarqueController.text;
                    final String Matricule = _MatriculeController.text;
                    final String Type = _TypeController.text;

                    if (Marque != null && Matricule != null) {
                      await CarsRef.doc(documentSnapshot!.id).update({
                        "Marque": Marque,
                        "Matricule": Matricule,
                        "Type": Type,
                        "uid": auth.FirebaseAuth.instance.currentUser?.uid
                      });
                      _MarqueController.text = '';
                      _MatriculeController.text = '';
                      _TypeController.text = '';
                      _Unikode.text = '';
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  PopupMenuItem<MenuItemr> buildItem(MenuItemr item) => PopupMenuItem(
        child: Row(
          children: [
            item.IconButton,
            const SizedBox(width: 12),
            Text(item.text)
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    //final Future<List<Car> > cars = CarRepository().loadAllUserRides(uid!);

    // final car  = CarRepository().loadCar(geCarMatriculetList())

    return Scaffold(
        body: Container(
            padding: const EdgeInsets.only(right: 9),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(ImagesAsset.Background),
                    fit: BoxFit.cover)),
            child: StreamBuilder(
                stream: CarsRef.snapshots(),
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (!streamSnapshot.hasData)
                    return Container(
                      child: Text('Pas de voitures actuellement'),
                    );
                  else {
                    return ListView.builder(
                      itemCount: streamSnapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot documentSnapshot =
                            streamSnapshot.data!.docs[index];

                        return Card(
                          color: Colors.white,
                          child: ListTile(
                              title: Text(documentSnapshot['Marque']),
                              subtitle: Text(documentSnapshot['Matricule']),
                              trailing: SizedBox(
                                  height: 90,
                                  width: 144,
                                  child: Row(
                                    children: [
                                      PopupMenuButton<MenuItemr>(
                                        itemBuilder: (context) => [
                                          ...List.from(MenuItems.itemfirst
                                              .map(buildItem)
                                              .toList()),
                                        ],
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete,
                                            color: CityTheme.cityblue),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Container(
                                                child: AlertDialog(
                                                  title: Text(
                                                      "Voulez vous vraiment supprimer cette voiture ?"),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                            _deleteCar(
                                                                documentSnapshot
                                                                    .id);
                                              Navigator.pop(context);},
                                                        child: Text('Oui')),

                                                    TextButton(
                                                        onPressed: () {

                                                          Navigator.pop(context);},
                                                        child: Text('Non'))
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.edit,
                                            color: CityTheme.cityblue),
                                        onPressed: () => _update(),
                                      ),
                                    ],
                                  ))),
                        );
                      },
                    );
                  }
                })),
        floatingActionButton: FloatingActionButton(
          backgroundColor: CityTheme.cityblue,
          onPressed: () => _createNewCar(),
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat);
  }
}
