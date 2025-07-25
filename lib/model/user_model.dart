import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String fullName;
  final String email;
  final String? phone;
  final String? gender;
  final String? address;
  final String? profileImage;
  final String role;
  final DateTime createdAt;

  // 🔰 Team Info
  final String? teamId;
  final String? teamName;
  final bool? isCaptain;

  // ⚾ Batting Stats
  final int? runs;
  final int? ballsFaced;
  final int? fours;
  final int? sixes;
  final int? highestScore;
  final double? battingAverage;
  final double? strikeRate;

  // 🏏 Bowling Stats
  final int? wickets;
  final int? ballsBowled;
  final int? runsConceded;
  final int? maidens;
  final double? bowlingAverage;
  final double? economyRate;
  final String? bestBowlingFigure;

  // 🧤 Fielding Stats
  final int? catches;
  final int? runOuts;
  final int? stumpings;

  UserModel({
    required this.uid,
    required this.fullName,
    required this.email,
    this.phone,
    this.gender,
    this.address,
    this.profileImage,
    required this.role,
    required this.createdAt,
    this.teamId,
    this.teamName,
    this.isCaptain,
    this.runs,
    this.ballsFaced,
    this.fours,
    this.sixes,
    this.highestScore,
    this.battingAverage,
    this.strikeRate,
    this.wickets,
    this.ballsBowled,
    this.runsConceded,
    this.maidens,
    this.bowlingAverage,
    this.economyRate,
    this.bestBowlingFigure,
    this.catches,
    this.runOuts,
    this.stumpings,
  });

  factory UserModel.fromFireStore(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      fullName: map['fullName'],
      email: map['email'],
      phone: map['phone'],
      gender: map['gender'],
      address: map['address'],
      profileImage: map['profileImage'],
      role: map['role'] ?? 'visitor',
      createdAt: (map['createdAt'] as Timestamp).toDate(),

      // Team Info
      teamId: map['teamId'],
      teamName: map['teamName'],
      isCaptain: map['isCaptain'] ?? false,

      // Batting
      runs: map['runs'],
      ballsFaced: map['ballsFaced'],
      fours: map['fours'],
      sixes: map['sixes'],
      highestScore: map['highestScore'],
      battingAverage: (map['battingAverage'] as num?)?.toDouble(),
      strikeRate: (map['strikeRate'] as num?)?.toDouble(),

      // Bowling
      wickets: map['wickets'],
      ballsBowled: map['ballsBowled'],
      runsConceded: map['runsConceded'],
      maidens: map['maidens'],
      bowlingAverage: (map['bowlingAverage'] as num?)?.toDouble(),
      economyRate: (map['economyRate'] as num?)?.toDouble(),
      bestBowlingFigure: map['bestBowlingFigure'],

      // Fielding
      catches: map['catches'],
      runOuts: map['runOuts'],
      stumpings: map['stumpings'],
    );
  }

  Map<String, dynamic> toFireStore() {
    return {
      'uid': uid,
      'fullName': fullName,
      'email': email,
      'phone': phone ?? '',
      'gender': gender ?? '',
      'address': address ?? '',
      'profileImage': profileImage ?? '',
      'role': role,
      'createdAt': createdAt,

      // Team Info
      'teamId': teamId ?? '',
      'teamName': teamName ?? '',
      'isCaptain': isCaptain ?? false,

      // Batting
      'runs': runs ?? 0,
      'ballsFaced': ballsFaced ?? 0,
      'fours': fours ?? 0,
      'sixes': sixes ?? 0,
      'highestScore': highestScore ?? 0,
      'battingAverage': battingAverage ?? 0.0,
      'strikeRate': strikeRate ?? 0.0,

      // Bowling
      'wickets': wickets ?? 0,
      'ballsBowled': ballsBowled ?? 0,
      'runsConceded': runsConceded ?? 0,
      'maidens': maidens ?? 0,
      'bowlingAverage': bowlingAverage ?? 0.0,
      'economyRate': economyRate ?? 0.0,
      'bestBowlingFigure': bestBowlingFigure ?? '0/0',

      // Fielding
      'catches': catches ?? 0,
      'runOuts': runOuts ?? 0,
      'stumpings': stumpings ?? 0,
    };
  }
}
