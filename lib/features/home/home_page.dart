import 'package:flutter/material.dart';
import 'package:hotelino/features/home/presentation/provider/home_provider.dart';
import 'package:hotelino/features/home/presentation/provider/widgets/add_banner.dart';
import 'package:hotelino/features/home/presentation/provider/widgets/home_app_bar.dart';
import 'package:hotelino/features/home/presentation/provider/widgets/search_bar_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    return Scaffold(
      appBar: HomeAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: 16),
            SearchBarWidget(),
            SizedBox(height: 16),
            AddBanner(),
          ],
        ),
      ),
    );
  }
}
