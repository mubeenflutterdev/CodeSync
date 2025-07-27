import 'package:codesync/provider/feature_provider/user_info_provider.dart';
import 'package:codesync/utils/dialog/profile_information_change_dialog.dart';
import 'package:codesync/widgets/shimmer/profile_details_screen_shimmer.dart';
import 'package:codesync/widgets/shimmer/shimmer_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProfileDetailsScreen extends StatefulWidget {
  const ProfileDetailsScreen({super.key});

  @override
  State<ProfileDetailsScreen> createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<ProfileDetailsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<UserInfoProivder>(
        context,
        listen: false,
      ).getUserInfo(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    UserInfoProivder userInfoProivder = Provider.of<UserInfoProivder>(context);
    return Scaffold(
      // appBar: AppBar(title: const Text("👤 Profile Details")),
      body: userInfoProivder.isLoading == true
          ? ProfileDetailsSccreenShimmer()
          : Expanded(
              child: Consumer<UserInfoProivder>(
                builder: (context, provider, _) {
                  final user = provider.userInfo;

                  if (provider.isLoading) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 50.w,
                          vertical: 50.h,
                        ),
                        child: ShimmerBox(
                          height: double.infinity,
                          width: double.infinity,
                        ),
                      ),
                    );
                  }

                  if (user == null) {
                    return const Center(child: Text("No user data found."));
                  }

                  return Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        _buildSection(
                          icon: Icons.person,
                          title: "Personal Info",
                          children: [
                            _buildTile(
                              "Full Name",
                              user.fullName,
                              onEdit: () {
                                CustomDialogComponent.show(
                                  context: context,
                                  type: DialogType.address,
                                  onSubmit: (newName) {
                                    provider.changeName(context, newName);
                                  },
                                );
                              },
                            ),
                            _buildTile("Email", user.email),
                            _buildTile(
                              "Phone",
                              user.phone ?? "Not provided",
                              onEdit: () {
                                CustomDialogComponent.show(
                                  context: context,
                                  type: DialogType.phone,
                                  onSubmit: (newNumber) {
                                    provider.chnageNumber(newNumber, context);
                                  },
                                );
                              },
                            ),
                            _buildTile(
                              "Gender",
                              user.gender ?? "Not provided",
                              onEdit: () {
                                CustomDialogComponent.show(
                                  context: context,
                                  type: DialogType.gender,
                                  onSubmit: (newGender) {
                                    print(
                                      '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@',
                                    );
                                    print(newGender);
                                    provider.changeGender(newGender, context);
                                  },
                                );
                              },
                            ),
                            _buildTile(
                              "Address",
                              user.address ?? "Not provided",
                              onEdit: () {
                                CustomDialogComponent.show(
                                  context: context,
                                  type: DialogType.address,
                                  onSubmit: (newAdress) {
                                    provider.changeAdress(newAdress, context);
                                  },
                                );
                              },
                            ),
                            _buildTile("Role", user.role, onEdit: () {}),
                            _buildTile("Created At", user.createdAt.toString()),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildSection(
                          icon: Icons.group,
                          title: "🏏 Team Info",
                          children: [
                            _buildTile(
                              "Team Name",
                              user.teamName ?? "Not assigned",
                            ),
                            _buildTile("Team ID", user.teamId ?? "-"),
                            _buildTile(
                              "Captain",
                              user.isCaptain == true ? "Yes" : "No",
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildSection(
                          icon: Icons.sports_cricket,
                          title: "⚾ Batting Stats",
                          children: [
                            _buildTile("Runs", user.runs.toString()),
                            _buildTile(
                              "Balls Faced",
                              user.ballsFaced.toString(),
                            ),
                            _buildTile("Fours", user.fours.toString()),
                            _buildTile("Sixes", user.sixes.toString()),
                            _buildTile(
                              "Highest Score",
                              user.highestScore.toString(),
                            ),
                            _buildTile(
                              "Batting Avg",
                              user.battingAverage?.toStringAsFixed(2) ?? "0.00",
                            ),
                            _buildTile(
                              "Strike Rate",
                              user.strikeRate?.toStringAsFixed(2) ?? "0.00",
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildSection(
                          icon: Icons.sports_baseball,
                          title: "🏏 Bowling Stats",
                          children: [
                            _buildTile("Wickets", user.wickets.toString()),
                            _buildTile(
                              "Balls Bowled",
                              user.ballsBowled.toString(),
                            ),
                            _buildTile(
                              "Runs Conceded",
                              user.runsConceded.toString(),
                            ),
                            _buildTile("Maidens", user.maidens.toString()),
                            _buildTile(
                              "Bowling Avg",
                              user.bowlingAverage?.toStringAsFixed(2) ?? "0.00",
                            ),
                            _buildTile(
                              "Economy Rate",
                              user.economyRate?.toStringAsFixed(2) ?? "0.00",
                            ),
                            _buildTile(
                              "Best Figure",
                              user.bestBowlingFigure ?? "0/0",
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildSection(
                          icon: Icons.sports_handball,
                          title: "🧤 Fielding Stats",
                          children: [
                            _buildTile("Catches", user.catches.toString()),
                            _buildTile("Run Outs", user.runOuts.toString()),
                            _buildTile("Stumpings", user.stumpings.toString()),
                          ],
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }

  Widget _buildTile(String title, String value, {VoidCallback? onEdit}) {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(
        value,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(color: Colors.grey),
      ),
      // show edit icon only if onEdit is given
      trailing: onEdit != null
          ? IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue, size: 18),
              onPressed: onEdit,
            )
          : null,
    );
  }

  Widget _buildSection({
    required IconData icon,
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.blue, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...children,
        ],
      ),
    );
  }
}
