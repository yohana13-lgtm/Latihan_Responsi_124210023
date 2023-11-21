// pada NewsDetailPage:
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
            // Tampilkan informasi berita di sini
            Text(
              news['title'],
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 10.0),
            Image.network(
              news['image_url'],
              width: double.infinity,
              height: 200.0,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10.0),
            Text(
              news['summary'],
              style: TextStyle(fontSize: 16.0),
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
