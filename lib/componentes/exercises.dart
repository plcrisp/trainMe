import 'dart:convert';

ExercisesItens exercisesItensFromJson(String str) =>
    ExercisesItens.fromJson(json.decode(str));

String exercisesItensToJson(ExercisesItens data) => json.encode(data.toJson());

class ExercisesItens {
  String eid;
  String equipment;
  String imgId;
  String name;
  String primaryGroup;
  String secondaryGroup;
  String obs;

  ExercisesItens({
    required this.eid,
    required this.equipment,
    required this.imgId,
    required this.name,
    required this.primaryGroup,
    required this.secondaryGroup,
    required this.obs,
  });

  factory ExercisesItens.fromJson(Map<String, dynamic> json) => ExercisesItens(
        eid: json["eid"],
        equipment: json["equipment"],
        imgId: json["imgId"],
        name: json["name"],
        primaryGroup: json["primaryGroup"],
        secondaryGroup: json["secondaryGroup"],
        obs: json["obs"],
      );

  Map<String, dynamic> toJson() => {
        "eid": eid,
        "equipment": equipment,
        "imgId": imgId,
        "name": name,
        "primaryGroup": primaryGroup,
        "secondaryGroup": secondaryGroup,
        "obs": obs,
      };
}
