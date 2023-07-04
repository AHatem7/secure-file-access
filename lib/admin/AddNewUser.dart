import 'package:flutter/material.dart';
import '../backgrounds.dart';
import '../login/LoginHelper.dart';
import 'UsersPage.dart';

class ADDUser extends StatefulWidget {
  static String routename = 'ADDUser';

  const ADDUser({Key? key}) : super(key: key);

  @override
  State<ADDUser> createState() => _ADDUserState();
}

class _ADDUserState extends State<ADDUser> {
  AuthService authService = AuthService();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String selectedRole ='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Background('assets/images/BG1.png'),
          Column(
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
                    FloatingActionButton(
                      onPressed: () {
                        Navigator.pop(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UsersPage()));
                      },
                      child:
                          Icon(Icons.arrow_back, color: Colors.black, size: 35),
                      backgroundColor: Colors.white,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                flex: 6,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 55,
                            width: 160,
                            child: TextFormField(
                              controller: authService.firstname,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18),
                                    borderSide: const BorderSide(
                                        width: 0, style: BorderStyle.none),
                                  ),
                                  hintText: 'First Name',
                                  hintStyle:
                                      const TextStyle(color: Colors.black)),
                              validator: (value) {
                                if(value ==null || value.isEmpty){
                                  return 'Please enter a First Name';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          SizedBox(
                            height: 55,
                            width: 160,
                            child: TextFormField(
                              controller: authService.lastname,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18),
                                    borderSide: const BorderSide(
                                        width: 0, style: BorderStyle.none),
                                  ),
                                  hintText: 'Last Name',
                                  hintStyle:
                                      const TextStyle(color: Colors.black)),
                              validator: (value) {
                                if(value ==null || value.isEmpty){
                                  return 'Please enter a Last Name';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 55,
                        width: 350,
                        child: TextFormField(
                          controller: authService.email,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: const BorderSide(
                                    width: 0, style: BorderStyle.none),
                              ),
                              hintText: 'Email',
                              hintStyle: const TextStyle(color: Colors.black)),
                          validator: (value) {
                            if(value ==null || value.isEmpty){
                              return 'Please enter an Email';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 55,
                        width: 350,
                        child: TextFormField(
                          controller: authService.password,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: const BorderSide(
                                    width: 0, style: BorderStyle.none),
                              ),
                              hintText: 'Password',
                              hintStyle: const TextStyle(color: Colors.black)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a password';
                            } else if (value.length < 8) {
                              return 'Password must be at least 8 characters';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 55,
                        width: 350,
                        child: TextFormField(
                          controller: authService.phone,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: const BorderSide(
                                    width: 0, style: BorderStyle.none),
                              ),
                              hintText: 'Phone',
                              hintStyle: const TextStyle(color: Colors.black)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Phone Number';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 55,
                        width: 350,
                        child: TextFormField(
                          controller: authService.department,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: const BorderSide(
                                    width: 0, style: BorderStyle.none),
                              ),
                              hintText: 'Department',
                              hintStyle: const TextStyle(color: Colors.black)),
                          validator: (value) {
                            if(value ==null || value.isEmpty){
                              return 'Please enter a Department';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 70,
                        width: 350,
                        child: DropdownButtonFormField<String>(
                          //value: selectedRole,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none
                              )
                            ),
                            hintText: 'Role',
                            hintStyle: TextStyle(
                              color: Colors.black
                            )
                          ),
                          items: [
                            DropdownMenuItem(
                              child: Text('Admin'),
                              value: 'Admin',
                            ),
                            DropdownMenuItem(
                              child: Text('User'),
                              value: 'User',
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              //selectedRole = value!;
                              authService.selectedRole.text = value!;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a Role';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              authService.hendiregester(context);
                            }
                            // Navigator.pop(context,
                            //     MaterialPageRoute(builder: (context) => UsersPage()));
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(220, 205, 168, 1),
                              fixedSize: const Size(350, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18))),
                          child: const Text('Add User')),
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: Row(
                children: const [],
              ))
            ],
          ),
        ],
      ),
    );
  }
}







