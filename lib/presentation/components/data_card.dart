import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:posrem_webapp/presentation/components/data_container.dart';

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
                dialogType: data['bmiDesc'] != 'Normal'
                    ? DialogType.warning
                    : DialogType.success,
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
            child: DataContainer(
              height: height,
              width: width,
              title: title,
              data: data,
              type: type,
              satuan: satuan,
            ),
          )
        : DataContainer(
            height: height,
            width: width,
            title: title,
            data: data,
            type: type,
            satuan: satuan);
  }
}
