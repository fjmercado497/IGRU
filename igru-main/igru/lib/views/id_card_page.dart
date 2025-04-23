import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import 'welcome_page.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'user_profile_page.dart';

class IdCardPage extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();

  IdCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1B8E3D),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'IGRU',
          style: TextStyle(
            color: Color(0xFF1B8E3D),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: Icon(Icons.person, color: Color(0xFF1B8E3D), size: 30),
              onPressed: () {
                Get.to(() => UserProfilePage());
              },
            ),
          ),
        ],
        // Eliminamos el leading (Tab)
        automaticallyImplyLeading: false,
      ),
      body: GestureDetector(
        onTap: () {
          Get.to(() => WelcomePage());
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Tarjeta de identificación
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 32),
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Color(0xFFE6A23C), // Color dorado/naranja
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  // Logo de la universidad
                  Row(
                    children: [
                      Image.network(
                        'https://hebbkx1anhila5yf.public.blob.vercel-storage.com/image-7eJHUU9X0F4Gb1QU8OEaxoH5DJGH1S.png',
                        height: 40,
                      ),
                    ],
                  ),
                  SizedBox(height: 24),

                  // Información del usuario
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              authController.currentUser?.fullName ??
                                  'María Isabel Guerra',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Container(
                              height: 1,
                              color: Colors.white,
                              margin: EdgeInsets.symmetric(vertical: 4),
                            ),
                            SizedBox(height: 16),
                            Text(
                              authController.currentUser?.id ?? '1003336668',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Container(
                              height: 1,
                              color: Colors.white,
                              margin: EdgeInsets.symmetric(vertical: 4),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 16),
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                          authController.currentUser?.photoUrl ??
                              'https://randomuser.me/api/portraits/women/44.jpg',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),

            // Texto de instrucción
            Text(
              'Presiona para ingresar a la U',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 8,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Botón Home
              IconButton(
                icon: Icon(Icons.home, size: 30, color: Colors.grey),
                onPressed: () {
                  Get.offAll(() => HomePage());
                },
              ),
              // Botón Cerrar Sesión
              IconButton(
                icon: Icon(Icons.logout, size: 30, color: Colors.grey),
                onPressed: () async {
                  await authController.logout();
                  Get.offAll(() => LoginPage());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
