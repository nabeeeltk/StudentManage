import 'dart:math';

import 'package:flutter/material.dart';
import 'package:progect_2/db/fuctions/db_fuctions.dart';
import 'package:progect_2/db/model/data_model.dart';
import 'package:progect_2/provider/provider_student.dart';
import 'package:progect_2/screen/student_add_screen.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class homescreen extends StatefulWidget {
  const homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  Icon customIcon = Icon(Icons.search);

  Widget customSearchBar = Text(
    'Student record',
  );
  @override
  Widget build(BuildContext context) {
    getallstudents();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 96, 166, 131),
      appBar: AppBar(
        title: Center(child: customSearchBar),
        titleTextStyle: const TextStyle(color: Colors.white),
        backgroundColor: Colors.black,
        actions: <Widget>[
          Consumer<ProviderStudent>(
            builder: (context, value, child){
            return InkWell(
              onTap: () {
                setState(() {
                  if (customIcon.icon == Icons.search) {
                    customIcon = const Icon(Icons.cancel);
                    customSearchBar = TextField(
                      onChanged: (value) {},
                      textInputAction: TextInputAction.go,
                      decoration: InputDecoration(
                        contentPadding:
                          const   EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        hintText: 'Search',
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    );
                  } else {
                    customIcon = const Icon(Icons.search);
                    customSearchBar = const Text("STUDENTS RECORD");
                  }
                });
              },
              child: SizedBox(
                width: 100,
                child: customIcon,
              ),
            );
            }
          ),
        ],
        elevation: 12,
  
      ),
  
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.black,
        child: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => studentadd()),
            );
          },
          icon: Icon(Icons.add),
          color: Colors.white,
          iconSize: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: ValueListenableBuilder(
          valueListenable: studentlistnotifier,
          builder: (ctx, List<Studentmodel> studenlist, Widget? child) {
            return ListView.separated(
                itemBuilder: (ctx, index) {
                  final data = studenlist[index];
                  return ListTile(
                    title: Text(data.name),
                    subtitle: Text(data.place),
                    trailing: IconButton(
                      onPressed: () {
                        if (data.id != null) {
                          deletestudent(data.id!);
                        } else {
                          print("student id is null ");
                        }
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return  AlertDialog(
                                title: const Text("delete? "),
                                content: const Text("are you sure "),
                                actions: [
                                  TextButton(
                                  child:const  Text("Cancel"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                             } ),
                             TextButton(
                                  child:const  Text("ok"),
                                  onPressed: () {
                                         
                                    Navigator.of(context).pop();
                             } ),
                             
                              ],
                              );
                            });
                      },
                      icon:const  Icon(Icons.delete, color: Colors.red),
                    ),
                  );
                },
                separatorBuilder: (ctx, index) {
                  return const Divider(
                    color: Colors.black ,
                    thickness: 1.5

                  );
                },
                itemCount: studenlist.length);
          }),
    );
  }
}
