import 'package:equatable/equatable.dart';

class CompostModel extends Equatable {
  final String co2e;
  final String cumulativeCo2e;
  final String cumulativeGreenPoints;
  final String date;
  final String greenpoints;
  final double totalWeight;
  final String userId;
  final double weight;

  const CompostModel({
   required this.co2e,
   required this.cumulativeCo2e,
   required this.cumulativeGreenPoints,
   required this.date,
   required this.greenpoints,
   required this.totalWeight,
   required this.userId,
   required this.weight,
  });

  factory CompostModel.fromMap(Map<String, dynamic> map) {
    return CompostModel(
        co2e: map['co2e'] ?? "",
        cumulativeCo2e: map['cumulativeCo2e'] ?? "",
        cumulativeGreenPoints: map['cumulativeGreenPoints'] ?? "",
        date: map['date'] ?? "",
        greenpoints: map['greenpoints'] ?? "",
        // Please fix the attribute name so its not separated 'total weight' -> 'totalWeight'/'total_weight' etc
        totalWeight: map['total weight'] ?? "",
        userId: map['userId'] ?? "",
        weight: map['weight'] ?? "",
    );
  }

  factory CompostModel.fromJson(Map<String, dynamic> json) {
    return CompostModel(
      co2e: json['co2e'] ?? "",
      cumulativeCo2e: json['cumulativeCo2e'] ?? "",
      cumulativeGreenPoints: json['cumulativeGreenPoints'] ?? "",
      date: json['date'] ?? "",
      greenpoints: json['greenpoints'] ?? "",
      // Please fix the attribute name so its not separated 'total weight' -> 'totalWeight'/'total_weight' etc
      totalWeight: json['total weight'] ?? "",
      userId: json['userId'] ?? "",
      weight: json['weight'] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'co2e': co2e,
      'cumulativeCo2e': cumulativeCo2e,
      'cumulativeGreenPoints': cumulativeGreenPoints,
      'date': date,
      'greenpoints': greenpoints,
      // Please fix the attribute name so its not separated 'total weight' -> 'totalWeight'/'total_weight' etc
      'total weight': totalWeight,
      'userId': userId,
      'weight': weight,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'co2e': co2e,
      'cumulativeCo2e': cumulativeCo2e,
      'cumulativeGreenPoints': cumulativeGreenPoints,
      'date': date,
      'greenpoints': greenpoints,
      // Please fix the attribute name so its not separated 'total weight' -> 'totalWeight'/'total_weight' etc
      'total weight': totalWeight,
      'userId': userId,
      'weight': weight,
    };
  }

  @override
  String toString() => "co2e: $co2e, cumulativeCo2e: $cumulativeCo2e, cumulativeGreenPoints: $cumulativeGreenPoints, date: $date, greenpoints: $greenpoints, total weight: $totalWeight, userId: $userId, weight: $weight";

  @override
  List<Object?> get props => [
    co2e,
    cumulativeCo2e,
    cumulativeGreenPoints,
    date,
    greenpoints,
    totalWeight,
    userId,
    weight,
  ];
}