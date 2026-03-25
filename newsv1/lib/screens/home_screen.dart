/*import 'package:flutter/material.dart';
import 'services/news_service.dart';
import 'widgets/news_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final NewsService service = NewsService();

  Future<List>? futureNews;

  String? selectedState;
  String? selectedDistrict;
  String selectedCategory = "general";

  TextEditingController searchController = TextEditingController();

  // Andhra Pradesh only
  Map<String, List<String>> locations = {
    "Andhra Pradesh": [
      "Kakinada",
      "Visakhapatnam",
      "Vijayawada",
      "Guntur",
      "Tirupati",
      "Nellore",
      "Rajahmundry",
      "Anantapur"
    ]
  };

  List<String> categories = [
    "business",
    "entertainment",
    "general",
    "health",
    "science",
    "sports",
    "technology"
  ];

  @override
  void initState() {
    super.initState();
    futureNews = service.fetchNews("Andhra Pradesh general");
  }

  void fetchNews() {
    if (selectedDistrict != null) {

      String query = "${selectedDistrict!} $selectedCategory";

      if (searchController.text.isNotEmpty) {
        query += " ${searchController.text}";
      }

      setState(() {
        futureNews = service.fetchNews(query);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("News Hub")),

      body: Column(
        children: [

          // 🔍 SEARCH BAR
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search news (e.g. cricket, politics...)",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onSubmitted: (_) => fetchNews(),
            ),
          ),

          // 🔽 STATE DROPDOWN
          DropdownButton<String>(
            hint: const Text("Select State"),
            value: selectedState,
            items: locations.keys.map((state) {
              return DropdownMenuItem(
                value: state,
                child: Text(state),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedState = value;
                selectedDistrict = null;
              });
            },
          ),

          // 🔽 DISTRICT DROPDOWN
          DropdownButton<String>(
            hint: const Text("Select District"),
            value: selectedDistrict,
            items: selectedState == null
                ? []
                : locations[selectedState]!.map((district) {
                    return DropdownMenuItem(
                      value: district,
                      child: Text(district),
                    );
                  }).toList(),
            onChanged: (value) {
              setState(() {
                selectedDistrict = value;
              });
              fetchNews();
            },
          ),

          // 🔽 CATEGORY SCROLL
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (_, i) {
                final cat = categories[i];

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = cat;
                    });
                    fetchNews();
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: selectedCategory == cat
                          ? Colors.blue
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        cat.toUpperCase(),
                        style: TextStyle(
                          color: selectedCategory == cat
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const Divider(),

          // 📰 NEWS LIST
          Expanded(
            child: FutureBuilder<List>(
              future: futureNews,
              builder: (context, snapshot) {

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return const Center(child: Text("Error loading news"));
                }

                final articles = snapshot.data ?? [];

                if (articles.isEmpty) {
                  return const Center(
                      child: Text("No news found for this selection"));
                }

                return ListView.builder(
                  itemCount: articles.length,
                  itemBuilder: (_, i) {
                    return NewsCard(article: articles[i]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/news_provider.dart';
import '../../utils/app_theme.dart';
import '../../widgets/news_card.dart';
import '../../widgets/filter_bar.dart';
import '../../widgets/district_selector.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _showSearch = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NewsProvider>().fetchNews();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NewsProvider>();

    return Scaffold(
      appBar: _buildAppBar(context, provider),
      body: Column(
        children: [
          // Search bar (conditional)
          if (_showSearch) _buildSearchBar(context, provider),

          // Filter bar
          const FilterBar(),
          const Divider(height: 1),

          // News list
          Expanded(
            child: _buildBody(provider),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, NewsProvider provider) {
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('AP NewsWatch'),
          Text(
            _subtitle(provider),
            style: const TextStyle(fontSize: 11, color: Colors.white70),
          ),
        ],
      ),
      actions: [
        // District selector button
        TextButton.icon(
          onPressed: () => DistrictSelector.show(context),
          icon: const Icon(Icons.location_on, color: Colors.white, size: 16),
          label: Text(
            provider.selectedDistrict,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        IconButton(
          icon: Icon(_showSearch ? Icons.close : Icons.search,
              color: Colors.white),
          onPressed: () {
            setState(() {
              _showSearch = !_showSearch;
              if (!_showSearch) _searchController.clear();
            });
          },
        ),
        IconButton(
          icon: const Icon(Icons.refresh, color: Colors.white),
          onPressed: provider.isLoading ? null : provider.refresh,
        ),
      ],
    );
  }

  String _subtitle(NewsProvider provider) {
    switch (provider.mode) {
      case NewsMode.districtOnly:
        return '${provider.selectedDistrict} · Latest News';
      case NewsMode.categoryOnly:
        return 'Top Headlines · India';
      case NewsMode.districtAndTopic:
        return '${provider.selectedDistrict} · ${provider.selectedTopic}';
    }
  }

  Widget _buildSearchBar(BuildContext context, NewsProvider provider) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
      child: TextField(
        controller: _searchController,
        autofocus: true,
        decoration: InputDecoration(
          hintText: 'Search news...',
          prefixIcon: const Icon(Icons.search, color: AppTheme.primary),
          suffixIcon: IconButton(
            icon: const Icon(Icons.send, color: AppTheme.accent),
            onPressed: () {
              if (_searchController.text.trim().isNotEmpty) {
                provider.searchCustom(_searchController.text.trim());
                FocusScope.of(context).unfocus();
              }
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: AppTheme.chipBg,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        ),
        onSubmitted: (value) {
          if (value.trim().isNotEmpty) {
            provider.searchCustom(value.trim());
          }
        },
      ),
    );
  }

  Widget _buildBody(NewsProvider provider) {
    if (provider.isLoading) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(color: AppTheme.primary),
            SizedBox(height: 12),
            Text('Fetching news...', style: TextStyle(color: AppTheme.textSecondary)),
          ],
        ),
      );
    }

    if (provider.errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 12),
              Text(
                provider.errorMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppTheme.textSecondary),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: provider.refresh,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (provider.articles.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.newspaper, size: 64, color: AppTheme.chipBg),
            const SizedBox(height: 12),
            const Text(
              'No news found.\nTry a different filter or district.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppTheme.textSecondary),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: provider.refresh,
              child: const Text('Refresh'),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: provider.refresh,
      color: AppTheme.primary,
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 16, top: 4),
        itemCount: provider.articles.length,
        itemBuilder: (_, i) => NewsCard(article: provider.articles[i]),
      ),
    );
  }
}