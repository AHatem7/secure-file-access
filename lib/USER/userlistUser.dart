import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../admin/Departments.dart';
import '../backgrounds.dart';
import '../chat/chatScreen.dart';

class UsersListPage1 extends StatefulWidget {
  static String routename = 'yy';
  @override
  _UsersListPage1State createState() => _UsersListPage1State();
}

class _UsersListPage1State extends State<UsersListPage1> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Background('assets/images/BG1.png'),
        Scaffold(
          backgroundColor: Colors.transparent,
          // appBar: AppBar(
          //   backgroundColor: Colors.transparent,
          //   elevation: 0,
          //   title: Text(''),
          // ),
          body:
          Column(
            children: [
              SizedBox(height:50),
              Row(
                  children: [
                    // SizedBox(width: 20,),
                    // FloatingActionButton(onPressed: (){
                    //   Navigator.pop(context,
                    //       MaterialPageRoute(builder: (context)=> Departments()));},
                    //     child: Icon(Icons.arrow_back,color: Colors.black),
                    //     backgroundColor: Colors.white),
                  ]
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: firestore
                      .collection('user')
                      .where('uid', isNotEqualTo: auth.currentUser!.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    List<DocumentSnapshot> documents = snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot document = documents[index];
                        return Card(
                          color: Colors.white,
                          child: ListTile(
                            title: Text(
                                document['firstname'] + ' ' + document['lastname'],
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text(document['email']),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ChatPage(selectedUser: document)),
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}