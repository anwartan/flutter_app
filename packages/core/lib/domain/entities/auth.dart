import 'package:equatable/equatable.dart';

class Auth extends Equatable {
  const Auth({
    required this.email,
    required this.accessTime,
  });

  final String email;
  final DateTime accessTime;
  factory Auth.fromJson(Map<String, dynamic> json) => Auth(email: json["email"],accessTime:json["accessTime"]);

  @override
  List<Object?> get props => [email,accessTime];

}
