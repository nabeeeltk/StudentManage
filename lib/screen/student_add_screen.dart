// ignore_for_file: unnecessary_import

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:progect_2/db/fuctions/db_fuctions.dart';
import 'package:progect_2/db/model/data_model.dart';
import 'package:progect_2/provider/provider_student.dart';
import 'package:progect_2/screen/homescreen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class studentadd extends StatefulWidget {
  studentadd({super.key});

  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  final _educationController = TextEditingController();
  final _placeController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  State<studentadd> createState() => _studentaddState();
}

class _studentaddState extends State<studentadd> {
  File? image;

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
        appBar: AppBar(
          title: const Text(
            "ADD STUDENTS",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.grey,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
            color: Colors.black,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 96, 166, 131),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: widget._formkey,
            child: Column(children: [
              CircleAvatar(
                backgroundImage: image == null
                    ? const AssetImage('images/benz3.jpg')
                    : FileImage(File(image!.path)) as ImageProvider,
                radius: 70,
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () => gallery(),
                  child: const Column(
                    children: [
                      Icon(
                        Icons.camera_alt_sharp,
                        size: 24.0,
                        color: Colors.black,
                      ),
                      Text('Upload Image'),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'pls fill';
                    }
                  },
                  controller: widget._nameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      fillColor: Theme.of(context)
                          .secondaryHeaderColor
                          .withOpacity(0.3),
                      filled: true,
                      label: const Text(
                        "Student name ",
                        style: TextStyle(color: Colors.black),
                      ),
                      prefixIcon: const Icon(Icons.person)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'pls fill';
                      }
                    },
                    controller: widget._numberController,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      fillColor: Theme.of(context)
                          .secondaryHeaderColor
                          .withOpacity(0.3),
                      filled: true,
                      prefixIcon: const Icon(Icons.phone),
                      label: const Text("Phone Number ",
                          style: TextStyle(color: Colors.black)),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'pls fill';
                      }
                    },
                    controller: widget._educationController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      fillColor: Theme.of(context)
                          .secondaryHeaderColor
                          .withOpacity(0.3),
                      filled: true,
                      prefixIcon: const Icon(Icons.school),
                      label: const Text("Education",
                          style: TextStyle(color: Colors.black)),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'pls fill';
                      }
                    },
                    controller: widget._placeController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      fillColor: Theme.of(context)
                          .secondaryHeaderColor
                          .withOpacity(0.3),
                      filled: true,
                      prefixIcon: const Icon(Icons.place),
                      label: const Text("Place",
                          style: TextStyle(color: Colors.black)),
                    )),
              ),
              ElevatedButton(
                onPressed: () {
                  if (widget._formkey.currentState!.validate()) {
                    submitButtonClicked();
                  }
                },
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                        Color.fromARGB(255, 1, 52, 9))),
                child: const Text("submit",
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
            ]),
          ),
        ));
  }

  Future<void> submitButtonClicked() async {
    final name = widget._nameController.text.trim();
    final number = widget._numberController.text.trim();
    final education = widget._educationController.text.trim();
    final place = widget._placeController.text.trim();
    final img = image!.path;
    log(name);
    if (name.isEmpty || number.isEmpty || education.isEmpty || place.isEmpty) {
      return;
    }
    // print('$name $number $education $place');

    final _student = Studentmodel(
        name: name,
        place: place,
        number: number,
        education: education,
        img: img);
    addStudent(_student);




    await Provider.of<ProviderStudent>(context, listen: false)
        .addStudent(_student);

    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return const homescreen();
    }));
  }
}
