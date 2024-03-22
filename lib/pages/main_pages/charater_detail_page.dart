import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CharacterDetailPage extends StatelessWidget {
  final dynamic character;

  CharacterDetailPage({required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(character['name']),
        backgroundColor: Colors.green[800],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              child: Hero(
                tag: character['image'],
                child: Image.network(character['image']),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Especie: ${character['species']}',
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                const  SizedBox(height: 8.0),
                  Text(
                    'Origen: ${character['origin']['name']}',
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                 const SizedBox(height: 8.0),
                  Text(
                    'Última ubicación: ${character['location']['name']}',
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                 const SizedBox(height: 16.0),
                 const Text(
                    'Episodios:',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  FutureBuilder<List<dynamic>>(
                    future: fetchEpisodes(character['episode']),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: snapshot.data!.map((episode) {
                            return Container(                              
                              decoration: BoxDecoration(
                                color: Colors.grey[900],
                                borderRadius: BorderRadius.circular(0)
                              ),
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  '- ${episode['name']}',
                                  style: const TextStyle(
                                    fontSize: 22.0,
                                    color: Colors.white
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<dynamic>> fetchEpisodes(List<dynamic> episodeUrls) async {
    List<dynamic> episodes = [];
    for (var url in episodeUrls) {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        episodes.add(json.decode(response.body));
      }
    }
    return episodes;
  }
}