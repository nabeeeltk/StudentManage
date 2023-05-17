

import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
part 'data_model.g.dart';



@HiveType(typeId: 0)
class  Studentmodel{
  @HiveField(0)
  int?  id;
  @HiveField(1)
  final String name ;
  @HiveField(2)
  final String place;
  @HiveField(3)
  final String number ;
  @HiveField(4)
  final String education;
  @HiveField(5)
  final String img;

  Studentmodel({ required   this.name,required this.place,required this.number,required this.education,this.id , required this.img});

}