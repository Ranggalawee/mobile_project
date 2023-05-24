import 'package:finalmobile/profilepage.dart';
import 'package:flutter/material.dart';
import 'package:finalmobile/loginpage.dart';
import 'package:finalmobile/volcanopage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:finalmobile/camerapermission.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late SharedPreferences prefs;

  @override
  void initState(){
    super.initState();
    initial();
  }

  void initial() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        backgroundColor: Colors.brown,
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: ()  async{
              await prefs.remove('username');

              if(mounted){
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                      (route) => false,
                );
              }
            },
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text('Pilih menu:', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 40),
            Column(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => VolcanoPage()));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 20.0),
                    primary: Colors.brown,
                  ),
                  icon: const Icon(Icons.add_location_sharp),  //icon data for elevated button
                  label: const Text("Daftar Gunung Berapi"), //label text
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => MyApp()));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 20.0),
                    primary: Colors.brown,
                  ),
                  icon: const Icon(Icons.camera_alt),  //icon data for elevated button
                  label: const Text("Camera"), //label text
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white, // set the color of the selected icon
        unselectedItemColor: Colors.white,// set the color of the unselected icons
        backgroundColor: Colors.brown,
        onTap: (value) {
          if (value == 1) Navigator.push(context, MaterialPageRoute(builder: (context)=> const MenuDaftarAnggota())) ;
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'HOME PAGE',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'PROFILE PAGE',
          ),
        ],
      ),
    );
  }
}
