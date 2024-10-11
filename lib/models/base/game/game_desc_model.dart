// To parse this JSON data, do
//
//     final gameDescModel = gameDescModelFromJson(jsonString);

import 'dart:convert';

List<GameDescModel> gameDescModelFromJson(String str) => List<GameDescModel>.from(json.decode(str).map((x) => GameDescModel.fromJson(x)));

String gameDescModelToJson(List<GameDescModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GameDescModel {
    int descCount;
    String desc;
    List<String> desc1;
    String image1;
    int image1SizeX;
    int image1SizeY;
    List<String>? addImage1;
    List<int>? addImage1SizeX;
    List<int>? addImage1SizeY;
    List<int>? addImage1PosX;
    List<int>? addImage1PosY;
    List<String> desc2;
    String image2;
    int image2SizeX;
    int image2SizeY;
    List<String> desc3;
    String image3;
    int image3SizeX;
    int image3SizeY;

    GameDescModel({
        required this.descCount,
        required this.desc,
        required this.desc1,
        required this.image1,
        required this.image1SizeX,
        required this.image1SizeY,
        this.addImage1,
        this.addImage1SizeX,
        this.addImage1SizeY,
        this.addImage1PosX,
        this.addImage1PosY,
        required this.desc2,
        required this.image2,
        required this.image2SizeX,
        required this.image2SizeY,
        required this.desc3,
        required this.image3,
        required this.image3SizeX,
        required this.image3SizeY,
    });

    factory GameDescModel.fromJson(Map<String, dynamic> json) => GameDescModel(
        descCount: json["descCount"],
        desc: json["desc"],
        desc1: List<String>.from(json["desc1"].map((x) => x)),
        image1: json["image1"],
        image1SizeX: json["image1SizeX"],
        image1SizeY: json["image1SizeY"],
        addImage1: json["add_image_1"] == null ? [] : List<String>.from(json["add_image_1"]!.map((x) => x)),
        addImage1SizeX: json["add_image_1_size_x"] == null ? [] : List<int>.from(json["add_image_1_size_x"]!.map((x) => x)),
        addImage1SizeY: json["add_image_1_size_y"] == null ? [] : List<int>.from(json["add_image_1_size_y"]!.map((x) => x)),
        addImage1PosX: json["add_image_1_pos_x"] == null ? [] : List<int>.from(json["add_image_1_pos_x"]!.map((x) => x)),
        addImage1PosY: json["add_image_1_pos_y"] == null ? [] : List<int>.from(json["add_image_1_pos_y"]!.map((x) => x)),
        desc2: List<String>.from(json["desc2"].map((x) => x)),
        image2: json["image2"],
        image2SizeX: json["image2SizeX"],
        image2SizeY: json["image2SizeY"],
        desc3: List<String>.from(json["desc3"].map((x) => x)),
        image3: json["image3"],
        image3SizeX: json["image3SizeX"],
        image3SizeY: json["image3SizeY"],
    );

    Map<String, dynamic> toJson() => {
        "descCount": descCount,
        "desc": desc,
        "desc1": List<dynamic>.from(desc1.map((x) => x)),
        "image1": image1,
        "image1SizeX": image1SizeX,
        "image1SizeY": image1SizeY,
        "add_image_1": addImage1 == null ? [] : List<dynamic>.from(addImage1!.map((x) => x)),
        "add_image_1_size_x": addImage1SizeX == null ? [] : List<dynamic>.from(addImage1SizeX!.map((x) => x)),
        "add_image_1_size_y": addImage1SizeY == null ? [] : List<dynamic>.from(addImage1SizeY!.map((x) => x)),
        "add_image_1_pos_x": addImage1PosX == null ? [] : List<dynamic>.from(addImage1PosX!.map((x) => x)),
        "add_image_1_pos_y": addImage1PosY == null ? [] : List<dynamic>.from(addImage1PosY!.map((x) => x)),
        "desc2": List<dynamic>.from(desc2.map((x) => x)),
        "image2": image2,
        "image2SizeX": image2SizeX,
        "image2SizeY": image2SizeY,
        "desc3": List<dynamic>.from(desc3.map((x) => x)),
        "image3": image3,
        "image3SizeX": image3SizeX,
        "image3SizeY": image3SizeY,
    };
}
