import 'package:equatable/equatable.dart';

class UserModel extends Equatable{
  final String address;
  final String city;
  final String accountType;
  final String userId;
  final String password;
  final String phone;
  final String name;
  final String houseNo;
  final String Parliamentary;
  final String daerah;
  final String DUN;
  final String email;

  const UserModel({
    required this.address,
    required this.city,
    required this.accountType,
    required this.userId,
    required this.password,
    required this.phone,
    required this.name,
    required this.houseNo,
    required this.Parliamentary,
    required this.daerah,
    required this.DUN,
    required this.email,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      address: map['address'] ?? "",
      city: map['city'] ?? "",
      accountType: map['accountType'] ?? "",
      userId: map['userId'] ?? "",
      password: map['password'] ?? "",
      phone: map['phone'] ?? "",
      name: map['name'] ?? "",
      houseNo: map['houseNo'] ?? "",
      Parliamentary: map['Parliamentary'] ?? "",
      daerah: map['daerah'] ?? "",
      DUN: map['DUN'] ?? "",
      email: map['email'] ?? "",
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      address: json['address'] ?? "",
      city: json['city'] ?? "",
      accountType: json['accountType'] ?? "",
      userId: json['userId'] ?? "",
      password: json['password'] ?? "",
      phone: json['phone'] ?? "",
      name: json['name'] ?? "",
      houseNo: json['houseNo'] ?? "",
      Parliamentary: json['Parliamentary'] ?? "",
      daerah: json['daerah'] ?? "",
      DUN: json['DUN'] ?? "",
      email: json['email'] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'city': city,
      'accountType': accountType,
      'userId': userId,
      'password': password,
      'phone': phone,
      'name': name,
      'houseNo': houseNo,
      'Parliamentary': Parliamentary,
      'daerah': daerah,
      'DUN': DUN,
      'email': email,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'city': city,
      'accountType': accountType,
      'userId': userId,
      'password': password,
      'phone': phone,
      'name': name,
      'houseNo': houseNo,
      'Parliamentary': Parliamentary,
      'daerah': daerah,
      'DUN': DUN,
      'email': email,
    };
  }

  @override
  String toString() => "address: $address, city: $city, accountType: $accountType, userId: $userId, password: $password, phone: $phone name: $name, houseNo: $houseNo, Parliamentary: $Parliamentary, daerah: $daerah, DUN: $DUN, email: $email";

  @override
  List<Object?> get props => [
    address,
    city,
    accountType,
    userId,
    password,
    phone,
    name,
    houseNo,
    Parliamentary,
    daerah,
    DUN,
    email,
  ];

}
