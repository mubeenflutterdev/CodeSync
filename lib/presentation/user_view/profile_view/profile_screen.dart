// ignore_for_file: unnecessary_string_interpolations

import 'package:codesync/const/app_colors.dart';
import 'package:codesync/const/app_images.dart';
import 'package:codesync/provider/feature_provider/auth_provider.dart';
import 'package:codesync/provider/feature_provider/user_info_provider.dart';
import 'package:codesync/widgets/buttons/button_component.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    UserInfoProivder userInfoProivder = Provider.of<UserInfoProivder>(
      context,
      listen: false,
    );
    userInfoProivder.getUserInfo(context);
  }

  @override
  Widget build(BuildContext context) {
    AuthentactionProvider authentactionProvider =
        Provider.of<AuthentactionProvider>(context);
    UserInfoProivder profileProvider = Provider.of<UserInfoProivder>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// profile 1st container
            ProfileImageSectionComponent(),
            //// text button
            Padding(
              padding: EdgeInsets.only(left: 24.w, top: 20.h, bottom: 10.h),
              child: Text(
                'USer Details',
                style: TextStyle(
                  color: AppColors.backgroundColor,
                  fontSize: 16.sp,
                ),
              ),
            ),

            /// details secction
            DetailsComponent(),
            SizedBox(height: 50),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Consumer<AuthentactionProvider>(
                builder: (context, proivder, child) {
                  return ButtonComponent(
                    text: 'Logout',
                    onTap: () {
                      proivder.signOut(context);
                    },
                    isLogoutButton: true,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// profile image section
class ProfileImageSectionComponent extends StatelessWidget {
  const ProfileImageSectionComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 268.h,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: AlignmentDirectional.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.lightBackgroundColor, AppColors.backgroundColor],
        ),

        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(35.r),
          bottomRight: Radius.circular(35.r),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40.r,
            backgroundImage: AssetImage(AppImages.changePasswordImage),
          ),
          SizedBox(height: 20.h),
          Text('Mubeen', style: TextStyle(color: AppColors.white)),
        ],
      ),
    );
  }
}

