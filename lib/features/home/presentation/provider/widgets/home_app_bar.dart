import 'package:flutter/material.dart';
import 'package:hotelino/core/constants/constants.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
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
                ],
              ),
            ],
          ),
          Row(
            children: [
              Text('کاربر', style: Theme.of(context).textTheme.titleMedium),
              SizedBox(width: 8),
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(AppConstants.avatarProfile),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
