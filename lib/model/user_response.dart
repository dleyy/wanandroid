import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';


@JsonSerializable()
class UserResponse extends Object {

  @JsonKey(name: 'data')
  Data data;

  @JsonKey(name: 'errorCode')
  int errorCode;

  @JsonKey(name: 'errorMsg')
  String errorMsg;

  UserResponse(this.data, this.errorCode, this.errorMsg,);

  factory UserResponse.fromJson(Map<String, dynamic> srcJson) =>
      _$UserResponseFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);

}


@JsonSerializable()
class Data extends Object {

  @JsonKey(name: 'chapterTops')
  List<dynamic> chapterTops;

  @JsonKey(name: 'collectIds')
  List<dynamic> collectIds;

  @JsonKey(name: 'email')
  String email;

  @JsonKey(name: 'icon')
  String icon;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'password')
  String password;

  @JsonKey(name: 'token')
  String token;

  @JsonKey(name: 'type')
  int type;

  @JsonKey(name: 'username')
  String username;

  Data(this.chapterTops, this.collectIds, this.email, this.icon, this.id,
      this.password, this.token, this.type, this.username,);

  factory Data.fromJson(Map<String, dynamic> srcJson) =>
      _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);

}


