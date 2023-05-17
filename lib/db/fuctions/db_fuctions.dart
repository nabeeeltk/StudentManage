import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:progect_2/db/model/data_model.dart';

ValueNotifier<List<Studentmodel>> studentlistnotifier = ValueNotifier([]);
Future<void> addStudent(Studentmodel value) async {
  final studentDb = await Hive.openBox<Studentmodel>("student_db");

  final id = await studentDb.add(value);

  value.id = id;
  studentlistnotifier.value.add(value);
  studentlistnotifier.notifyListeners();
}

Future<void> getallstudents() async {
  final studentDb = await Hive.openBox<Studentmodel>("student_db");
  studentlistnotifier.value.clear();
  studentlistnotifier.value.addAll(studentDb.values);
  studentlistnotifier.notifyListeners();
}

Future<void> deletstudent(int id) async {
  final studentDb = await Hive.openBox<Studentmodel>("student_db");
  studentDb.delete(id);
  getallstudents();
}
Future<void> update(Studentmodel value)async{
  final studentDb = await Hive.openBox<Studentmodel>("student_db");
  studentDb.put(value.id, value);

}
