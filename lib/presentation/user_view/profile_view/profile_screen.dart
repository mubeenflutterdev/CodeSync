// ignore_for_file: unnecessary_string_interpolations, use_build_context_synchronously

import 'package:auto_size_text/auto_size_text.dart';
import 'package:codesync/const/app_colors.dart';
import 'package:codesync/const/app_images.dart';
import 'package:codesync/provider/feature_provider/auth_provider.dart';
import 'package:codesync/provider/feature_provider/user_info_provider.dart';
import 'package:codesync/routes/route_names.dart';
import 'package:codesync/widgets/buttons/button_component.dart';
import 'package:codesync/widgets/shimmer/profile_screen_shimmer.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    Future.microtask(() {
      UserInfoProivder userInfoProivder = Provider.of<UserInfoProivder>(
        context,
        listen: false,
      );
      userInfoProivder.getUserInfo(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthentactionProvider authentactionProvider =
        Provider.of<AuthentactionProvider>(context);
    UserInfoProivder userInfoProivder = Provider.of<UserInfoProivder>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: userInfoProivder.isLoading == true
            ? ProfileSccreenShimmer()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// profile 1st container
                  ProfileImageSectionComponent(),
                  //// text button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: 24.w,
                          top: 20.h,
                          bottom: 10.h,
                        ),
                        child: Text(
                          'User Details',
                          style: TextStyle(
                            color: AppColors.backgroundColor,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 20.h,
                          bottom: 10.h,
                          right: 30.w,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRouteName.profileDetailsScreen,
                            );
                          },
                          child: const Icon(
                            Icons.edit,
                            color: AppColors.backgroundColor,
                          ),
                        ),
                      ),
                    ],
                  ),

                  /// details secction
                  DetailsComponent(),
                  SizedBox(height: 50),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Consumer<AuthentactionProvider>(
                      builder: (context, proivder, child) {
                        return ButtonComponent(
                          isLoading: false,
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
    UserInfoProivder userInfoProivder = Provider.of<UserInfoProivder>(context);

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
          Consumer<UserInfoProivder>(
            builder: (context, provider, child) {
              return Stack(
                children: [
                  CircleAvatar(
                    radius: 50.r,
                    backgroundImage:
                        provider.userInfo?.profileImage != null &&
                            provider.userInfo!.profileImage!.isNotEmpty
                        ? NetworkImage(provider.userInfo!.profileImage!)
                        : AssetImage(AppImages.onBoardingImages1),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        provider.uploadUserProfileImage(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.r),
                          color: AppColors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(3.r),
                          child: Icon(Icons.edit, color: AppColors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          SizedBox(height: 20.h),
          Text(
            userInfoProivder.userInfo == null
                ? 'Hello'
                : 'Hello ${userInfoProivder.userInfo!.fullName}',
            style: TextStyle(color: AppColors.white),
          ),
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
        final userInfo = provider.userInfo;

        if (userInfo == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppColors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Table(
              columnWidths: {
                0: IntrinsicColumnWidth(), // Label column (auto)
                1: FlexColumnWidth(), // Data column (fills space)
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                _buildRow('Name', userInfo.fullName),
                _dividerRow(),
                _buildRow('Email', userInfo.email),
                _dividerRow(),
                _buildRow('Gender', provider.userInfo!.gender.toString()),
                _dividerRow(),
                _buildRow('Phone', provider.userInfo!.phone.toString()),
                _dividerRow(),
                _buildRow('Address', provider.userInfo!.address.toString()),
              ],
            ),
          ),
        );
      },
    );
  }

  TableRow _buildRow(String title, String value) {
    return TableRow(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Text(
            '$title:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
          ),
        ),
        Padding(
          // 👇 YOU CAN INCREASE THIS TO ADD MORE SPACE BETWEEN TITLE & VALUE
          padding: EdgeInsets.only(left: 60.w, top: 10.h, bottom: 10.h),
          child: AutoSizeText(
            _getTruncatedText(value),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 14.sp),
          ),
        ),
      ],
    );
  }

  TableRow _dividerRow() {
    return TableRow(
      children: [
        SizedBox(height: 1.h, child: Divider()),
        SizedBox(height: 1.h, child: Divider()),
      ],
    );
  }

  String _getTruncatedText(String text, {int maxLength = 35}) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }
}
