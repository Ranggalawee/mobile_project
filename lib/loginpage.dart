import 'package:finalmobile/homepage.dart';
import 'package:flutter/material.dart';
import 'package:finalmobile/registerpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:finalmobile/main.dart';
import 'package:finalmobile/user.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Box<UserModel> _myBox;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late SharedPreferences prefs;

  bool _isObscure = true;

  @override
  void initState() {
    super.initState();
    checkIsLogin();
    _myBox = Hive.box(boxName);
  }

  void checkIsLogin() async {
    prefs = await SharedPreferences.getInstance();

    bool? isLogin = (prefs.getString('username') != null) ? true : false;

    if(isLogin && mounted){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
              (route) => false);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 3,
                  ),
                ),
                child: Image.asset(
                  ('../assets/loginPicture.jpg'),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
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
                            style:
                            const TextStyle(fontSize: 15, color: Colors.black),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value){
                              if (value == null || value.isEmpty){
                                return 'Isi Username';
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
                            style:
                            const TextStyle(fontSize: 15, color: Colors.black),
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
                              onPressed: () async {
                                print("masukin onpres");
                                String text = "";
                                bool found = false;
                                String username = _usernameController.text;
                                String password = _passwordController.text;
                                found = checkLogin(username,password);
                                if (!found) {
                                  text = "akun tidak ada!";
                                  _isObscure = false;
                                  print("Masuk if!");
                                } else {
                                  print("Masuk else!");
                                  await prefs.setString('username', username);
                                  if (mounted) {
                                    Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (context) => HomePage(),
                                      ),
                                          (route) => false,
                                    );
                                  }
                                  text = "Login Berhasil!";
                                  _isObscure = true;
                                }
                                SnackBar snackBar = SnackBar(
                                  content: Text(text),
                                  duration: const Duration(seconds: 2),
                                  backgroundColor:
                                  (_isObscure) ? Colors.green : Colors.red,
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              },
                              child:
                              const Text('Login', style: TextStyle(fontSize: 15)),
                              style: ElevatedButton.styleFrom(
                                primary: const Color(0xffc1071e),
                              ),
                            );
                          }),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => RegisterPage(),
                            ),
                                (route) => false,
                          );
                        },
                        child: const Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  int getLength() {
    return _myBox.length;
  }

  bool checkLogin(String username, String password) {
    bool found = false;
    for (int i = 0; i < getLength(); i++) {
      if (username == _myBox.getAt(i)!.username &&
          password == _myBox.getAt(i)!.password) {
        ("Login Success");
        found = true;
        break;
      } else {
        found = false;
      }
    }

    return found;
  }

  bool checkUsers(String username) {
    bool found = false;
    for (int i = 0; i < getLength(); i++) {
      if (username == _myBox.getAt(i)!.username) {
        found = true;
        break;
      } else {
        found = false;
      }
    }
    return found;
  }
}

