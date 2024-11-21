import 'package:flutter/material.dart';
import 'package:posrem_webapp/presentation/page/detail_user.dart';
import 'package:posrem_webapp/presentation/provider/list_provider.dart';
import 'package:provider/provider.dart';

class DataUsers extends StatelessWidget {
  const DataUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Users'),
      ),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Consumer<ListProvider>(
            builder: (context, listProvider, child) {
              if (listProvider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (listProvider.error != null) {
                return Center(child: Text('Error: ${listProvider.error}'));
              } else if (listProvider.users.isEmpty) {
                return const Center(child: Text('No data found'));
              } else {
                return ListView.builder(
                  itemCount: listProvider.users.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> user = listProvider.users[index];
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailUser(userId: user['id']),
                          ),
                        );
                      },
                      title: Text(user['name'] ?? 'No Name'),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