/// details section
class DetailsComponent extends StatelessWidget {
  const DetailsComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserInfoProivder>(
      builder: (context, provider, child) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.grey.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Column(
              children: [
                /// first tile
                Padding(
                  padding: EdgeInsets.only(left: 10.w, top: 15.h),
                  child: Row(
                    children: [
                      Text(
                        'Name',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 100.w),
                        child: Text('Mubeen'),
                      ),
                    ],
                  ),
                ),

                Divider(),

                /// 2nd tile
                Padding(
                  padding: EdgeInsets.only(left: 10.w, top: 5.h),
                  child: Row(
                    children: [
                      Text(
                        'Email',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 100.w),
                        child: Text(
                          '${'Khuzaima@gmail.com'.substring(0, 10)},,,', // Khuza...
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                ),
                //
                Divider(),

                /// 3rd tile
                Padding(
                  padding: EdgeInsets.only(left: 10.w, top: 5.h, bottom: 5.h),
                  child: Row(
                    children: [
                      Text(
                        'Gender',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 86.w),
                        child: provider.gender == ''
                            ? Container(
                                decoration: BoxDecoration(
                                  color: AppColors.backgroundColor.withValues(
                                    alpha: 0.1,
                                  ),
                                  borderRadius: BorderRadius.circular(4.r),
                                  border: BoxBorder.all(
                                    color: AppColors.lightBackgroundColor,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 4.w,
                                    vertical: 4.h,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      CustomDialogComponent.show(
                                        context: context,
                                        type: DialogType.gender,
                                        onSubmit: (value) {
                                          provider.changeGender(value);
                                        },
                                      );
                                    },
                                    child: Icon(
                                      size: 10.r,
                                      Icons.edit,
                                      color: AppColors.lightBackgroundColor,
                                    ),
                                  ),
                                ),
                              )
                            : Row(
                                children: [
                                  Text(provider.gender),
                                  SizedBox(width: 103.5.w),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.backgroundColor
                                          .withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(4.r),
                                      border: BoxBorder.all(
                                        color: AppColors.lightBackgroundColor,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 4.w,
                                        vertical: 4.h,
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          CustomDialogComponent.show(
                                            context: context,
                                            type: DialogType.gender,
                                            onSubmit: (value) {
                                              provider.changeGender(value);
                                            },
                                          );
                                        },
                                        child: Icon(
                                          size: 10.r,
                                          Icons.edit,
                                          color: AppColors.lightBackgroundColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ],
                  ),
                ),

                //
                Divider(),

                /// 4th tile
                Padding(
                  padding: EdgeInsets.only(left: 10.w, top: 5.h, bottom: 5.h),
                  child: Row(
                    children: [
                      Text(
                        'Phone Number',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 82.w),
                        child: provider.phoneNumber == ''
                            ? GestureDetector(
                                onTap: () {
                                  CustomDialogComponent.show(
                                    context: context,
                                    type: DialogType.phone,
                                    onSubmit: (value) {
                                      provider.chnageNumber(value);
                                    },
                                  );
                                  // provider.chnageNumber();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.backgroundColor.withValues(
                                      alpha: 0.1,
                                    ),
                                    borderRadius: BorderRadius.circular(4.r),
                                    border: BoxBorder.all(
                                      color: AppColors.lightBackgroundColor,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 4.w,
                                      vertical: 4.h,
                                    ),
                                    child: Icon(
                                      size: 10.r,
                                      Icons.edit,
                                      color: AppColors.lightBackgroundColor,
                                    ),
                                  ),
                                ),
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '0${'${provider.phoneNumber.substring(3, 6)}'},,',
                                  ),
                                  SizedBox(width: 10.w),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.backgroundColor
                                          .withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(4.r),
                                      border: BoxBorder.all(
                                        color: AppColors.lightBackgroundColor,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 4.w,
                                        vertical: 4.h,
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          CustomDialogComponent.show(
                                            context: context,
                                            type: DialogType.phone,
                                            onSubmit: (value) {
                                              provider.chnageNumber(value);
                                            },
                                          );
                                        },
                                        child: Icon(
                                          size: 10.r,
                                          Icons.edit,
                                          color: AppColors.lightBackgroundColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ],
                  ),
                ),

                //
                Divider(),

                /// 5th tile
                Padding(
                  padding: EdgeInsets.only(left: 10.w, top: 5.h, bottom: 5.h),
                  child: Row(
                    children: [
                      Text(
                        'Adress',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 115.w),
                        child: provider.adress == ''
                            ? Container(
                                decoration: BoxDecoration(
                                  color: AppColors.backgroundColor.withValues(
                                    alpha: 0.1,
                                  ),
                                  borderRadius: BorderRadius.circular(4.r),
                                  border: BoxBorder.all(
                                    color: AppColors.lightBackgroundColor,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 2.w,
                                    vertical: 2.h,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      CustomDialogComponent.show(
                                        context: context,
                                        type: DialogType.address,
                                        onSubmit: (value) {
                                          provider.changeAdress(value);
                                        },
                                      );
                                      // provider.changeAdress();
                                    },
                                    child: Icon(
                                      size: 10.r,
                                      Icons.edit,
                                      color: AppColors.lightBackgroundColor,
                                    ),
                                  ),
                                ),
                              )
                            : Row(
                                children: [
                                  Text(provider.adress),
                                  SizedBox(width: 70.w),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.backgroundColor
                                          .withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(4.r),
                                      border: BoxBorder.all(
                                        color: AppColors.lightBackgroundColor,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 2.w,
                                        vertical: 2.h,
                                      ),
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: Icon(
                                          size: 10.r,
                                          Icons.edit,
                                          color: AppColors.lightBackgroundColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        );
      },
    );
  }
}

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
