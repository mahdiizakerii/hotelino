import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hotelino/core/constants/constants.dart';
import 'package:hotelino/features/profile/presentation/widget/profile_option_item.dart';
import 'package:hotelino/features/profile/provider/profile_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _image = File(picked.path);
      });
    }
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, textDirection: TextDirection.rtl),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        duration: Duration(seconds: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, profileProvider, child) {
        final profile = profileProvider.profile;
        if (profile == null) {
          return Center(child: CircularProgressIndicator());
        }
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    SizedBox(height: 24),
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 55,
                          backgroundImage: _image != null
                              ? FileImage(_image!)
                              : NetworkImage(profile.avatarUrl),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: GestureDetector(
                            onTap: _pickImage,
                            child: Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryFixed,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Text(
                      profile.name,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    SizedBox(height: 12),
                    Text(
                      profile.email,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(color: Colors.grey),
                    ),
                    SizedBox(height: 24),
                    ProfileOptionItem(
                      title: "اطلاعات صفحه کاربری",
                      icon: SvgPicture.asset(
                        "assets/icon/profile.svg",
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.primary,
                          BlendMode.srcIn,
                        ),
                      ),
                      onTap: () => showSnackBar(context, "اطلاعات صفحه کاربری"),
                    ),
                    ProfileOptionItem(
                      title: "اعلان ها",
                      icon: SvgPicture.asset(
                        "assets/icon/notification.svg",
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.primary,
                          BlendMode.srcIn,
                        ),
                      ),
                      onTap: () => showSnackBar(context, "نمایش اعلان ها"),
                    ),
                    ProfileOptionItem(
                      title: "لیست مورد علاقه ها",
                      icon: SvgPicture.asset(
                        "assets/icon/favorite.svg",
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.primary,
                          BlendMode.srcIn,
                        ),
                      ),
                      onTap: () =>
                          showSnackBar(context, "نمایش لیست مورد علاقه ها"),
                    ),
                    ProfileOptionItem(
                      title: "روش های پرداخت",
                      icon: SvgPicture.asset(
                        "assets/icon/payment.svg",
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.primary,
                          BlendMode.srcIn,
                        ),
                      ),
                      onTap: () => showSnackBar(context, "نمایش روش پرداخت"),
                    ),
                    ProfileOptionItem(
                      title: "تنظیمات",
                      icon: SvgPicture.asset(
                        "assets/icon/setting.svg",
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.primary,
                          BlendMode.srcIn,
                        ),
                      ),
                      onTap: () => showSnackBar(context, "نمایش تنظیمات"),
                    ),
                    ProfileOptionItem(
                      title: "تغییر رمز عبور",
                      icon: SvgPicture.asset(
                        "assets/icon/password.svg",
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.primary,
                          BlendMode.srcIn,
                        ),
                      ),
                      onTap: () => showSnackBar(context, "تغییر رمز عبور"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
