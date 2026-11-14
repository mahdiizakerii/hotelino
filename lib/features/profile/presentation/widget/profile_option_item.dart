import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileOptionItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  const ProfileOptionItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [SvgPicture()]);
  }
}
