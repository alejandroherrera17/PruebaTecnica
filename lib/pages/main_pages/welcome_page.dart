import 'package:flutter/material.dart';
import '../../controller/auth_controller.dart';
import 'character_page.dart';
import 'favorites_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({
    super.key,
  });

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int selectedIndex = 0;

  final screens = [CharacterPage(), FavoritesPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
            onPressed: () {
               AuthController.instance.logout();
            },
            icon: const Icon(
              Icons.logout_outlined,
              color: Colors.white,
            )),
        title: const Text(
          "Personajes",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: IndexedStack(
        index: selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              activeIcon: Icon(Icons.home_outlined),
              label: "Personajes"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_pin),
              activeIcon: Icon(Icons.person_pin_circle),
              label: "Favoritos")
        ],
      ),
    );
  }
}
