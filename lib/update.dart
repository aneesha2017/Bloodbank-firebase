import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bloodbank/myappbar.dart' as MyAppBar;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class UpdateUser extends StatefulWidget {
  UpdateUser({
    Key? key,
  }) : super(key: key);

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  final CollectionReference bloodfile =
      FirebaseFirestore.instance.collection('bloodfile');

  TextEditingController namecontroller = TextEditingController();

  TextEditingController mobilecontroller = TextEditingController();

  void updateUser(docid) {
    final data = {
      'name': namecontroller.text,
      'mobile': mobilecontroller.text,
      'group': slecetedgroup,
    };
    bloodfile.doc(docid).update(data).then((value) => Navigator.pop(context));
  }

  @override
  final bloodGroups = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+'];

  String? slecetedgroup;

  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    namecontroller.text = args['name'];
    mobilecontroller.text = args['mobile'];
    slecetedgroup = args['group'];
    final docid = args['id'];
    return Scaffold(
      appBar: MyAppBar.MyAppbar(title: 'Update User'), // Use const here
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
              value: slecetedgroup,
              decoration: const InputDecoration(
                label: Text('Select Blood Group'),
              ),
              items: bloodGroups
                  .map((e) => DropdownMenuItem(
                        child: Text(e),
                        value: e,
                      ))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  slecetedgroup = val as String?;
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                updateUser(docid);
              },
              style: const ButtonStyle(
                  maximumSize:
                      MaterialStatePropertyAll(Size(double.infinity, 50)),
                  backgroundColor: MaterialStatePropertyAll(Colors.red)),
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
