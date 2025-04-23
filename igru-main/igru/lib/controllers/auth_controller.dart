import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class AuthController extends GetxController {
  final Rx<User?> _currentUser = Rx<User?>(null);

  User? get currentUser => _currentUser.value;

  // Para controlar el estado de carga
  final RxBool isLoading = false.obs;

  // Para controlar la visibilidad de la contraseña
  final RxBool obscurePassword = true.obs;

  // Lista de usuarios precargados
  final List<User> _preloadedUsers = [
    User(
      email: 'kbertiz@unicesar.edu.co',
      password: '112233445566',
      name: 'Kevin',
      lastName: 'Bertiz',
      id: '1033754892',
      phoneNumber: '3007249731',
      photoUrl: '',
    ),
    User(
      email: 'ferguti@unicesar.edu.co',
      password: '123456789',
      name: 'Fernando',
      lastName: 'Gutierrez',
      id: '1004567890',
      phoneNumber: '3109876543',
      photoUrl: '',
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    // En lugar de llamar directamente, usamos un Future retrasado
    // para asegurarnos de que Flutter esté inicializado
    Future.delayed(Duration.zero, () {
      checkUserLoggedIn();
    });
  }

  // Verificar si hay un usuario en localStorage
  Future<void> checkUserLoggedIn() async {
    isLoading.value = true;
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString('currentUser');

      if (userJson != null) {
        final userData = jsonDecode(userJson);
        _currentUser.value = User.fromJson(userData);
      }
    } catch (e) {
      print('Error al verificar usuario: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Iniciar sesión
  Future<bool> login(String email, String password) async {
    isLoading.value = true;

    try {
      // Simulamos una verificación con datos de prueba
      await Future.delayed(Duration(seconds: 2)); // Simular tiempo de carga

      if (email.isEmpty || password.isEmpty) {
        Get.snackbar(
          'Error',
          'Por favor ingrese correo y contraseña',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return false;
      }

      // Buscar usuario en la lista de usuarios precargados
      final user = _preloadedUsers.firstWhereOrNull(
        (u) => u.email == email && u.password == password,
      );

      if (user == null) {
        Get.snackbar(
          'Error',
          'Correo o contraseña incorrectos',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return false;
      }

      // Guardar en localStorage
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('currentUser', jsonEncode(user.toJson()));

      _currentUser.value = user;
      return true;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Error al iniciar sesión: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Cerrar sesión
  Future<void> logout() async {
    isLoading.value = true;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('currentUser');
      _currentUser.value = null;
    } catch (e) {
      print('Error al cerrar sesión: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Alternar visibilidad de contraseña
  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  // Agregar un nuevo usuario (para registro)
  void addUser(User newUser) {
    _preloadedUsers.add(newUser);
  }
}
