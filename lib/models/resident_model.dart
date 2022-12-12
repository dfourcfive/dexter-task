class ResidentModel {
  String? id;
  String? fullName;
  int? room;
  int? age;
  ResidentModel({this.id, this.fullName, this.room, this.age});

  Map<String, dynamic> toJson() => {'fullName': fullName, 'room': room, 'age': age};

  factory ResidentModel.fromJson(Map<String, dynamic> json) =>
      ResidentModel(id: json['id'], fullName: json['fullName'], room: json['room'], age: json['age']);
}
