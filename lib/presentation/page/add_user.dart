import 'package:flutter/material.dart';
import 'package:posrem_webapp/presentation/components/button_create_user.dart';
import 'package:posrem_webapp/data/controller/input_controller.dart';

class AddUser extends StatelessWidget {
  const AddUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add User'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            width: 500,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    label: Text('Name'),
                  ),
                ),
                TextFormField(
                  controller: genderController,
                  decoration: const InputDecoration(
                    label: Text('Gender'),
                  ),
                ),
                TextFormField(
                  controller: bornController,
                  decoration: const InputDecoration(
                    label: Text('Born'),
                  ),
                ),
                TextFormField(
                  controller: religionController,
                  decoration: const InputDecoration(
                    label: Text('Religion'),
                  ),
                ),
                TextFormField(
                  controller: addressController,
                  decoration: const InputDecoration(
                    label: Text('Address'),
                  ),
                ),
                TextFormField(
                  controller: educationController,
                  decoration: const InputDecoration(
                    label: Text('Education'),
                  ),
                ),
                TextFormField(
                  controller: phoneNumController,
                  decoration: const InputDecoration(
                    label: Text('Phone Number'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                submitAddUser(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
