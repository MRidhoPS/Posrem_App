import 'package:flutter/material.dart';

class DetailData extends StatelessWidget {
  const DetailData({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Tinggi Badan: ${data['tb']}'),
          Text('Berat Badan: ${data['bb']}'),
          Text('Tekanan Darah: ${data['td']}'),
          Text('Lingkar Lengan: ${data['lila']}'),
          Text('Lingkar Perut: ${data['lp']}'),
          Text('Bmi: ${data['bmi']}'),
          Text('Bmi Description: ${data['bmiDesc']}'),
        ],
      ),
    );
  }
}
