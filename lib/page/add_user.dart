import 'package:flutter/material.dart';
import 'package:posrem_webapp/controller/input_controller.dart';
import 'package:posrem_webapp/database/firebase_database.dart';
import 'package:posrem_webapp/page/home_user.dart';
import 'package:posrem_webapp/provider/list_provider.dart';
import 'package:provider/provider.dart';

class AddUser extends StatelessWidget {
  const AddUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            width: 500,
            height: 200,
            child: Column(
              children: [
                const Text('Add User'),
                TextFormField(
                  controller: nameController, // Gunakan controller
                  decoration: const InputDecoration(
                    label: Text('Name'),
                  ),
                ),
                TextFormField(
                  controller: maritalController, // Gunakan controller
                  decoration: const InputDecoration(
                    label: Text('Marital Status'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    try {
                      DatabaseServices().createUser(
                        nameController.text,
                        maritalController.text,
                      );

                      context.read<ListProvider>().fethAllUser();

                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ));
                      print('Add Data Press');
                    } catch (e) {
                      AlertDialog(title: Text(e.toString()));
                    }
                  },
                  child: const Text("Add User"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
