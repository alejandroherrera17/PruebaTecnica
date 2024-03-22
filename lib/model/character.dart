// card_character.dart
import 'package:flutter/material.dart';

class CardCharacter extends StatefulWidget {
  final String name;
  final String species;
  final String image;
  final String origin;
  final String lastseen;
  final bool isFavorite;
  final Function(bool) onFavoriteChanged;

  CardCharacter({
    required this.name,
    required this.species,
    required this.image,
    required this.origin,
    required this.lastseen,
    required this.isFavorite,
    required this.onFavoriteChanged,
  });

  @override
  _CardCharacterState createState() => _CardCharacterState();
}

class _CardCharacterState extends State<CardCharacter> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Card(
        color: Colors.grey[900],
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Image(
                image: NetworkImage(widget.image),
              ),
            ),
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          _isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: _isFavorite ? Colors.red : Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _isFavorite = !_isFavorite;
                            widget.onFavoriteChanged(_isFavorite);
                          });
                        },
                      ),
                    ],
                  ),
                  Text(
                    widget.species,
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  const Text(
                    "Ultima ubicación conocida",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    widget.lastseen,
                    style: const TextStyle(
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  const Text(
                    "Visto por primera vez en",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    widget.origin,
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
