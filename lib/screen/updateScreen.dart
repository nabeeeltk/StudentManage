

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progect_2/db/model/data_model.dart';
import 'package:progect_2/screen/homescreen.dart';
import '../db/fuctions/db_fuctions.dart';
import 'homescreen.dart';




class updateScreen extends StatefulWidget {
  updateScreen({super.key, required this.model});
Studentmodel model;
  int? index;

  final TextEditingController _name = TextEditingController();
  final TextEditingController _number = TextEditingController();
  final TextEditingController _place = TextEditingController();
  final TextEditingController _education = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  State<updateScreen> createState() => _updateScreenState();
}

class _updateScreenState extends State<updateScreen> {
  @override
  void initState() {
    widget._name.text = widget.model.name;
    widget._number. text = widget.model.number;

    widget._education.text = widget.model.education;
    widget._place.text = widget.model.place;
    super.initState();
  }

  File? image;
  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() => this.image = imageTemporary);
  }

  Future gallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() => this.image = imageTemporary);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white24,
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: Colors.amber,
        title: Center(
          child: Text(
            ' Edit student',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Center(
            child: CircleAvatar(
              backgroundImage: image == null
                  ? FileImage(File(widget.model.img))
                  : FileImage(File(image!.path)) as ImageProvider,
              radius: 70,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber, minimumSize: Size(150, 50)),
              child: Column(
                children: const [
                  Icon(
                    Icons.camera_alt_sharp,
                    size: 24.0,
                    color: Colors.black,
                  ),
                  Text(
                    'Edit Image',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
              onPressed: () {
                showModalBottomSheet(
                  backgroundColor: Colors.white10,
                  context: context,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  builder: (BuildContext) {
                    return SizedBox(
                        height: 200,
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.amber,
                                  minimumSize: Size(200, 50)),
                              child: Column(
                                children: const [
                                  Icon(
                                    Icons.camera,
                                    color: Colors.black,
                                    size: 24.0,
                                  ),
                                  Text(
                                    'Camera',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                              onPressed: () => pickImage(),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.amber,
                                  minimumSize: Size(200, 50)),
                              child: Column(
                                children: const [
                                  Icon(
                                    Icons.photo,
                                    size: 24.0,
                                    color: Colors.black,
                                  ),
                                  Text(
                                    'Gallery',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                              onPressed: () => gallery(),
                            ),
                            SizedBox(height: 10),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  minimumSize: Size(200, 50)),
                              child: Column(
                                children: const [
                                  Icon(
                                    Icons.cancel,
                                    size: 24.0,
                                  ),
                                  Text('Cancel'),
                                ],
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ));
                  },
                );
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Form(
              key: widget._formkey,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: widget._name,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      hintText: 'Enter your full name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Field cannot be empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: widget._number,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Age',
                      hintText: 'Enter your age',
                      // prefixIcon: Icon(Icons.numbers),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Field cannot be empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: widget._education,
                    maxLength: 10,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'phone',
                      hintText: 'Enter your phone number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        // return 'Field cannot be empty';
                        return 'Phone number (+x xxx-xxx-xxxx)';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: widget._place,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Domain',
                      hintText: 'Enter your domain',
                      // prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Field cannot be empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      minimumSize: Size(200, 50),
                    ),
                    onPressed: () {
                      log(widget._name.text);
                      addClick(context);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          'Update',
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.send,
                          size: 24.0,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                )
              ]))
        ],
      ),
    );
  }

  Future<void> addClick(BuildContext ctx) async {
    final name = widget._name.text.trim();
    final number = widget._number.text.trim();
    final education= widget._place.text.trim();
    final place= widget._education.text.trim();

    if (widget._formkey.currentState!.validate()) {
      final student = Studentmodel(
          id: widget.model.id,
          name: name,
          number: number,
          education: education,
          place: place,
          img: image == null ? widget.model.img : image!.path);

      await update(student);

      ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
        content: Text('data updated successfully...'),
        margin: EdgeInsets.all(20),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green,
      ));
      Navigator.of(ctx).pushReplacement(MaterialPageRoute(builder: (context) {
        return const homescreen();
      }));
}
}
}