import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:posrem_webapp/page/add_monthlydata_user.dart';
import 'package:posrem_webapp/provider/detailuser_provider.dart';
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
              String name = data['name'] ?? 'No Name';
              String maritalStatus = data['marital'] ?? 'Unknown';

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
                    Text('Name: $name'),
                    Text('Marital Status: $maritalStatus'),
                    const SizedBox(height: 16),
                    const Text(
                      'Monthly Data:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    // Display monthly data
                    Expanded(
                      child: ListView.builder(
                        itemCount: monthlyData.length,
                        itemBuilder: (context, index) {
                          var entry = monthlyData[index];
                          DateTime createdAt = entry['createdAt'].toDate();
                          String monthYear =
                              DateFormat('MMMM yyyy').format(createdAt);
                          String bmi = entry['bmi'].toString();
                          String bmiDesc = entry['bmiDesc'] ?? 'No Description';

                          return Card(
                            child: ListTile(
                              title: Text('Date: $monthYear'),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('BMI: $bmi'),
                                  Text('Description: $bmiDesc'),
                                ],
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
              context.read<DetailuserProvider>().fetchDetailUser(userId);
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
