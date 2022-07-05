import 'package:flutter/material.dart';
import 'package:news_app/provider/news_provider.dart';
import 'package:news_app/screens/news_detail_screen.dart';
import 'package:provider/provider.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 100,
        title: Text('191011401981_Budi Setio Nugroho',style: TextStyle(color: Colors.black),),

      ),
      body: Consumer<NewsProvider>(
        builder: (context, newsProvider, child) {
          return newsProvider.loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(32.0),
                  itemCount: newsProvider.getNewsCount(),
                  itemBuilder: (context, index) {
                    return Card(
                      child: GestureDetector(
                        onTap: () {
                          navigateDetailScreen(
                              newsProvider, newsProvider.newsModel[index].id!);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewsDetailScreen(
                                      title: newsProvider
                                          .newsDetailModel!.title!)));
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                newsProvider.newsModel[index].image!,
                                width: 100,
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12.0,
                                  horizontal: 8.0,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      newsProvider.newsModel[index].title!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Text(
                                      newsProvider.newsModel[index].createdAt!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                    height: 10.0,
                  ),
                );
        },
      ),
    );
  }

  navigateDetailScreen(NewsProvider recipeProvider, int recipeId) async {
    recipeProvider.toggleLoading();
    await recipeProvider.fetchNewsDetail(recipeId);
  }
}
