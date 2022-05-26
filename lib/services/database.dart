import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffeeorders_app/models/CustomModelUser.dart';
import 'package:coffeeorders_app/models/coffeeOrder.dart';

class DatabaseService {
  final String uid;


  DatabaseService(this.uid);

  CollectionReference coffeeCollection = FirebaseFirestore.instance.collection(
      "Coffee");

  Future updateUserData(String sugars, String name, int strength) async {
    return await coffeeCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength
    });
  }

  //get data from database

  Stream<List<CoffeeOrder>> get coffeeOrders {
    return coffeeCollection.snapshots()
    .map(_coffeeordersListFromSnapshot);
  }

  //convert snapshot in list by creating the object or custom model class

  List<CoffeeOrder> _coffeeordersListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return CoffeeOrder(doc['name'],
          doc['sugars'],
           doc['strength']);
    }).toList();
  }
  //get user doc stream
  Stream<UserData> get userData {
     return coffeeCollection.doc(uid).snapshots()
     .map(_userdatafromSnapshot);
   }
   
   //convert user data object into the custom user data 

   UserData _userdatafromSnapshot(DocumentSnapshot snapshot) {
    return UserData(uid,
        snapshot.get("name"),
        snapshot.get("sugars"),
        snapshot.get("strength")
    );
  }

  






}



