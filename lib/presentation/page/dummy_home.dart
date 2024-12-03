import 'package:flutter/material.dart';

class DummyHomePage extends StatelessWidget {
  final Map<String, dynamic> userData;

  const DummyHomePage({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    final name = userData['name'] ?? "Tidak diketahui";
    final gender = userData['gender'] ?? "Tidak diketahui";
    final address = userData['address'] ?? "Tidak diketahui";
    final healthData = userData['data'] as Map<String, dynamic>? ?? {};

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Selamat datang, $name!",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text("Gender: $gender"),
            Text("Alamat: $address"),
            const SizedBox(height: 16),
            const Text(
              "Perkembangan Kesehatan:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: healthData.isEmpty
                  ? const Text("Belum ada data kesehatan.")
                  : ListView(
                      children: healthData.entries.map((entry) {
                        final data = entry.value as Map<String, dynamic>;
                        return Card(
                          margin: const EdgeInsets.all(8),
                          child: ListTile(
                            title:
                                Text("Tanggal: ${data['tanggal_pencatatan']}"),
                            subtitle: Text(
                              "Tinggi Badan: ${data['tb']} cm\n"
                              "Berat Badan: ${data['bb']} kg\n"
                              "BMI: ${data['bmi']} (${data['ket_bmi']})",
                            ),
                          ),
                        );
                      }).toList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
