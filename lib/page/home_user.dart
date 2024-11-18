import 'package:flutter/material.dart';
import 'package:posrem_webapp/components/top_banner.dart';
import 'package:posrem_webapp/components/widget_list.dart';
import 'package:posrem_webapp/page/add_user.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              TopBanner(),
              DataUsers()
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddUser(),
            ));
      }),
    );
  }
}
