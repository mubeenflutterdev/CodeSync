import 'package:codesync/widgets/buttons/button_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

enum DialogType { gender, phone, address }

class CustomDialogComponent {
  static Future<void> show({
    required BuildContext context,
    required DialogType type,
    required Function(String) onSubmit,
  }) async {
    // 👇 Move variables here so they persist
    String selectedGender = '';
    String selectedPhone = '';
    TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: StatefulBuilder(
          builder: (context, setState) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _getTitle(type),
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.h),

                  /// GENDER PICKER
                  if (type == DialogType.gender)
                    Theme(
                      data: Theme.of(context).copyWith(
                        canvasColor: Colors.white,
                        dropdownMenuTheme: DropdownMenuThemeData(
                          menuStyle: MenuStyle(
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                            ),
                          ),
                        ),
                      ),
                      child: DropdownButtonFormField<String>(
                        value: selectedGender.isNotEmpty
                            ? selectedGender
                            : null,
                        decoration: _inputDecoration("Select Gender"),
                        items: ['Male', 'Female'].map((String gender) {
                          return DropdownMenuItem<String>(
                            value: gender,
                            child: Text(
                              gender,
                              style: TextStyle(fontSize: 14.sp),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedGender = value!;
                          });
                        },
                      ),
                    ),

                  /// PHONE PICKER
                  if (type == DialogType.phone)
                    IntlPhoneField(
                      decoration: _inputDecoration("Phone Number"),
                      initialCountryCode: 'PK',
                      onChanged: (phone) {
                        selectedPhone = phone.completeNumber;
                      },
                      style: TextStyle(fontSize: 14),
                      dropdownIcon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                      ),
                      dropdownTextStyle: TextStyle(color: Colors.black),
                      flagsButtonPadding: EdgeInsets.only(left: 12),
                    ),

                  /// ADDRESS INPUT
                  if (type == DialogType.address)
                    TextFormField(
                      controller: controller,
                      decoration: _inputDecoration("Enter Address"),
                    ),

                  SizedBox(height: 20.h),

                  /// SAVE BUTTON
                  ButtonComponent(
                    isLoading: false,
                    text: "Save",
                    onTap: () {
                      Navigator.pop(context);

                      // Callback based on type
                      if (type == DialogType.gender) {
                        onSubmit(selectedGender);
                      } else if (type == DialogType.phone) {
                        onSubmit(selectedPhone);
                      } else {
                        onSubmit(controller.text.trim());
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  static String _getTitle(DialogType type) {
    switch (type) {
      case DialogType.gender:
        return "Select Gender";
      case DialogType.phone:
        return "Enter Phone Number";
      case DialogType.address:
        return "Enter Address";
    }
  }

  static InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      hintText: hint,
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50.r),
        borderSide: BorderSide.none,
      ),
    );
  }
}
