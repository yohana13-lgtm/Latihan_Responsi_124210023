import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'blogs_detail.dart';

class BlogListPage extends StatefulWidget {
  @override
  _BlogListPageState createState() => _BlogListPageState();
}

class _BlogListPageState extends State<BlogListPage> {
  late List<dynamic> _blogList = [];

  @override
  void initState() {
    super.initState();
    fetchBlog();
  }

  Future<void> fetchBlog() async {
    try {
      final response = await http.get(Uri.parse('https://api.spaceflightnewsapi.net/v4/blogs/'));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        setState(() {
          _blogList = jsonResponse['results'];
        });
      } else {
        throw Exception('Failed to load blogs');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spaceflight Blogs'),
      ),
      body: ListView.builder(
        itemCount: _blogList.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: _blogList[index]['image_url'] != null
                ? Image.network(
              _blogList[index]['image_url'],
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            )
                : SizedBox.shrink(),
            title: Text(_blogList[index]['title']),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => BlogDetailPage(
                    title: _blogList[index]['title'],
                    imageUrl: _blogList[index]['image_url'],
                    summary: _blogList[index]['summary'], blog: {},
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
