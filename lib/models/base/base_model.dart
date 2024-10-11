// To parse this JSON data, do
//
//     final baseModel = baseModelFromJson(jsonString);

import 'dart:convert';

BaseModel baseModelFromJson(String str) => BaseModel.fromJson(json.decode(str));

String baseModelToJson(BaseModel data) => json.encode(data.toJson());

class BaseModel {
  String msg;
  int result;

  BaseModel({
    required this.msg,
    required this.result,
  });

  factory BaseModel.fromJson(Map<String, dynamic> json) => BaseModel(
        msg: json["msg"],
        result: json["result"],
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "result": result,
      };
}
