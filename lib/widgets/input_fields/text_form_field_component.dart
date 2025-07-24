// field_type_enum.dart (optional file for neatness)
import 'package:codesync/const/app_colors.dart';
import 'package:codesync/provider/ui_provider/password_hide_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

enum FieldType { normal, password, confirmPassword }
// text_form_field_component.dart


class TextFormFieldComponent extends StatelessWidget {
  final String hintText;
  final IconData prefixIcon;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final FieldType fieldType;

  TextFormFieldComponent({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    required this.validator,
    required this.controller,
    this.fieldType = FieldType.normal,
  });

  @override
  Widget build(BuildContext context) {
    final passwordProvider = Provider.of<PasswordHideProvider>(context);
    final theme = Theme.of(context);

    bool shouldObscure = fieldType == FieldType.password
        ? passwordProvider.isPasswordHidden
        : fieldType == FieldType.confirmPassword
            ? passwordProvider.isConfirmPasswordHidden
            : false;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: TextFormField(
        obscureText: shouldObscure,
        controller: controller,
        validator: validator,
        keyboardType: hintText.toLowerCase().contains("email")
            ? TextInputType.emailAddress
            : TextInputType.text,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: theme.textTheme.labelSmall,
          filled: true,
          fillColor: Colors.white,
          isDense: true,
          prefixIcon: Icon(prefixIcon, color: AppColors.backgroundColor),
          suffixIcon: (fieldType == FieldType.password ||
                  fieldType == FieldType.confirmPassword)
              ? GestureDetector(
                  onTap: () {
                    if (fieldType == FieldType.password) {
                      passwordProvider.togglePasswordVisibility();
                    } else if (fieldType == FieldType.confirmPassword) {
                      passwordProvider.toggleConfirmPasswordVisibility();
                    }
                  },
                  child: Icon(
                    shouldObscure ? Icons.visibility_off : Icons.visibility,
                  ),
                )
              : null,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.r),
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 240, 238, 238)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.r),
            borderSide:
                BorderSide(color: AppColors.backgroundColor, width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.r),
            borderSide: const BorderSide(color: Colors.red, width: 1.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.r),
            borderSide: const BorderSide(color: Colors.red, width: 1.5),
          ),
        ),
      ),
    );
  }
}
