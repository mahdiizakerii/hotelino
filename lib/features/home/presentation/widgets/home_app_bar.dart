import 'package:flutter/material.dart';
import 'package:hotelino/core/theme/theme_provider.dart';
import 'package:hotelino/features/profile/provider/profile_provider.dart';
import 'package:provider/provider.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvier = Provider.of<ThemeModeProvider>(context);
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Stack(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.notifications_none, color: Colors.grey),
                  ),
                  Consumer<ProfileProvider>(
                    builder: (context, profileProvider, child) {
                      return profileProvider.profile?.notification != null &&
                              profileProvider.profile!.notification > 0
                          ? Positioned(
                              right: 12,
                              top: 12,
                              child: CircleAvatar(
                                radius: 4,
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .primary,
                              ),
                            )
                          : SizedBox();
                    },
                  ),
                ],
              ),
              IconButton(
                onPressed: () {
                  themeProvier.toggleTheme();
                },
                icon: Icon(
                  themeProvier.brightness == Brightness.light
                      ? Icons.dark_mode
                      : Icons.light_mode,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          Consumer<ProfileProvider>(
            builder: (context, profileProvider, child) {
              final avatarUrl = profileProvider.profile?.avatarUrl;
              return Row(
                children: [
                  Text(
                    profileProvider.profile?.name ?? "کاربر",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(width: 8),
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: avatarUrl == null || avatarUrl.isEmpty
                        ? null
                        : NetworkImage(avatarUrl),
                    child: avatarUrl == null || avatarUrl.isEmpty
                        ? const Icon(Icons.person_outline)
                        : null,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
