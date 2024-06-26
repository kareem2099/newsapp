import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/news_provider.dart';
import 'package:news_app/screens/news_detail_page.dart';
import 'package:news_app/models/enums.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  int value = 0;
  final List<Map<String, String>> categories = [
    {'name': 'Business', 'icon': 'assets/images/business.png'},
    {'name': 'Entertainment', 'icon': 'assets/images/entertainment.png'},
    {'name': 'Health', 'icon': 'assets/images/health.png'},
    {'name': 'Science', 'icon': 'assets/images/science.png'},
    {'name': 'Sports', 'icon': 'assets/images/sport.png'},
    {'name': 'Technology', 'icon': 'assets/images/technology.png'},
  ];

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('News')),
      body: Column(
        children: [
          AnimatedToggleSwitch<NewsLanguage>.rolling(
            current: newsProvider.currentLanguage,
            values: NewsLanguage.values.toList(),
            onChanged: (language) {
              Provider.of<NewsProvider>(context, listen: false)
                  .setLanguageAndFetchNews(language);
            },
            iconBuilder: (language, isSelected) {
              return Text(language.code.toUpperCase());
            },
          ),
          SizedBox(
            height: 100, // Fixed height for the category row
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return GestureDetector(
                  onTap: () => newsProvider
                      .changeCategory(category['name']!), // Update category
                  child: Container(
                    width: 100,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(category['icon']!,
                            width: 40), // Category icon
                        Text(category['name']!), // Category name
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          TextField(
            onChanged: (value) {
              Provider.of<NewsProvider>(context, listen: false)
                  .setSearchIn(value);
            },
            decoration: const InputDecoration(
              labelText: 'Search',
            ),
          ),
          DropdownButton<String>(
            value: Provider.of<NewsProvider>(context).sortBy,
            items: <String>['relevancy', 'popularity', 'publishedAt']
                .map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) {
              Provider.of<NewsProvider>(context, listen: false)
                  .setSortBy(value!);
            },
          ),
          Expanded(
            child: newsProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                    onRefresh: () async {
                      newsProvider.fetchNews(newsProvider.currentLanguage);
                    },
                    child: ListView.builder(
                      itemCount: newsProvider.newsArticles.length,
                      itemBuilder: (context, index) {
                        final article = newsProvider.newsArticles[index];
                        return ListTile(
                          title: Text(article.title),
                          subtitle: Text(article.description),
                          leading: article.urlToImage.isNotEmpty
                              ? CachedNetworkImage(
                                  imageUrl: article.urlToImage,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                )
                              : const Icon(Icons.broken_image),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      NewsDetailPage(article)),
                            );
                          },
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
