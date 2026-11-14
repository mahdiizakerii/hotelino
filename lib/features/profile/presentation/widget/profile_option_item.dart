import 'package:flutter/material.dart';

class ProfileOptionItem extends StatelessWidget {
  final String title;
  final Widget icon;
  final VoidCallback onTap;
  const ProfileOptionItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8, bottom: 8, left: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          child: Row(
            children: [
              Icon(Icons.arrow_back_ios_new_rounded),
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
              SizedBox(width: 12),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xFFF4EAE2),
                  ),
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: Center(child: icon),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
