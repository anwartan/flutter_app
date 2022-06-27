import 'package:core/domain/entities/auth.dart';
import 'package:equatable/equatable.dart';

class AuthModel extends Equatable{

  const AuthModel({
    required this.email,
    required this.accessTime
  });
  final String email;
  final DateTime accessTime;

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(email: json["email"],accessTime:DateTime.fromMillisecondsSinceEpoch(json['access_time']));
  Map<String, dynamic> toJson() => {

    "email": email,
    "access_time": accessTime.millisecondsSinceEpoch,

  };
  factory AuthModel.fromEntity(Auth auth) => AuthModel(
      email:auth.email,accessTime: auth.accessTime);
  
  Auth toEntity(){
    return Auth(email: email, accessTime: accessTime);
  }


  @override
  List<Object?> get props => [];

}