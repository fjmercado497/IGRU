import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import 'home_page.dart';

class LoginPage extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color(0xFF1B8E3D)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Logo de la universidad
                Image.network(
                  'https://hebbkx1anhila5yf.public.blob.vercel-storage.com/image-7eJHUU9X0F4Gb1QU8OEaxoH5DJGH1S.png',
                  height: 100,
                ),
                const SizedBox(height: 40),

                // Título principal
                const Text(
                  'INGRESO A LA U',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1B8E3D),
                  ),
                ),
                const SizedBox(height: 40),

                // Subtítulo
                const Text(
                  'INGRESE CORREO',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1B8E3D),
                  ),
                ),
                const SizedBox(height: 8),

                // Descripción
                const Text(
                  'Ingresa tu correo institucional y contraseña asignada',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 24),

                // Campo de correo
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'email@domain.com',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),

                // Campo de contraseña
                Obx(
                  () => TextField(
                    controller: passwordController,
                    obscureText: authController.obscurePassword.value,
                    decoration: InputDecoration(
                      hintText: 'contraseña',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          authController.obscurePassword.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: authController.togglePasswordVisibility,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Botón de inicio de sesión
                Obx(
                  () => ElevatedButton(
                    onPressed:
                        authController.isLoading.value
                            ? null
                            : () async {
                              bool success = await authController.login(
                                emailController.text,
                                passwordController.text,
                              );
                              if (success) {
                                Get.off(() => HomePage());
                              }
                            },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF1B8E3D),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child:
                        authController.isLoading.value
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text('Continue', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
