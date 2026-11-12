import 'package:flutter/material.dart';

void unfucosEditor(BuildContext context) {
  FocusManager.instance.primaryFocus?.unfocus();
  FocusScope.of(context).unfocus();
}
