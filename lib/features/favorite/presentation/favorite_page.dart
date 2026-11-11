import 'package:flutter/material.dart';
import 'package:hotelino/shared/widget/search_bar_widget.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'هتل های مرد علاقه',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(height: 16),
            SearchBarWidget(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
