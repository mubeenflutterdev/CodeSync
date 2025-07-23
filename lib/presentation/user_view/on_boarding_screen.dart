import 'package:codesync/const/app_colors.dart';
import 'package:codesync/provider/ui_provider/on_boarding_provider.dart';
import 'package:codesync/widgets/custom_curve.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    final onBoardingProvider = Provider.of<OnBoardingProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            /// Background curve at bottom
            Align(
              alignment: Alignment.bottomCenter,
              child: CurvedTopBackground(height: 550.h),
            ),

            /// Main content
            Column(
              children: [
                /// Skip Button at top-right
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: GestureDetector(
                      onTap: () {
                        print("✅ Skip button tapped");
                        onBoardingProvider.skip(context);
                      },
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),

                /// PageView
                Expanded(
                  child: PageView.builder(
                    controller: onBoardingProvider.pageControler,
                    itemCount: onBoardingProvider.pages.length,
                    onPageChanged: (index) {
                      onBoardingProvider.changePage(index);
                    },

                    itemBuilder: (context, index) {
                      final page = onBoardingProvider.pages[index];
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(page['image'].toString()),
                          SizedBox(height: 20.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 45.w),
                            child: Text(
                              page['title'].toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp,
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Text(
                              page['desc'].toString(),
                              textAlign: TextAlign.center,

                              style: TextStyle(
                                color: AppColors.whiteColor,

                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          // SizedBox(height: 30.h),

                          // SizedBox(height: 50),
                        ],
                      );
                    },
                  ),
                ),
                SmoothPageIndicator(
                  controller: onBoardingProvider.pageControler,
                  count: onBoardingProvider.pages.length,
                  effect: WormEffect(
                    activeDotColor: AppColors.whiteColor,
                    dotHeight: 12,
                    dotWidth: 12,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 100,
                    vertical: 40,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      onBoardingProvider.nextPage(context);
                    },
                    child: Container(
                      width: double.infinity,
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                      child: Center(
                        child: Text(
                          onBoardingProvider.currentIndex ==
                                  onBoardingProvider.pages.length - 1
                              ? 'Get Started'
                              : 'Next',
                          style: TextStyle(color: AppColors.backgroundColor),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
