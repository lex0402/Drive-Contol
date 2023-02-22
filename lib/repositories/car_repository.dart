



import 'package:control_car/model/car.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control_car/repositories/user_repository.dart';
import 'package:control_car/services/authentification.dart';
import 'package:control_car/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:control_car/ui/widgets/textfields/car_textfield.dart';

class CarRepository {
  CarRepository();
  CarRepository._();

  static CarRepository? _instance;

  static CarRepository get instance {
    if (_instance == null) {
      _instance = CarRepository._();
    }
    return _instance!;
  }

  final TextEditingController _MarqueController = TextEditingController();
  final TextEditingController _MatriculeController = TextEditingController();
  final TextEditingController _TypeController = TextEditingController();
  final TextEditingController _Unikode = TextEditingController();

  final _firestoreCarCollection = FirebaseFirestore.instance.collection('car');
  ValueNotifier<List<Car>> carsNotifier = ValueNotifier<List<Car>>([]);
  List<Car> get cars => carsNotifier.value;

  Future<Car?> loadCar(String id) async {
    try {
      final car= cars.firstWhere((Car car) => car.Matricule == id);
      return car;
    } catch (_) {
      try {
        final doc = await _firestoreCarCollection.doc(id).get();
        final car = Car.fromMap(doc.data() ?? {});
        carsNotifier.value.add(car);
        carsNotifier.notifyListeners();

        return car;
      } on FirebaseException catch (e) {
        print(e.message);
        return null;
      }
    }
  }

  Future<List<Car>> loadAllUserCars(String? uid) async {
    try {
      final snapshot = _firestoreCarCollection.where('uid', isEqualTo: uid).snapshots();
      snapshot.listen((query) {
        _addToCar(query);
      });
      return cars;
    } on FirebaseException catch (_) {
      print('something occurred');
      return cars;
    }
  }

  void _addToCar(QuerySnapshot<Map<String, dynamic>> query) {
    Future.wait(query.docs.map((doc) async {
      final car = Car.fromMap(doc.data());
      final index = cars.indexWhere((carX) => carX.Matricule == car.Matricule);
      if (index != -1) {
       carsNotifier.value.removeAt(index);
        carsNotifier.value.insert(index, car);
      } else {
        carsNotifier.value.add(car);
      }
      carsNotifier.notifyListeners();
    }));
  }

  Future<Car?> deleteCar(String Matricule) async {
    try {
      await _firestoreCarCollection.doc(Matricule).update({'status': 5});
      final car = await loadCar(Matricule);
      return car;
    } on FirebaseException catch (_) {
      return null;
    }
  }

  Future<Car?> setUpCar(Car car) async {
    final uid = UserRepository().currentUser?.uid;
    await FirebaseFirestore.instance.collection('users').doc(uid).collection(
        'car').doc(uid).update({
      'Marque': car.Marque,
      'Matricule': car.Matricule,
      'Unikode': car.Unikode,
      ' Type': car.Type,


    });
    //carNotifier.value = await CarRepository.instance.getCar(car.Matricule);
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    //carNotifier.notifyListeners();
    //return carNotifier.value;
  }
    Future<List<Car>>? getAllUserCars(String? uid) async {
      try {
        _firestoreCarCollection.where("uid", isEqualTo: uid).get().then(
              (res) => print("Successfully completed"),
          onError: (e) => print("Error completing: $e"),
        );
        final CarSnapshot = await _firestoreCarCollection.where("uid", isEqualTo: uid).get();
        Future.wait(CarSnapshot.docs.map((doc) async {
          final car = Car.fromMap(doc.data());
          final index = cars.indexWhere((carX) => carX.uid == car.uid);
          if (index != -1) {
            cars.removeAt(index);
            cars.insert(index, car);
          } else {
            cars.add(car);
          }
          carsNotifier.notifyListeners();
        }));
        //cars = carsNotifier;
        return cars;
      } on FirebaseException catch (_) {
        print('something occurred');
        return cars;
      }
    }

    Future<void> _createNewCar(DocumentSnapshot? documentSnapshot, BuildContext context) async{
    await showModalBottomSheet(
      isScrollControlled : true,
      context :context,
      builder : (BuildContext ctx){
        return Padding(
          padding : EdgeInsets.only(
            top : 20 ,
            left : 20,
            right : 20,
            bottom :  MediaQuery.of(ctx).viewInsets.bottom + 20,
          ),
          child:  Column(
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
                label:  'Type de voiture',
              ),

              CarTextField(
                keyboardType: const TextInputType.numberWithOptions(decimal: false),
                controller: _Unikode,
                label:  'Code unique d' + 'accès',
              ),

              const SizedBox(
                height: 20,
              ),

              ElevatedButton(
                  child: const Text('Enregistrer'),
                  onPressed: ()async {
              final String Marque = _MarqueController.text;
              final String Matricule = _MatriculeController.text;
              final String Type = _TypeController.text;
              final int  Unikode = int.parse(_Unikode.text);

              if (Unikode!= null && Marque != null && Matricule  != null) {

              await
              _firestoreCarCollection.doc(documentSnapshot!.id)
                  .update({"Marque": Marque , "Matricule": Matricule , "Type" : Type , "Unikode" : Unikode , "uid" : auth.FirebaseAuth.instance.currentUser?.uid });
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
    }

    );
    }
  }




