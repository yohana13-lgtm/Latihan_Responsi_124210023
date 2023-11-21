import 'package:flutter/material.dart';
import 'package:latihan_responsi/blogs_list.dart';
import 'package:latihan_responsi/reports_list.dart';
import 'news_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<dynamic> blogs = []; // Tambahkan data blogs sesuai respons dari sumber data/API

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Space News App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MainMenu(),
        '/newsList': (context) => NewsListPage(),
        '/blogList': (context) => BlogListPage(), // Sediakan data blogs ke BlogListPage
        '/reportList': (context) => ReportListPage(),
      },
    );
  }
}

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Menu'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/newsList');
              },
              child: Column(
                children: <Widget>[
                  Image.asset(
                    'asset/image/news.png', // Ganti dengan path gambar yang sesuai
                    width: 200,
                    height: 200,
                  ),
                  Text('News'),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/blogList');
              },
              child: Column(
                children: <Widget>[
                  Image.asset(
                    'asset/image/blogs.png', // Ganti dengan path gambar yang sesuai
                    width: 200,
                    height: 200,
                  ),
                  Text('Blog'),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/reportList');
              },
              child: Column(
                children: <Widget>[
                  Image.asset(
                    'asset/image/reports.png', // Ganti dengan path gambar yang sesuai
                    width: 200,
                    height: 200,
                  ),
                  Text('Reports'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
