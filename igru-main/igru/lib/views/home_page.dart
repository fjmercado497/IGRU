import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import '../controllers/auth_controller.dart';
import '../controllers/attendance_controller.dart';
import 'id_card_page.dart';
import 'login_page.dart';
import 'user_profile_page.dart';

class HomePage extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();
  final AttendanceController attendanceController = Get.put(
    AttendanceController(),
  );

  HomePage({super.key});

  void _showMenuOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(
                  'Vortal',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.pop(context);
                  // Aquí iría la navegación al Vortal
                },
              ),
              Divider(),
              ListTile(
                title: Text(
                  'Aulaweb',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.pop(context);
                  // Aquí iría la navegación a Aulaweb
                },
              ),
              Divider(),
              ListTile(
                title: Text(
                  'Estadísticas',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.pop(context);
                  // Aquí iría la navegación a Estadísticas
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Botón de ingreso
            ElevatedButton(
              onPressed: () {
                // Mostrar advertencia
                showDialog(
                  context: context,
                  barrierDismissible:
                      true, // Se puede cerrar tocando fuera del diálogo
                  builder: (BuildContext context) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(
                          context,
                        ).pop(); // Cerrar el diálogo al tocar
                        // Navegar a la página de tarjeta de identificación
                        Get.to(() => IdCardPage());
                      },
                      child: AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        contentPadding: EdgeInsets.all(20),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.warning_amber_rounded,
                              color: Colors.amber,
                              size: 48,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'ADVERTENCIA',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'presiones el boton antes de acercar el Telefono.',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1B8E3D),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'INGRESAR',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 24),

            Text(
              'Ingreso por Día',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text('5 veces', style: TextStyle(color: Colors.grey[700])),
            SizedBox(height: 8),

            // Gráfico de ingresos
            Container(
              height: 250,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 16.0,
                  top: 16.0,
                  bottom: 8.0,
                ),
                child: Obx(
                  () => LineChart(
                    LineChartData(
                      gridData: FlGridData(show: false),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              String text = '';
                              switch (value.toInt()) {
                                case 1:
                                  text = '1 vez';
                                  break;
                                case 2:
                                  text = '2 veces';
                                  break;
                                case 3:
                                  text = '3 veces';
                                  break;
                                case 4:
                                  text = '4 veces';
                                  break;
                                case 5:
                                  text = '5 veces';
                                  break;
                              }
                              return Text(
                                text,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 10,
                                ),
                              );
                            },
                            reservedSize: 40,
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              String text = '';
                              if (value.toInt() == 0) {
                                text = 'Nov 23';
                              } else if (value.toInt() == 7) {
                                text = '30';
                              } else {
                                text = '${value.toInt() + 23}';
                              }
                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  text,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 10,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          spots: attendanceController.attendanceData.value,
                          isCurved: true,
                          color: Colors.blue,
                          barWidth: 3,
                          isStrokeCapRound: true,
                          dotData: FlDotData(
                            show: true,
                            getDotPainter: (spot, percent, barData, index) {
                              return FlDotCirclePainter(
                                radius: 6,
                                color: Colors.blue,
                                strokeWidth: 2,
                                strokeColor: Colors.white,
                              );
                            },
                          ),
                          belowBarData: BarAreaData(
                            show: true,
                            color: Colors.blue.withOpacity(0.2),
                          ),
                        ),
                      ],
                      minY: 0,
                      maxY: 5,
                    ),
                  ),
                ),
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
                icon: Icon(Icons.home, size: 30, color: Color(0xFF1B8E3D)),
                onPressed: () {
                  // Ya estamos en Home, no necesitamos navegar
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
              // Botón Menú
              IconButton(
                icon: Icon(Icons.menu, size: 30, color: Colors.grey),
                onPressed: () {
                  _showMenuOptions(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
