import 'package:flutter/material.dart';
import 'news_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NewsService service = NewsService();

  late Future<List<Map<String, dynamic>>> future;

  String selectedCountry = "in";
  String selectedDomain = "business";

  final Map<String, String> countries = {
    "India": "in",
    "USA": "us",
    "UK": "gb",
    "Australia": "au"
  };

  final Map<String, String> domains = {
    "Business": "business",
    "Entertainment": "entertainment",
    "Finance": "finance",
    "Politics": "politics",
    "Technology": "technology",
    "Sports": "sports",
    "Ai": "ai",
  };

  @override
  void initState() {
    super.initState();
    future = service.fetchNews(selectedCountry, selectedDomain);
  }

  void changeCountry(String code) {
    setState(() {
      selectedCountry = code;
      future = service.fetchNews(code, selectedDomain);
    });
  }

  void changeDomain(String domain) {
    setState(() {
      selectedDomain = domain;
      future = service.fetchNews(selectedCountry, domain);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Top News"),
        actions: [
          DropdownButton(
            value: selectedCountry,
            underline: SizedBox(),
            items: countries.entries.map((e) {
              return DropdownMenuItem(
                value: e.value,
                child: Text(e.key),
              );
            }).toList(),
            onChanged: (val) => changeCountry(val!),
          ),
          DropdownButton(
            value: selectedDomain,
            underline: SizedBox(),
            items: domains.entries.map((e) {
              return DropdownMenuItem(
                value: e.value,
                child: Text(e.key),
              );
            }).toList(),
            onChanged: (val) => changeDomain(val!),
          )
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error"));
          }

          final articles = snapshot.data ?? [];

          return ListView.builder(
            itemCount: articles.length,
            itemBuilder: (_, i) {
              final a = articles[i];

              return ListTile(
                title: Text(a["title"] ?? ""),
                subtitle: Text(a["description"] ?? ""),
              );
            },
          );
        },
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'My Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('logout'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('MY profile'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
