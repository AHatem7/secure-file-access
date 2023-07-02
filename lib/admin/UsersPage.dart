import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'AddNewUser.dart';


class UsersPage extends StatelessWidget {
  const UsersPage({Key? key}) : super(key: key);
  static String routename = 'UsersPage';

  Future<void> deleteUser(String userId, BuildContext context) async {
    try {
      // Delete the user from Firebase Authentication
      //await FirebaseAuth.instance.currentUser!.delete();

      // Delete the user from Cloud Firestore
      await FirebaseFirestore.instance.collection('user').doc(userId).delete();

      // Show a success message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User deleted successfully'),
        ),
      );
    } catch (e) {
      // Show an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error deleting user: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [],
                ),
              ),
              StreamBuilder(
                  stream:
                      FirebaseFirestore.instance.collection("user").snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return Expanded(
                        flex: 6,
                        child: ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            shrinkWrap: true,
                            itemBuilder: (context, i) {
                              var data = snapshot.data!.docs[i];

                              return Column(
                                children: [
                                  Stack(
                                      alignment: AlignmentDirectional.center,
                                      children: [
                                        Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Slidable(
                                                startActionPane: ActionPane(
                                                    motion: DrawerMotion(),
                                                    children: [
                                                      SlidableAction(
                                                        onPressed:
                                                            (buildContext) async {
                                                          DocumentReference userDocRef =
                                                              FirebaseFirestore.instance
                                                                  .collection('user')
                                                                  .doc(data.id);
                                                          try {
                                                            // await userDocRef.delete();
                                                            showDialog(
                                                              context: context, builder: (BuildContextcontext) {
                                                                return AlertDialog(
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(20)),
                                                                  title: Text(""),
                                                                  content: Text(" Are you sure you want delete this user?"),
                                                                  actions: [
                                                                    TextButton(
                                                                      child: Text("No"),
                                                                      onPressed: () {
                                                                        Navigator.of(context).pop();
                                                                      },
                                                                    ),
                                                                    TextButton(
                                                                      child: Text("Yes"),
                                                                      onPressed: () {
                                                                         userDocRef.delete();
                                                                        // deleteUser(data.id, context);
                                                                        Navigator.of(context).pop();
                                                                        showDialog(context: context,
                                                                          builder: (BuildContext context) {
                                                                            return AlertDialog(
                                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                                              title: Text(""),
                                                                              content: Text("Deleted successfully"),
                                                                              actions: [TextButton(
                                                                                child: Text("close"),
                                                                                onPressed: () {
                                                                                  Navigator.of(context).pop();
                                                                                  },
                                                                                ),
                                                                              ],
                                                                            );
                                                                          },
                                                                        );
                                                                      },
                                                                    ),
                                                                  ],
                                                                );
                                                              },
                                                            );
                                                          } catch (e) {
                                                            // Show an error message to the user
                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                              SnackBar(
                                                                  content: Text('Error deleting user: $e')),
                                                            );
                                                          }
                                                        },
                                                        backgroundColor: Colors.red,
                                                        icon: Icons.delete_outline,
                                                        label: 'Delete',
                                                      )
                                                    ]),
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(20)),
                                                  child: Container(
                                                    height: 160,
                                                    child:
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.spaceEvenly,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            SizedBox(width: 18),
                                                            Text('Name:',
                                                                style: TextStyle(
                                                                    color: Color.fromRGBO(206, 185, 151, 1),
                                                                    fontSize: 15,
                                                                    fontWeight: FontWeight.bold)),
                                                            SizedBox(width: 18,),
                                                            Text(data['firstname'],
                                                                style: TextStyle(fontSize: 14)),
                                                            SizedBox(width: 18,),
                                                            Text(data['lastname'],
                                                                style: TextStyle(fontSize: 14)),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            SizedBox(width: 18,),
                                                            Text('Email:',
                                                                style: TextStyle(color: Color.fromRGBO(206, 185, 151, 1),
                                                                    fontSize: 15,
                                                                    fontWeight: FontWeight.bold)),
                                                            SizedBox(
                                                              width: 18,
                                                            ),
                                                            Flexible(
                                                              child: Text(data['email'],
                                                                  style: TextStyle(fontSize: 13),
                                                                maxLines: 3,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            SizedBox(width: 18),
                                                            Text('Phone:', style: TextStyle(
                                                                    color: Color.fromRGBO(206, 185, 151, 1),
                                                                    fontSize: 15,
                                                                    fontWeight: FontWeight.bold)),
                                                            SizedBox(width: 18),
                                                            Text(data['phone'],
                                                                style: TextStyle(fontSize: 14)),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            SizedBox(width: 18,),
                                                            Text('Department:',
                                                                style: TextStyle(color: Color.fromRGBO(206, 185, 151, 1),
                                                                    fontSize: 15,
                                                                    fontWeight: FontWeight.bold)),
                                                            SizedBox(width: 18,),
                                                            Text(data['department'],
                                                                style: TextStyle(fontSize: 14)),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ]),
                                  SizedBox(height: 20)
                                ],
                              );
                            }),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  })
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 140, vertical: 55)),
            FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ADDUser()));
              },
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(
                Icons.add,
                size: 45,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
