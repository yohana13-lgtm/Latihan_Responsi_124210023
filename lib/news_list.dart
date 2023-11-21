import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'news_detail.dart';

class NewsListPage extends StatefulWidget {
  @override
  _NewsListPageState createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  late List<dynamic> _newsList = [];

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    try {
      final response = await http.get(Uri.parse('https://api.spaceflightnewsapi.net/v4/articles/?_limit=10'));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        setState(() {
          _newsList = jsonResponse['results']; // Mengambil daftar artikel dari properti "results"
        });
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spaceflight News'),
      ),
      body: _newsList.isNotEmpty // Periksa apakah daftar artikel tidak kosong
          ? ListView.builder(
        itemCount: _newsList.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: _newsList[index]['image_url'] != null
                ? Image.network(
              _newsList[index]['image_url'],
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            )
                : SizedBox.shrink(),
            title: Text(_newsList[index]['title']),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsDetailPage(news: _newsList[index]),
                ),
              );
            },
          );
        },
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}