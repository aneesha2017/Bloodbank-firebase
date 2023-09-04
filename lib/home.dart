import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bloodbank/myappbar.dart' as MyAppBar;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({
    Key? key,
  }) : super(key: key);
  final CollectionReference bloodfile =
      FirebaseFirestore.instance.collection('bloodfile');
  TextEditingController namecontroller = TextEditingController();
  TextEditingController mobilecontroller = TextEditingController();

  void addUser() {
    final data = {
      'name': namecontroller.text,
      'mobile': mobilecontroller.text,
      'group': slecetedgroup,
    };
    bloodfile.add(data);
  }

  @override
  final BloodGroups = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+'];
  String? slecetedgroup;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.MyAppbar(title: 'Add User'), // Use const here
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                  hintText: "Name:", border: OutlineInputBorder()),
              cursorHeight: 30,
              controller: namecontroller,
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  hintText: "Mobile:", border: OutlineInputBorder()),
              cursorHeight: 30,
              keyboardType: TextInputType.number,
              controller: mobilecontroller,
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            DropdownButtonFormField(
                decoration:
                    const InputDecoration(label: Text('Select Blood Group')),
                items: BloodGroups.map((e) => DropdownMenuItem(
                      child: Text(e),
                      value: e,
                    )).toList(),
                onChanged: (val) {
                  slecetedgroup = val as String;
                }),
            ElevatedButton(
              onPressed: () {
                addUser();
                Navigator.pop(context);
              },
              style: const ButtonStyle(
                  maximumSize:
                      MaterialStatePropertyAll(Size(double.infinity, 50)),
                  backgroundColor: MaterialStatePropertyAll(Colors.red)),
              child: const Text('submit'),
            ),
          ],
        ),
      ),
    );
  }
}
