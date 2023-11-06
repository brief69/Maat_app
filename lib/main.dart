

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gdv/models/post.dart';
import 'package:gdv/viewmodels/post_viewmodel.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'gdv',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          // Add other TextStyle configurations as needed.
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.white),
          // Add other AppBarTheme configurations as needed.
        ),
        tabBarTheme: const TabBarTheme(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
        ), colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(background: Colors.black),
      ),
      home: const HomeView(),
    );
  }
}

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<PostModel>> tweets = ref.watch(postListProvider);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(text: 'フォロー中'),
              Tab(text: 'おすすめ'),
              Tab(text: '通知'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // ここにフォロー中のコンテンツを配置します。
            _buildListView(tweets),
            // ここにおすすめのコンテンツを配置します。
            _buildListView(tweets),
            // ここに通知のコンテンツを配置します。
            _buildListView(tweets),
          ],
        ),
      ),
    );
  }

  Widget _buildListView(AsyncValue<List<PostModel>> tweets) {
    return tweets.when(
      data: (List<PostModel> data) => ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          PostModel tweet = data[index];
          return ListTile(
            title: Text(tweet.content, style: const TextStyle(color: Colors.white)),
            subtitle: Text(
              tweet.createdAt.toString(),
              style: const TextStyle(color: Colors.white70),
            ),
          );
        },
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, stack) => Center(child: Text('Error: $e', style: const TextStyle(color: Colors.white))),
    );
  }
}
