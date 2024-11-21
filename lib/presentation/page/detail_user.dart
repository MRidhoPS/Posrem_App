import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
                monthlyData.sort((a, b) {
                  DateTime dateA = a['createdAt'].toDate();
                  DateTime dateB = b['createdAt'].toDate();
                  return dateA.compareTo(dateB);
                });
              }

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      WidgetUsers(data: data, title: 'Name', type: 'name'),
                      WidgetUsers(data: data, title: 'Gender', type: 'gender'),
                      WidgetUsers(data: data, title: 'Born', type: 'born'),
                      WidgetUsers(
                          data: data, title: 'Religion', type: 'religion'),
                      WidgetUsers(
                          data: data, title: 'Address', type: 'address'),
                      WidgetUsers(
                          data: data, title: 'Education', type: 'education'),
                      WidgetUsers(
                          data: data, title: 'Phone Number', type: 'phoneNum'),
                      const SizedBox(height: 30),
                      const Text(
                        'Monthly Data:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const SizedBox(height: 15),
                      ListView.builder(
                        physics:
                            const NeverScrollableScrollPhysics(),
                        shrinkWrap: true, 
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
                                      builder: (context) => DetailData(
                                        data: entry,
                                        title: Formatter().formatDate(entry),
                                      ),
                                    ),
                                  );
                                },
                                title: Text(
                                  Formatter().formatDate(entry),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
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

class WidgetUsers extends StatelessWidget {
  const WidgetUsers({
    super.key,
    required this.data,
    required this.title,
    required this.type,
  });

  final Map<String, dynamic> data;
  final String title;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title:',
            style:
                GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500),
          ),
          Text(
            '${data[type]}',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
