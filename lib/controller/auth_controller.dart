import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:prueba_tecnica/pages/auth_pages/login_page.dart';
import 'package:prueba_tecnica/pages/main_pages/welcome_page.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
  }

  _initialScreen(User? user) {
    if (user == null) {
      print("loginpage");
      Get.offAll(() => const LoginPage());
    } else {
      Get.offAll(() => const WelcomePage());
    }
  }

  void register(String email, password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      Get.snackbar("Error", "Usuario invalido",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text(
            "Creación de cuenta fallida",
            style: TextStyle(color: Colors.white),
          ));
    }
  }

  void login(String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Get.snackbar("Error", "Usuario invalido",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text(
            "Credenciales incorrectas",
            style: TextStyle(color: Colors.white),
          ));
    }
  }

  void logout() async {
    await auth.signOut();
  }

  void addToFavorites(Map<String, dynamic> characterData) async {
    try {
      // Verificar si el usuario está autenticado
      User? user = auth.currentUser;
      if (user != null) {
        // Obtener la referencia a la colección de favoritos del usuario
        CollectionReference favoritesCollection =
            firestore.collection('users').doc(user.uid).collection('favorites');
        await favoritesCollection.add(characterData);
      }
    } catch (e) {
      Get.snackbar("Error", "No se pudo agregar a favoritos",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text(
            "Error al agregar a favoritos",
            style: TextStyle(color: Colors.white),
          ));
    }
  }

  void removeFromFavorites(String favoriteId) async {
    try {
      User? user = auth.currentUser;
      if (user != null) {
        CollectionReference favoritesCollection =
            firestore.collection('users').doc(user.uid).collection('favorites');
        await favoritesCollection.doc(favoriteId).delete();
      } else {}
    } catch (e) {}
  }
}
