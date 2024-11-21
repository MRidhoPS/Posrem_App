import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

class DataCard extends StatelessWidget {
  const DataCard({
    super.key,
    required this.data,
    required this.title,
    required this.type,
    required this.satuan,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;
  final String title;
  final String type;
  final String satuan;

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return title == 'Bmi'
        ? GestureDetector(
            onTap: () {
              AwesomeDialog(
                body: Column(
                  children: [
                    Text(
                      data['bmiDesc'] != 'Normal' ? 'Warning' : 'Good',
                      style: GoogleFonts.poppins(
                          fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Bmi Status:',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      data['bmiDesc'],
                      style: GoogleFonts.poppins(
                          fontSize: 20,
                          color: data['bmiDesc'] != 'Normal'
                              ? Colors.red
                              : Colors.green,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                context: context,
                dialogType: data['bmiDesc'] != 'Normal' ? DialogType.warning : DialogType.success,
                borderSide: BorderSide(
                  color:
                      data['bmiDesc'] != 'Normal' ? Colors.red : Colors.green,
                  width: 2,
                ),
                width: 280,
                buttonsBorderRadius: const BorderRadius.all(
                  Radius.circular(2),
                ),
                dismissOnTouchOutside: true,
                dismissOnBackKeyPress: false,
                headerAnimationLoop: false,
                animType: AnimType.scale,
                title: 'INFO',
                desc: 'Your body was\n${data['bmiDesc']}!',
                descTextStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                showCloseIcon: true,
                btnCancelOnPress: () {},
                btnOkOnPress: () {},
              ).show();
            },
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              height: MediaQuery.of(context).size.height * height,
              width: MediaQuery.of(context).size.height * width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black,
                        blurRadius: 2,
                        offset: Offset(2, 4),
                        spreadRadius: 2)
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                        color: Colors.black38,
                        fontWeight: FontWeight.w600,
                        fontSize: 17),
                  ),
                  title != 'Bmi'
                      ? Text(
                          '${data[type]} $satuan',
                          style: GoogleFonts.poppins(
                              color: Colors.black87,
                              fontWeight: FontWeight.w600,
                              fontSize: 24),
                        )
                      : Text(
                          '${data[type]}',
                          style: GoogleFonts.poppins(
                              color: Colors.black87,
                              fontWeight: FontWeight.w600,
                              fontSize: 24),
                        ),
                ],
              ),
            ),
          )
        : Container(
            margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
            height: MediaQuery.of(context).size.height * height,
            width: MediaQuery.of(context).size.height * width,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black,
                      blurRadius: 2,
                      offset: Offset(2, 4),
                      spreadRadius: 2)
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                      color: Colors.black38,
                      fontWeight: FontWeight.w600,
                      fontSize: 17),
                ),
                title != 'Bmi'
                    ? Text(
                        '${data[type]} $satuan',
                        style: GoogleFonts.poppins(
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                            fontSize: 24),
                      )
                    : Text(
                        '${data[type]}',
                        style: GoogleFonts.poppins(
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                            fontSize: 24),
                      ),
              ],
            ),
          );
  }
}
