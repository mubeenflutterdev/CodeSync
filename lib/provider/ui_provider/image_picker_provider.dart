// ignore_for_file: use_build_context_synchronously, no_leading_underscores_for_local_identifiers

import 'dart:io';

import 'package:codesync/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerProvider with ChangeNotifier {
  File? selectedImage;

  void pickerFromGallery(BuildContext context) async {
    try {
      final returnedImage = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );

      if (returnedImage != null) {
        selectedImage = File(returnedImage.path);

        notifyListeners();
      }
    } catch (_e) {
      ToastUtil.showToast(
        context,
        message: _e.toString(),
        type: ToastType.error,
      );
    }
  }

  void pickerFromCamera(BuildContext context) async {
    try {
      final returnedImage = await ImagePicker().pickImage(
        source: ImageSource.camera,
      );

      if (returnedImage != null) {
        selectedImage = File(returnedImage.path);
        notifyListeners();
      }
    } catch (_e) {
      ToastUtil.showToast(
        context,
        message: _e.toString(),
        type: ToastType.error,
      );
    }
  }
}
