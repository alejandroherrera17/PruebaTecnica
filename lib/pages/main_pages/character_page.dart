// CharacterPage.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../model/character.dart';
import 'charater_detail_page.dart';

class CharacterPage extends StatefulWidget {
  @override
  _CharacterPageState createState() => _CharacterPageState();
}

class _CharacterPageState extends State<CharacterPage> {
  late List<dynamic> characters;
  late List<dynamic> filteredCharacters;
  late List<dynamic> favorites;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    characters = [];
    filteredCharacters = [];
    favorites = [];
    fetchCharacters();
  }

  Future<void> fetchCharacters() async {
    final response = await http.get(
      Uri.parse('https://rickandmortyapi.com/api/character'),
    );
    if (response.statusCode == 200) {
      setState(() {
        characters = json.decode(response.body)['results'];
        filteredCharacters = characters.toList();
      });
    } else {
      throw Exception('Failed to load characters');
    }
  }

  void filterCharacters(String query) {
    setState(() {      
      filteredCharacters = characters.where((character) {
        final name = character['name'].toString().toLowerCase();
        return name.contains(query.toLowerCase());
      }).toList();
    });
  }

  void toggleFavorite(dynamic character, bool isFavorite) async {
    try {
      String characterId =
          character['id'].toString(); 
      if (isFavorite) {
        await _firestore
            .collection('favorites')
            .doc(characterId)
            .set(character); 
      } else {
        await _firestore
            .collection('favorites')
            .doc(characterId)
            .delete(); 
      }
    } catch (e) {
      print('Error: $e');
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Container(
          color: Colors.white,
          child: TextField(
            
            onChanged: filterCharacters,
            decoration: InputDecoration(  
              prefixIcon: const Icon(Icons.search, color: Colors.black,),            
              hintText: 'Buscar personajes',
              hintStyle: const TextStyle(color: Colors.black),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.grey, width: 1),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: filteredCharacters.length,
              itemBuilder: (context, index) {
                final character = filteredCharacters[index];
                final bool isFavorite = favorites.contains(character);
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CharacterDetailPage(character: character),
                      ),
                    );
                  },
                  child: CardCharacter(
                    name: character['name'],
                    species: character['species'],
                    image: character['image'],
                    origin: character['origin']['name'],
                    lastseen: character['location']['name'],
                    isFavorite: isFavorite,
                    onFavoriteChanged: (isFavorite) {
                      toggleFavorite(character, isFavorite);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
