import 'package:flutter/material.dart';
import 'package:hotelino/features/favorite/data/provider/favorite_provider.dart';
import 'package:hotelino/features/favorite/presentation/widget/favorite_item.dart';
import 'package:hotelino/shared/widget/search_bar_widget.dart';
import 'package:provider/provider.dart';

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
            Consumer<FavoriteProvider>(
              builder: (context, favoritemProvider, child) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: favoritemProvider.favoriteHotelList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      child: FavoriteHotelCard(
                        hotel: favoritemProvider.favoriteHotelList[index],
                        onRemoveFavotiteClicked: (String hotelid) {
                          favoritemProvider.toggleFavorite(hotelid);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
