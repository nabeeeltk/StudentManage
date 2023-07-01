import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../db/model/data_model.dart';

class ProviderStudent with ChangeNotifier{

   List<Studentmodel> StudentList = [];
  List<Studentmodel> studentSearchResult = [];
  Icon cusIcon = const Icon(Icons.search);
  Widget cusSearchBar = Text(
    "Student records",
  );

  set setStudentSearchResult(List<Studentmodel> list) {
    studentSearchResult = list;
    notifyListeners();
  }

Future<void> addStudent(Studentmodel value) async {
  final studentDb = await Hive.openBox<Studentmodel>("student_db");

  final id = await studentDb.add(value);

  value.id = id;
  StudentList.add(value);
 notifyListeners();
}

Future<void> getallstudents() async {
  final studentDb = await Hive.openBox<Studentmodel>("student_db");
  StudentList.clear();
  StudentList.addAll(studentDb.values);
  notifyListeners();
}

Future<void> deletstudent(int id) async {
  final studentDb = await Hive.openBox<Studentmodel>("student_db");
  studentDb.delete(id);
  getallstudents();
  notifyListeners();
}
Future<void> update(Studentmodel value)async{
  final studentDb = await Hive.openBox<Studentmodel>("student_db");
  studentDb.put(value.id, value);
  notifyListeners();

}

}