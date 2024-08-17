part of '../../di/fighter_service_locator.dart';

class FighterOutput extends Equatable {
  const FighterOutput({
    this.id = '',
    this.name = '',
    this.weight = 0,
    this.breed = '',
    this.trainer = '',
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String name;
  final int weight;
  final String breed;
  final String trainer;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  static const empty = FighterOutput();

  bool get isEmpty => this == FighterOutput.empty;

  factory FighterOutput.fromJson(Map<String, dynamic> json) {
    return FighterOutput(
      id: json.parseString('id'),
      name: json.parseString('name'),
      weight: json.parseInt('weight'),
      breed: json.parseString('breed'),
      trainer: json.parseString('trainer'),
      createdAt: json.parseDateTime('createdAt'),
      updatedAt: json.parseDateTime('updatedAt'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'weight': weight,
      'breed': breed,
      'trainer': trainer,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  @override
  List<Object?> get props => [
        id,
        name,
        weight,
        breed,
        trainer,
        createdAt,
        updatedAt,
      ];
}

enum FighterType {
  wala,
  meron;

  bool get isWala => this == FighterType.wala;
  bool get isMeron => this == FighterType.meron;
}
