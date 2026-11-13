import 'package:flutter/material.dart';
import 'package:hotelino/features/booking/presentation/provider/booking_provider.dart';
import 'package:hotelino/features/booking/presentation/widget/booking_form_field.dart';
import 'package:hotelino/features/booking/presentation/widget/date_picker_filed.dart';
import 'package:hotelino/features/booking/presentation/widget/number_text_field.dart';
import 'package:hotelino/features/booking/presentation/widget/terms_widget.dart';
import 'package:provider/provider.dart';

class BookingPage extends StatefulWidget {
  static final GlobalKey<BookingPageState> bookingPageKey =
      GlobalKey<BookingPageState>();

  BookingPage({Key? key}) : super(key: bookingPageKey);

  @override
  State<BookingPage> createState() => BookingPageState();
}

class BookingPageState extends State<BookingPage> {
  final _formKey = GlobalKey<FormState>();

  void resetForm() {
    Future.delayed(Duration(milliseconds: 100), () {
      _formKey.currentState?.reset();
      TermsWidget.termsKey.currentState?.resetCkeckbBox();
      NumberFormField.numberFieldKey.currentState?.resetEnteredNumber();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'فرم رزرو هتل',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Consumer<BookingProvider>(
            builder: (context, bookingProvider, child) {
              return Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BookingFormField(
                      title: 'نام و نام خانوادگی',
                      hint: 'نام و نام خانوادگی خود را وارد کنید...',
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'لطفا نام خود را کامل بنویسید';
                        }

                        return null;
                      },
                      initialValue: bookingProvider.booking.fullName,
                      onSaved: (newValue) {
                        if (newValue != null) {
                          bookingProvider.setName(newValue);
                        }
                      },
                    ),
                    SizedBox(height: 8),
                    BookingFormField(
                      title: 'مقصد',
                      hint: 'مقصد خود را وارد کنید...',
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'لطفا مقصد خود را مشخص کنید';
                        }

                        return null;
                      },
                      initialValue: bookingProvider.booking.destination,
                      onSaved: (newValue) {
                        if (newValue != null) {
                          bookingProvider.setDestination(newValue);
                        }
                      },
                    ),
                    SizedBox(height: 8),
                    DatePickerField(
                      title: 'تاریخ اقامت',
                      hint: 'بازه زمانی اقامت را مشخص کنید',
                      initialValue: bookingProvider.booking.checkInOutRange,
                      validator: (value) {
                        if (value == null) {
                          return 'لطفاً بازه‌ی زمانی را انتخاب کنید';
                        }

                        return null;
                      },
                      onSaved: (newValue) {
                        if (newValue != null) {
                          bookingProvider.setRangeDate(newValue);
                        }
                      },
                    ),
                    SizedBox(height: 8),
                    BookingFormField(
                      title: 'تعداد نفرات',
                      hint: 'تعداد نفرات خود را وارد کنید...',
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'لطفا تعداد نفرات را مشخص کنید';
                        }

                        return null;
                      },
                      initialValue: bookingProvider.booking.numberOfGuests,
                      onSaved: (newValue) {
                        if (newValue != null) {
                          bookingProvider.setNumberOfGuests(newValue);
                        }
                      },
                    ),
                    SizedBox(height: 8),
                    NumberFormField(
                      initialValue: bookingProvider.booking.phoneNumber,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'لطفا شماره را به درستی وارد کنید';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        if (newValue != null) {
                          bookingProvider.setNumber(newValue);
                        }
                      },
                    ),
                    TermsWidget(
                      initialValue: false,
                      validator: (value) {
                        if (value == null || value == false) {
                          return 'لطفا قوانین برنامه را تایید کنید';
                        }
                        return null;
                      },
                      onSaved: (newValue) {},
                    ),
                    SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'درخواست رزرو با موفقیت ثبت شد! 🎉',
                                  textDirection: TextDirection.rtl,
                                ),
                              ),
                            );

                            resetForm();
                          }
                        },
                        child: Text("جستجو هتل ها"),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
