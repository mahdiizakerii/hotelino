import 'dart:js_interop';

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
    Future.delayed(
      Duration(milliseconds: 100),
      () => _formKey.currentState?.reset(),
    );
    TermsWidget.termsKey.currentState?.resetCkeckbBox();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "رزرو هتل",
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
                      hint: "نام و نام خانوادگی خود را وارد کنید...",
                      title: "نام و نام خانوادگی",
                      initialValue: bookingProvider.booking.fullName,
                      keyboardType: TextInputType.text,
                      onSaved: (newValue) {
                        if (newValue != null) {
                          bookingProvider.setName(newValue);
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "لطفا نام خود را وارد کنید";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 8),
                    BookingFormField(
                      hint: "مقصد خود را وارد کنید",
                      title: "مقصد",
                      initialValue: bookingProvider.booking.destination,
                      keyboardType: TextInputType.text,
                      onSaved: (newValue) {
                        if (newValue != null) {
                          bookingProvider.setDestination(newValue);
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return " لطفا مقصد خود را وارد کنید";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 8),
                    DatePickerField(
                      title: "تاریخ اقامت",
                      hint: "تاریخ اقامت را مشخص کنید",
                      initialValue: bookingProvider.booking.checkInOutRange,
                      validator: (value) {
                        if (value == null) {
                          return "لطفا بازه زمانی را مشخص کنید";
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
                      hint: "تعدا نفرات را وارد کنید",
                      title: "تعداد نفرات",
                      initialValue: bookingProvider.booking.numberOfGuests,
                      keyboardType: TextInputType.number,
                      onSaved: (newValue) {
                        if (newValue != null) {
                          bookingProvider.setNumberOfGuests(newValue);
                        }
                      },
                      validator: (value) {
                        if (value == null) {
                          return "تعداد نفرات خود را وارد کنید";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 8),
                    NumberFormField(
                      initialValue: bookingProvider.booking.phoneNumber,
                      validator: (value) {
                        if (value == null) {
                          return "لطفا شماره تلفن خود را وارد کنید";
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
                        if (value == null) {
                          return "لطفا قوانین را تایید کنید";
                        }
                        return null;
                      },
                      onSaved: (newValue) {},
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("درخواست شما موفقیت آمیز بود"),
                              ),
                            );
                          }
                        },
                        child: Text("جستجوی هتل"),
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
