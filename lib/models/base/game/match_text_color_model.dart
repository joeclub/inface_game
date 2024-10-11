// To parse this JSON data, do
//
//     final matchTextColorModel = matchTextColorModelFromJson(jsonString);

import 'dart:convert';

List<MatchTextColorModel> matchTextColorModelFromJson(String str) => List<MatchTextColorModel>.from(json.decode(str).map((x) => MatchTextColorModel.fromJson(x)));

String matchTextColorModelToJson(List<MatchTextColorModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MatchTextColorModel {
    String colorName;
    String red;
    String green;
    String blue;

    MatchTextColorModel({
        required this.colorName,
        required this.red,
        required this.green,
        required this.blue,
    });

    factory MatchTextColorModel.fromJson(Map<String, dynamic> json) => MatchTextColorModel(
        colorName: json["ColorName"],
        red: json["Red"],
        green: json["Green"],
        blue: json["Blue"],
    );

    Map<String, dynamic> toJson() => {
        "ColorName": colorName,
        "Red": red,
        "Green": green,
        "Blue": blue,
    };
}
