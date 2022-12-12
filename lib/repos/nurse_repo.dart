import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dexter_task/models/nurse_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NurseRepo {
  static final NurseRepo _instance = NurseRepo._internal();
  NurseRepo._internal();
  factory NurseRepo() => _instance;

  FirebaseFirestore instance = FirebaseFirestore.instance;

  //since i'm using flutter_ui_auth for generated screens for the auth flow
  //the library is still missing some quirks for me to customize it and let me create
  //a document for the user in the datastore , so i'm using a listener when a signup or login is successful
  // i create the document for the nurse in nurses collection
  void listenAndAssignNurse() async {
    FirebaseAuth.instance.authStateChanges().listen((event) async {
      if (event != null) {
        var result = await instance.collection('nurses').where('auth_id', isEqualTo: event.uid).get();
        if (result.docs.isEmpty) {
          await instance.collection('nurses').add({'fullName': 'test_name', 'auth_id': event.uid});
        }
      }
    });
    
  }

  Future<NurseModel> getCurrentUser() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    var snapshots = await instance.collection('nurses').where('auth_id', isEqualTo: uid).get();
    final doc = snapshots.docs.first;
    NurseModel nurseModel = NurseModel.fromJson(doc.data());
    nurseModel.id = doc.id;
    return nurseModel;
  }
}
