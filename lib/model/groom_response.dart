import 'package:json_annotation/json_annotation.dart';

part 'groom_response.g.dart';


@JsonSerializable()
class GroomResponse extends Object {

  @JsonKey(name: 'data')
  List<Data> data;

  @JsonKey(name: 'errorCode')
  int errorCode;

  @JsonKey(name: 'errorMsg')
  String errorMsg;

  GroomResponse(this.data,this.errorCode,this.errorMsg,);

  factory GroomResponse.fromJson(Map<String, dynamic> srcJson) => _$GroomResponseFromJson(srcJson);

  Map<String, dynamic> toJson() => _$GroomResponseToJson(this);

}


@JsonSerializable()
class Data extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'link')
  String link;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'order')
  int order;

  @JsonKey(name: 'visible')
  int visible;

  Data(this.id,this.link,this.name,this.order,this.visible,);

  factory Data.fromJson(Map<String, dynamic> srcJson) => _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);

}