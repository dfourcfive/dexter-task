class NurseModel {
  String? id;
  String? auth_id;
  String? fullName;

  NurseModel({this.id, this.fullName, this.auth_id});
  //
  factory NurseModel.fromJson(Map<String, dynamic> json) => NurseModel(id: json['id'], auth_id: json['auth_id'], fullName: json['fullName']);
}
