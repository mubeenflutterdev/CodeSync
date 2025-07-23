class ApiModel {
  final String id;
  final String name;
  final String avatar;
  final DateTime createdAt;

  ApiModel({
    required this.id,
    required this.name,
    required this.avatar,
    required this.createdAt,
  });

  factory ApiModel.fromJson(Map<String, dynamic> json) {
    return ApiModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      avatar: json['avatar'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'avatar': avatar,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
