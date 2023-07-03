import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../USER/UserBottomNav.dart';
import '../admin/BottomNavigationBarItem.dart';
import 'LoGinPage.dart';

class AuthService{
  final auth = FirebaseAuth.instance;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController department = TextEditingController();
  TextEditingController selectedRole = TextEditingController();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void LoginHelper(context)async{
    try{
      showDialog(
          context: context,
          builder: (context){
        return AlertDialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Center(
              child: SpinKitFoldingCube(size: 20,color: Color.fromRGBO(220, 205, 168, 1),)
          ),
        );
          }
          );

      UserCredential userCredential =
      await auth.signInWithEmailAndPassword(
          email: email.text, password: password.text);

      QuerySnapshot userSnapshot = await firestore
          .collection('user')
          .where('uid', isEqualTo: userCredential.user!.uid)
          .get();


      if (userSnapshot.docs.length == 1) {
        String role = userSnapshot.docs[0]['role'];
        if (role.toLowerCase() == 'user') {

          // Navigate to the admin dashboard
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => UserNavBar()),
                (route) => false,
          );
          email.clear();
          password.clear();

        }
      }
       if (userSnapshot.docs.length == 1) {
        String role = userSnapshot.docs[0]['role'];
        if (role.toLowerCase() == 'admin') {
          // Navigate to the admin dashboard
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => DirectoryPage()),
                (route) => false,
          );
          email.clear();
          password.clear();
        }
      }
    }catch(e){
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("SomeThing went wrong"),
            content: Text(" Invalid email or password "),
            actions: [
              TextButton(
                child: Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////////////

  void hendiregester(context)async{
    try{
      showDialog(
          context: context,
          builder: (context){
            return AlertDialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              title: Center(
                  child: SpinKitFoldingCube(size: 20,color: Color.fromRGBO(220, 205, 168, 1),)
              ),
            );
          }
          );

      await auth.createUserWithEmailAndPassword(
          email: email.text, password: password.text).then((value) {

        print('user is registered');
        firestore.collection('user').add({
          "email":email.text,
          "firstname":firstname.text,
          "lastname":lastname.text,
          "phone":phone.text,
          "department":department.text,
          "role": selectedRole.text,
          "uid":auth.currentUser!.uid,

        });
        // Navigator.push(context, MaterialPageRoute(builder:(c)=> DirectoryPage()));
        Navigator.pop(context);
        showDialog(context: context,
            builder: (BuildContext context){
          return AlertDialog(
            title: Text(""),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: Text(" User added successfully "),
            actions: [
              TextButton(
                child: Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),

            ],
          );
            });

      });
    }catch(e){
      Navigator.pop(context);
      AlertDialog(
        title: Center(
          child:  Text('Error'),

        ),
      );
    }
  }


// void hendiregester(context) async {
//     try{
//       UserCredential userCredential =
//           await FirebaseAuth.instance.createUserWithEmailAndPassword
//             (email: email.text, password: password.text);
//
//       await FirebaseFirestore.instance
//           .collection('users')
//           .doc(userCredential.user!.uid)
//           .set({
//         "email":email.text,
//         "firstname":firstname.text,
//         "lastname":lastname.text,
//         "phone":phone.text,
//         "department":department.text,
//         "role": selectedRole.text,
//         "uid":auth.currentUser!.uid,
//       });
//
//
//     }on FirebaseAuthException catch(e){
//       if (e.code == 'weak');
//     }catch(e){
//       print(e);
//     }
//
// }



  void logoutUser( context)async{

    await auth.signOut();
    Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => LoGinPage(), ), (route) => false);
  }
}

