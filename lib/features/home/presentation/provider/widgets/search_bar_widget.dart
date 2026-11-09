import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.tune, color: theme.colorScheme.outline),
            ),
            SizedBox(
              height: 24,
              child: VerticalDivider(
                thickness: 1.5,
                color: theme.colorScheme.outline,
                width: 1,
              ),
            ),
            Expanded(
              child: TextField(
                textDirection: TextDirection.rtl,
                decoration: InputDecoration(
                  filled: false,
                  hintText: "جستجو",
                  hintTextDirection: TextDirection.rtl,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 4,
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search, color: theme.colorScheme.outline),
            ),
          ],
        ),
      ),
    );
  }
}
