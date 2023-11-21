import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:latihan_responsi/reports_detail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Space Reports',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ReportListPage(),
    );
  }
}

class ReportListPage extends StatefulWidget {
  @override
  _ReportListPageState createState() => _ReportListPageState();
}

class _ReportListPageState extends State<ReportListPage> {
  List<Map<String, dynamic>> reports = [];

  @override
  void initState() {
    super.initState();
    fetchReports();
  }

  Future<void> fetchReports() async {
    final response = await http.get(
      Uri.parse('https://api.spaceflightnewsapi.net/v4/reports/'),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      if (mounted) {
        setState(() {
          reports = List<Map<String, dynamic>>.from(jsonData['results']);
        });
      }
    } else {
      throw Exception('Failed to load blogs');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report List'),
      ),
      body: ListView.builder(
        itemCount: reports.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.network(
              reports[index]['image_url'],
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(reports[index]['title']),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReportDetailPage(report: reports[index]),
                ),
              );
            },

          );
        },
      ),
    );
  }
}

// Add navigation to a detail page or any other actions upon tapping a report
