import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsDetailPage extends StatelessWidget {
  final Map<String, dynamic> news;

  NewsDetailPage({required this.news});

  void openInBrowser() async {
    String url = news['url'];
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
        title: Text('News Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Menampilkan gambar jika tersedia
            if (news['image_url'] != null)
              Image.network(
                news['image_url'],
                height: 200,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            SizedBox(height: 20),
            // Menampilkan judul artikel
            Text(
              news['title'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // Menampilkan isi berita atau ringkasan
            Text(
              news['summary'],
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            // Menampilkan tombol untuk membuka URL artikel
            ElevatedButton(
              onPressed: () {
                // Mengarahkan pengguna ke URL artikel jika tersedia
                if (news['url'] != null && news['url'] != 'string') {
                  // Buka URL dalam webview atau browser
                  // Misalnya:
                  // launchURL(news['url']);
                }
              },
              child: Text('Read More'),
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
