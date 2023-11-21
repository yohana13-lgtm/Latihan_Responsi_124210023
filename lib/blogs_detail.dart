import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BlogDetailPage extends StatelessWidget {
  final Map<String, dynamic> blog;
  final String title;
  final String imageUrl;
  final String summary;

  // Constructor untuk menerima data dari blog yang dipilih
  BlogDetailPage({
    required this.blog,
    required this.title,
    required this.imageUrl,
    required this.summary,
  });

  void openInBrowser() async {
    String url = blog['url'];
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog Detail'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.network(
              imageUrl,
              height: 200, // Sesuaikan dengan tinggi gambar yang diinginkan
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              summary,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openInBrowser(); // Panggil fungsi untuk membuka URL
        },
        child: Icon(Icons.search),
      ),
    );
  }
}
