import 'package:flutter/material.dart';
import 'package:posrem_webapp/data/controller/formatter.dart';
import 'package:posrem_webapp/presentation/page/add_monthlydata_user.dart';
import 'package:posrem_webapp/presentation/page/detail_data.dart';
import 'package:posrem_webapp/presentation/provider/detailuser_provider.dart';
import 'package:provider/provider.dart';

class DetailUser extends StatelessWidget {
  const DetailUser({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DetailuserProvider()..fetchDetailUser(userId),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('User Details'),
        ),
        body: Consumer<DetailuserProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (provider.usersDetails == null) {
              return const Center(child: Text('No data available.'));
            } else {
              final data = provider.usersDetails!;

              List<Map<String, dynamic>> monthlyData = [];
              if (data['data'] != null) {
                Map<String, dynamic> dataEntries = data['data'];
                dataEntries.forEach((key, value) {
                  var entry = value as Map<String, dynamic>;
                  monthlyData.add(entry);
                });
                // Sort monthly data by `createdAt`
                monthlyData.sort((a, b) {
                  DateTime dateA = a['createdAt'].toDate();
                  DateTime dateB = b['createdAt'].toDate();
                  return dateA.compareTo(dateB);
                });
              }

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name: ${data['name']}'),
                    Text('Gender: ${data['gender']}'),
                    Text('Born: ${data['born']}'),
                    Text('Religion: ${data['religion']}'),
                    Text('Address: ${data['address']}'),
                    Text('Education: ${data['education']}'),
                    Text('Phone Number: ${data['phoneNum']}'),
                    const SizedBox(height: 25),
                    const Text(
                      'Monthly Data:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    Expanded(
                      child: ListView.builder(
                        itemCount: monthlyData.length,
                        itemBuilder: (context, index) {
                          var entry = monthlyData[index];

                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 20, 0, 20),
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailData(data: entry),
                                      ));
                                },
                                title: Text(Formatter().formatDate(
                                  entry,
                                )),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(
              builder: (context) => AddMonthlyData(id: userId),
            ))
                .then((_) {
              // Refresh data when returning to this page
              if (context.mounted) {
                context.read<DetailuserProvider>().fetchDetailUser(userId);
              }
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
