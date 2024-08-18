part of '../../di/user_service_locator.dart';

class PosOutput extends Equatable {
  const PosOutput({
    this.id = '',
    this.posNumber = '',
    this.isBlocked = false,
    this.createdAt,
    this.updatedAt,
    this.user = UserOutput.empty,
  });

  final String id;
  final String posNumber;
  final bool isBlocked;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final UserOutput user;

  static const PosOutput empty = PosOutput(
    id: '',
    posNumber: '',
    isBlocked: false,
    user: UserOutput.empty,
  );

  factory PosOutput.fromJson(Map<String, dynamic> json) {
    return PosOutput(
      id: json.parseString('id'),
      posNumber: json.parseString('posNumber'),
      isBlocked: json.parseBool('isBlocked'),
      createdAt: json.parseDateTime('createdAt'),
      updatedAt: json.parseDateTime('updatedAt'),
      user: UserOutput.fromJson(json['user'] as Map<String, dynamic>? ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'posNumber': posNumber,
      'isBlocked': isBlocked,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'user': user.toJson(),
    };
  }

  PosOutput copyWith({
    String? id,
    String? posNumber,
    bool? isBlocked,
    DateTime? createdAt,
    DateTime? updatedAt,
    UserOutput? user,
  }) {
    return PosOutput(
      id: id ?? this.id,
      posNumber: posNumber ?? this.posNumber,
      isBlocked: isBlocked ?? this.isBlocked,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      user: user ?? this.user,
    );
  }

  bool get isNotEmpty => this != PosOutput.empty;
  bool get isEmpty => !isNotEmpty;

  @override
  List<Object?> get props => [
        id,
        posNumber,
        isBlocked,
        createdAt,
        updatedAt,
        user,
      ];
}
