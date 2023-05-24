import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:finalmobile/main.dart';
import 'package:finalmobile/user.dart';
import 'package:finalmobile/loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  late Box<UserModel> _myBox;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late SharedPreferences prefs;

  bool _isObscure = true;

  @override
  void initState() {
    super.initState();
    _myBox = Hive.box(boxName);
  }


  @override
  void dispose(){
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Register',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.black)),
            const SizedBox(height: 10,),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller: _usernameController,
                          cursorColor: const Color(0xffc1071e),
                          style: const TextStyle(fontSize: 15, color: Colors.black),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value){
                            if (value == null || value.isEmpty){
                              return 'Isi username';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.people),
                            filled: true,
                            fillColor: Colors.white24,
                            labelText: 'Username',
                            labelStyle: const TextStyle(color: Colors.black),
                            hintText: 'Input your Username',
                            hintStyle: const TextStyle(color: Colors.grey),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(
                                color: Colors.red,
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Color(0xfffff5c518),
                                width: 2.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller: _passwordController,
                          style: const TextStyle(fontSize: 15, color: Colors.black),
                          obscureText: _isObscure,
                          validator: (value){
                            if (value == null || value.isEmpty){
                              return 'Isi Password';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            filled: true,
                            fillColor: Colors.white24,
                            labelText: 'Password',
                            labelStyle: const TextStyle(color: Colors.black),
                            hintText: 'Input your Password',
                            hintStyle: const TextStyle(color: Colors.grey),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(
                                color: Colors.red,
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Color(0xfffff5c518),
                                width: 2.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: SizedBox(
                        width: 300,
                        height: 50,
                        child: Builder(builder: (context) {
                          return ElevatedButton(
                            onPressed: () {
                              print("Masuk onpress regis");
                              _myBox.add(UserModel(
                                username: _usernameController.text,
                                password: _passwordController.text,
                              ));
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                                    (route) => false,
                              );
                            },
                            child:
                            const Text('Register', style: TextStyle(fontSize: 15)),
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xffc1071e),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}