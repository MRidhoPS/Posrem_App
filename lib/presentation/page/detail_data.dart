import 'package:flutter/material.dart';
import 'package:posrem_webapp/presentation/components/data_card.dart';

class DetailData extends StatelessWidget {
  const DetailData({super.key, required this.data, this.title});

  final Map<String, dynamic> data;
  final dynamic title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DataCard(
                      data: data,
                      title: 'Tinggi Badan',
                      type: 'tb',
                      satuan: 'Cm',
                      height: 0.2,
                      width: 0.2),
                  DataCard(
                      data: data,
                      title: 'Berat Badan',
                      type: 'bb',
                      satuan: 'Kg',
                      height: 0.2,
                      width: 0.2),
                ],
              ),
              DataCard(
                  data: data,
                  title: 'Tekanan Darah',
                  type: 'td',
                  satuan: 'mmHg',
                  height: 0.2,
                  width: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DataCard(
                      data: data,
                      title: 'Lingkar Lengan',
                      type: 'lila',
                      satuan: 'Cm',
                      height: 0.2,
                      width: 0.2),
                  DataCard(
                      data: data,
                      title: 'Lingkar Perut',
                      type: 'lp',
                      satuan: 'Cm',
                      height: 0.2,
                      width: 0.2),
                ],
              ),
              DataCard(
                  data: data,
                  title: 'Bmi',
                  type: 'bmi',
                  satuan: '',
                  height: 0.2,
                  width: 1),
            ],
          ),
        ),
      ),
    );
  }
}
