class AppConstants {
  static const String apiKey = 'd0a34f221580978dc8fd76c8e755f0b0';
  static const String baseUrl = 'https://gnews.io/api/v4';

  // All 26 districts of Andhra Pradesh
  static const List<String> andhraDistricts = [
    'Anantapur',
    'Chittoor',
    'East Godavari',
    'Eluru',
    'Guntur',
    'Kakinada',
    'Konaseema',
    'Krishna',
    'Kurnool',
    'Nandyal',
    'NTR',
    'Palnadu',
    'Parvathipuram Manyam',
    'Prakasam',
    'Sri Potti Sriramulu Nellore',
    'Sri Sathya Sai',
    'Srikakulam',
    'Tirupati',
    'Visakhapatnam',
    'Vizianagaram',
    'West Godavari',
    'YSR Kadapa',
  ];

  // GNews API top-headlines categories
  static const List<Map<String, String>> topHeadlineCategories = [
    {'id': 'general', 'label': 'General', 'icon': '🌐'},
    {'id': 'world', 'label': 'World', 'icon': '🌍'},
    {'id': 'nation', 'label': 'Nation', 'icon': '🇮🇳'},
    {'id': 'business', 'label': 'Business', 'icon': '💼'},
    {'id': 'technology', 'label': 'Technology', 'icon': '💻'},
    {'id': 'entertainment', 'label': 'Entertainment', 'icon': '🎬'},
    {'id': 'sports', 'label': 'Sports', 'icon': '⚽'},
    {'id': 'science', 'label': 'Science', 'icon': '🔬'},
    {'id': 'health', 'label': 'Health', 'icon': '🏥'},
  ];

  // Search-based domain topics (used with the /search endpoint)
  static const List<Map<String, String>> searchTopics = [
    // Politics & Economy
    {'id': 'politics', 'label': 'Politics', 'icon': '🏛️', 'group': 'Politics & Economy'},
    {'id': 'economy', 'label': 'Economy', 'icon': '📈', 'group': 'Politics & Economy'},
    {'id': 'finance', 'label': 'Finance', 'icon': '💰', 'group': 'Politics & Economy'},
    {'id': 'personal finance', 'label': 'Personal Finance', 'icon': '🏦', 'group': 'Politics & Economy'},
    {'id': 'digital currencies', 'label': 'Crypto', 'icon': '₿', 'group': 'Politics & Economy'},

    // Sports
    {'id': 'cricket', 'label': 'Cricket', 'icon': '🏏', 'group': 'Sports'},
    {'id': 'football', 'label': 'Football', 'icon': '⚽', 'group': 'Sports'},
    {'id': 'tennis', 'label': 'Tennis', 'icon': '🎾', 'group': 'Sports'},
    {'id': 'basketball', 'label': 'Basketball', 'icon': '🏀', 'group': 'Sports'},
    {'id': 'hockey', 'label': 'Hockey', 'icon': '🏑', 'group': 'Sports'},
    {'id': 'golf', 'label': 'Golf', 'icon': '⛳', 'group': 'Sports'},
    {'id': 'motor sports', 'label': 'Motor Sports', 'icon': '🏎️', 'group': 'Sports'},
    {'id': 'sports betting', 'label': 'Sports Betting', 'icon': '🎰', 'group': 'Sports'},

    // Technology
    {'id': 'mobile', 'label': 'Mobile', 'icon': '📱', 'group': 'Technology'},
    {'id': 'gaming', 'label': 'Gaming', 'icon': '🎮', 'group': 'Technology'},
    {'id': 'internet security', 'label': 'Cybersecurity', 'icon': '🔐', 'group': 'Technology'},
    {'id': 'gadgets', 'label': 'Gadgets', 'icon': '⌚', 'group': 'Technology'},
    {'id': 'virtual reality', 'label': 'VR/AR', 'icon': '🥽', 'group': 'Technology'},
    {'id': 'robotics', 'label': 'Robotics', 'icon': '🤖', 'group': 'Technology'},
    {'id': 'artificial intelligence', 'label': 'AI', 'icon': '🧠', 'group': 'Technology'},

    // Health
    {'id': 'nutrition', 'label': 'Nutrition', 'icon': '🥗', 'group': 'Health'},
    {'id': 'public health', 'label': 'Public Health', 'icon': '🏥', 'group': 'Health'},
    {'id': 'mental health', 'label': 'Mental Health', 'icon': '🧘', 'group': 'Health'},
    {'id': 'medicine', 'label': 'Medicine', 'icon': '💊', 'group': 'Health'},

    // Science
    {'id': 'space', 'label': 'Space', 'icon': '🚀', 'group': 'Science'},
    {'id': 'environment', 'label': 'Environment', 'icon': '🌿', 'group': 'Science'},
    {'id': 'wildlife', 'label': 'Wildlife', 'icon': '🦁', 'group': 'Science'},
    {'id': 'neuroscience', 'label': 'Neuroscience', 'icon': '🧬', 'group': 'Science'},
    {'id': 'physics', 'label': 'Physics', 'icon': '⚛️', 'group': 'Science'},

    // Entertainment
    {'id': 'celebrities', 'label': 'Celebrities', 'icon': '⭐', 'group': 'Entertainment'},
    {'id': 'movies', 'label': 'Movies', 'icon': '🎥', 'group': 'Entertainment'},
    {'id': 'music', 'label': 'Music', 'icon': '🎵', 'group': 'Entertainment'},
    {'id': 'tv', 'label': 'TV', 'icon': '📺', 'group': 'Entertainment'},

    // Lifestyle
    {'id': 'food', 'label': 'Food', 'icon': '🍛', 'group': 'Lifestyle'},
    {'id': 'travel', 'label': 'Travel', 'icon': '✈️', 'group': 'Lifestyle'},
    {'id': 'fashion', 'label': 'Fashion', 'icon': '👗', 'group': 'Lifestyle'},
    {'id': 'education', 'label': 'Education', 'icon': '📚', 'group': 'Lifestyle'},
    {'id': 'jobs', 'label': 'Jobs', 'icon': '💼', 'group': 'Lifestyle'},
  ];
}