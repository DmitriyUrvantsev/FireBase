import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../domain/entity/task.dart';
import '../domain/entity/user.dart';

class DatabaseService extends ChangeNotifier {
  final String uid;
  DatabaseService({required this.uid});

  // ---------ссылка на коллекцию ---------
  final CollectionReference taskCollection =
      FirebaseFirestore.instance.collection('test_task');

  Future<void> updateUserData(String name, [String? chisburger, String? bigMac,
      String? kartoshka, String? cola]) async {
    Map<String, dynamic> data = {
      'name': name,
      'chisburger': chisburger,
      'bigMac': bigMac,
      'kartoshka': kartoshka,
      'cola': cola,
    };
    return await taskCollection.doc(uid).set(data);
  }

  // ---------task list from snapshot ---------
  List<Task> _taskListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Task(
        name: doc.get('name') ?? '0',
        chisburger: doc.get('chisburger') ?? '0',
        bigMac: doc.get('bigMac') ?? '0',
        kartoshka: doc.get('kartoshka') ?? '0',
        cola: doc.get('cola') ?? '0',
      );
    }).toList();
  }

// ---------user data from snapshots ---------
  UserAppData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserAppData(
      uid: uid,
      name: snapshot.get('name'),
      chisburger: snapshot.get('chisburger'),
      bigMac: snapshot.get('bigMac'),
      kartoshka: snapshot.get('kartoshka'),
      cola: snapshot.get('cola'),
    );
  }

  // ---------получение tasks stream ---------
  Stream<List<Task>> get tasks {
    return taskCollection.snapshots().map(_taskListFromSnapshot);
  }

  // --------- получение user doc stream ---------
  Stream<UserAppData> get userData {
    return taskCollection
        .doc(uid)
        .snapshots()
        .map((e) => _userDataFromSnapshot(e));
  }
}
