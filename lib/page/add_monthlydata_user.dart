import 'package:flutter/material.dart';
import 'package:posrem_webapp/controller/input_controller.dart';
import 'package:posrem_webapp/database/firebase_database.dart';
import 'package:posrem_webapp/page/home_user.dart';
import 'package:posrem_webapp/provider/list_provider.dart';
import 'package:provider/provider.dart';

class AddMonthlyData extends StatelessWidget {
  const AddMonthlyData({
    super.key,
    this.id,
  });

  final dynamic id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          width: 500,
          height: 500,
          child: Column(
            children: [
              const Text('Add Monthly Data'),
              TextFormField(
                controller: bmiController,
                decoration: const InputDecoration(
                  label: Text('BMI'),
                ),
              ),
              TextFormField(
                controller: bmiDescController,
                decoration: const InputDecoration(
                  label: Text('BMI Description'),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  try {
                    DatabaseServices().addMonthlyData(
                      bmiController.text,
                      bmiDescController.text,
                      id,
                    );

                    context.read<ListProvider>().fethAllUser();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ));

                    bmiController.clear();
                    bmiDescController.clear();
                    idController.clear();
                  } catch (e) {
                    AlertDialog(title: Text(e.toString()));
                  }
                },
                child: const Text("Monthly Updated"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
