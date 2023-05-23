import 'dart:convert';
import 'package:finalmobile/item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class VolcanoPage extends StatelessWidget {
  VolcanoPage({Key? key}) : super(key: key);

  List<Volcano> volcanos = [];

  Future getVolcano() async {
    var response = await http.get(Uri.https('indonesia-public-static-api.vercel.app', 'api/volcanoes'));
    var jsonData = jsonDecode(response.body);

    for (var eachVolcano in jsonData) {
      final volcano = Volcano(
          nama: eachVolcano['nama'],
          tinggi: eachVolcano['tinggi_meter'],
          geolokasi: eachVolcano['geolokasi']);
      volcanos.add(volcano);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Volcano List'),
        backgroundColor: Colors.brown,
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getVolcano(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: volcanos.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () async {
                      final url = 'https://www.google.com/maps/place/' + volcanos[index].geolokasi; // Replace with your desired URL
                      Uri uri = Uri.parse(url);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.brown[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.brown[100],
                          child: Text(
                            '${index + 1}',
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        title: Text(
                          volcanos[index].nama,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),),
                        subtitle: Text(volcanos[index].tinggi),
                      ),
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

