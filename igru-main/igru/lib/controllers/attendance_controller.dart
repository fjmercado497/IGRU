import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';

class AttendanceController extends GetxController {
  // Datos de asistencia para el gráfico
  final Rx<List<FlSpot>> attendanceData = Rx<List<FlSpot>>([
    FlSpot(0, 0.5), // Nov 23
    FlSpot(1, 1.5), // Nov 24
    FlSpot(2, 2.0), // Nov 25
    FlSpot(3, 2.0), // Nov 26
    FlSpot(4, 3.0), // Nov 27
    FlSpot(5, 2.5), // Nov 28
    FlSpot(6, 3.0), // Nov 29
    FlSpot(7, 5.0), // Nov 30
  ]);

  // Método para registrar una nueva entrada
  void recordAttendance() {
    // Aquí se implementaría la lógica para registrar una nueva entrada
    // Por ahora, solo actualizamos el último valor del gráfico
    final List<FlSpot> updatedData = [...attendanceData.value];
    if (updatedData.isNotEmpty) {
      final lastIndex = updatedData.length - 1;
      final lastValue = updatedData[lastIndex].y;
      updatedData[lastIndex] = FlSpot(lastIndex.toDouble(), lastValue + 0.5);
    }
    attendanceData.value = updatedData;
  }
}
