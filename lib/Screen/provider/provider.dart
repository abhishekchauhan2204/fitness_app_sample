import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WarmupState with ChangeNotifier {
  bool _isCompleted = false;
  bool get isCompleted => _isCompleted;

  int completedDays = 0;
  static const int totalDays = 20;

  List<Map<String, dynamic>> completedHistory = [];

  WarmupState() {
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('warmupHistory')
          .orderBy('date', descending: false)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        completedHistory = querySnapshot.docs.map((doc) {
          return {
            'date': doc['date'].toDate(),
            'completedDays': doc['completedDays'],
          };
        }).toList();
        completedDays = completedHistory.length;
        notifyListeners();
      }
    }
  }

  Future<void> completeWarmup() async {
    _isCompleted = true;
    notifyListeners();
    if (completedDays < totalDays) {
      completedDays++;
      var now = DateTime.now();
      completedHistory.add({'date': now, 'completedDays': completedDays});
      notifyListeners();
      await _logCompletion(now);
    }
  }

  Future<void> resetWarmup() async {
    _isCompleted = false;
    completedDays = 0;
    completedHistory.clear();
    await _resetFirestore();
    notifyListeners();
  }

  Future<void> _logCompletion(DateTime date) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('warmupHistory')
          .add({
        'completedDays': completedDays,
        'date': Timestamp.fromDate(date),
      });
    }
  }

  Future<void> _resetFirestore() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var batch = FirebaseFirestore.instance.batch();
      var collection = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('warmupHistory');
      var snapshots = await collection.get();
      for (var doc in snapshots.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
    }
  }
}



class FatBurnerHiit with ChangeNotifier {
  bool _isCompleted = false;

  bool get isCompleted => _isCompleted;
  int completedDays = 0;
  static const int totalDays = 20;

  List<Map<String, dynamic>> completedHistory = [];

  FatBurnerHiit(){
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('fatburnerHiitHistory')
          .orderBy('date', descending: false)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        completedHistory = querySnapshot.docs.map((doc) {
          return {
            'date': doc['date'].toDate(),
            'completedDays': doc['completedDays'],
          };
        }).toList();
        completedDays = completedHistory.length;
        notifyListeners();
      }
    }
  }

  Future<void> completeFatburner() async {
    _isCompleted = true;
    notifyListeners();
    if (completedDays < totalDays) {
      completedDays++;
      var now = DateTime.now();
      completedHistory.add({'date': now, 'completedDays': completedDays});
      notifyListeners();
      await _logCompletion(now);
    }
  }

  Future<void> resetFatburner() async {
    _isCompleted = false;
    completedDays = 0;
    completedHistory.clear();
    await _resetFirestore();
    notifyListeners();
  }

  Future<void> _logCompletion(DateTime date) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('fatburnerHiitHistory')
          .add({
        'completedDays': completedDays,
        'date': Timestamp.fromDate(date),
      });
    }
  }

  Future<void> _resetFirestore() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var batch = FirebaseFirestore.instance.batch();
      var collection = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('fatburnerHiitHistory');
      var snapshots = await collection.get();
      for (var doc in snapshots.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
    }
  }
}
