import 'dart:convert';
import 'package:finalmobile/item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  List<Volcano> volcanos = [];
  
  Future getVolcano() async {
    var response = await http.get(Uri.https('indonesia-public-static-api.vercel.app', 'api/volcanoes'));
    var jsonData = jsonDecode(response.body);

    for (var eachVolcano in jsonData) {
      final volcano = Volcano(
          nama: eachVolcano['nama'],
          tinggi: eachVolcano['tinggi_meter']);
      volcanos.add(volcano);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getVolcano(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: volcanos.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        title: Text(volcanos[index].nama),
                        subtitle: Text(volcanos[index].tinggi),
                      ),
                    ),
                  );
                },
            );
          }
          else {
            return const Center(child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

