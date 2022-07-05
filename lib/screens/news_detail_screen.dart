import 'package:flutter/material.dart';
import 'package:news_app/provider/news_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_html/flutter_html.dart';

class NewsDetailScreen extends StatelessWidget {
  final String title;

  const NewsDetailScreen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Consumer<NewsProvider>(
        builder: (context, newsProvider, child) {
          return newsProvider.loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32.0,
                      vertical: 20.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.network(
                          newsProvider.newsDetailModel!.image!,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          newsProvider.newsDetailModel!.title!,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 26.0,
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          newsProvider.newsDetailModel!.createdAt!,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18.0,
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Html(
                          data: newsProvider.newsDetailModel!.description!,
                          style: {
                            "*": Style(
                              fontSize: const FontSize(16.0),
                              margin: const EdgeInsets.all(0),
                            )
                          },
                        ),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
