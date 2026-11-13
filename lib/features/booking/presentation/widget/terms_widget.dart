import 'package:flutter/material.dart';
import 'package:hotelino/core/constants/constants.dart';

class TermsWidget extends StatefulWidget {
  // ignore: library_private_types_in_public_api
  static final GlobalKey<_TermsWidgetState> termsKey =
      GlobalKey<_TermsWidgetState>();
  final bool initialValue;
  final FormFieldValidator<bool>? validator;
  final FormFieldSetter<bool>? onSaved;
  TermsWidget({
    Key? key,
    required this.initialValue,
    this.validator,
    this.onSaved,
  }) : super(key: termsKey);

  @override
  State<TermsWidget> createState() => _TermsWidgetState();
}

class _TermsWidgetState extends State<TermsWidget> {
  bool isChecked = false;
  resetCkeckbBox() {
    setState(() {
      isChecked = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FormField<bool>(
      initialValue: widget.initialValue,
      onSaved: widget.onSaved,
      validator: widget.validator,
      builder: (FormFieldState<bool> field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    showTermsDialog(context);
                  },
                  child: RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyMedium
                          ?.copyWith(color: Colors.grey.shade700),
                      children: [
                        const TextSpan(text: "قوانین برنامه"),
                        TextSpan(
                          text: " هتلینو ",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const TextSpan(text: "را خوانده و می پذیرم"),
                      ],
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ),
                Checkbox(
                  side: BorderSide(
                    color: field.hasError
                        ? isChecked
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.error
                        : isChecked
                        ? Theme.of(context).colorScheme.primary
                        : AppColors.lightBorder,
                    width: 1.5,
                  ),
                  visualDensity: VisualDensity(horizontal: -4),
                  value: isChecked,
                  onChanged: (value) {
                    setState(() {
                      isChecked = value ?? false;
                    });
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  activeColor: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
            if (field.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 8, right: 12),
                child: Text(
                  field.errorText ?? '',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  void showTermsDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'قوانین برنامه هتلینو',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  SizedBox(height: 14),
                  Text(
                    "هتلینو یکی از برنامه‌های معتبر از دوره‌ی یاقوت فلاتر است که توسط پیج دانیجت و با تدریس امیرحسین محمدی طراحی و توسعه یافته است. این برنامه به شما این امکان را می‌دهد تا به راحتی هتل‌های مختلف را در کشورهای گوناگون جستجو کرده و رزرو کنید\n\n"
                    "شما قادر خواهید بود پروفایل شخصی خود را ایجاد کنید و هتل‌هایی که به نیازهای شما نزدیک‌تر هستند را پیدا کنید. توجه داشته باشید که هتل‌های رزرو شده قابل لغو نبوده و پس از انجام رزرو، تغییرات در این زمینه امکان‌پذیر نمی‌باشد\n\n"
                    "قیمت‌های هتل‌ها به صورت مقطوع اعلام شده‌اند و هیچ‌گونه تغییر قیمتی پس از رزرو نخواهید داشت. همچنین، اطلاعات هتل‌ها به دقت بررسی و به روزرسانی می‌شوند تا شما تجربه‌ای رضایت‌بخش از اقامت خود داشته باشید",
                    textAlign: TextAlign.justify,
                    textDirection: TextDirection.rtl,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
