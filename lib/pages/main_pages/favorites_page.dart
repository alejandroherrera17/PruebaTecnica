import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/character.dart';


class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('favorites').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final documents = snapshot.data!.docs;

          if (documents.isEmpty) {
            return const Center(child: Text('No hay favoritos.'));
          }

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final characterData = documents[index].data() as Map<dynamic, dynamic>;
              final characterId = documents[index].id;
              return CardCharacter(
                name: characterData['name'],
                species: characterData['species'],
                image: characterData['image'],
                origin: characterData['origin']['name'],
                lastseen: characterData['location']['name'],
                isFavorite: true, 
                onFavoriteChanged: (isFavorite) {
                  
                  if (!isFavorite) {
                    FirebaseFirestore.instance.collection('favorites').doc(characterId).delete();
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
