import 'package:bloodbank/home.dart';
import 'package:bloodbank/myappbar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Start extends StatelessWidget {
  Start({super.key});
  final CollectionReference bloodfile =
      FirebaseFirestore.instance.collection('bloodfile');

  void deleteUser(docid) {
    bloodfile.doc(docid).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(title: "Blood Bank"),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/home');
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: StreamBuilder(
        stream: bloodfile.snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot bloodSnap = snapshot.data.docs[index];
                return Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Container(
                    height: 80,
                    color: Color.fromARGB(255, 250, 222, 222),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Container(
                            child: CircleAvatar(
                              backgroundColor: Colors.red,
                              child: Text(bloodSnap['group']),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              bloodSnap['name'],
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              bloodSnap['mobile'].toString(),
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/update',
                                      arguments: {
                                        'name': bloodSnap['name'],
                                        'mobile':
                                            bloodSnap['mobile'].toString(),
                                        'group': bloodSnap['group'],
                                        'id': bloodSnap.id,
                                      });
                                },
                                icon: Icon(Icons.edit)),
                            IconButton(
                                onPressed: () {
                                  deleteUser(bloodSnap.id);
                                },
                                icon: Icon(Icons.delete)),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
