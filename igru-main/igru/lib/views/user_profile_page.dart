import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import 'home_page.dart';
import 'login_page.dart';

class UserProfilePage extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();

  UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Perfil de Usuario',
          style: TextStyle(
            color: Color(0xFF1B8E3D),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFF1B8E3D)),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color(0xFF1B8E3D).withOpacity(0.3)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              // Avatar o foto de perfil
              CircleAvatar(
                radius: 60,
                backgroundColor: Color(0xFF1B8E3D),
                child: Icon(Icons.person, size: 80, color: Colors.white),
              ),
              SizedBox(height: 30),

              // Información del usuario
              _buildInfoCard(
                'Nombre Completo',
                authController.currentUser?.fullName ?? 'No disponible',
              ),
              SizedBox(height: 15),
              _buildInfoCard(
                'Correo Electrónico',
                authController.currentUser?.email ?? 'No disponible',
              ),
              SizedBox(height: 15),
              _buildInfoCard(
                'Número de Identificación',
                authController.currentUser?.id ?? 'No disponible',
              ),
              SizedBox(height: 15),
              _buildInfoCard(
                'Teléfono',
                authController.currentUser?.phoneNumber ?? 'No disponible',
              ),

              Spacer(),

              // Botón de cerrar sesión
              ElevatedButton.icon(
                onPressed: () async {
                  await authController.logout();
                  Get.offAll(() => LoginPage());
                },
                icon: Icon(Icons.logout),
                label: Text('Cerrar Sesión'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1B8E3D),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
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

  Widget _buildInfoCard(String title, String value) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
          SizedBox(height: 5),
          Text(
            value,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
