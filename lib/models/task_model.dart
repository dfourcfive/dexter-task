class TaskModel {
  //document id
  String? id;
  String title;
  String description;
  bool isComplete;
  String shift_id;
  //the resident which will be taken care of
  String resident_id;
  //this is optional , we can use shift_id since shift also point to the owner_id
  String owner_id;
  //we could add history to track all owners in case this task was passed to another
  // List<String> prevOwners

  TaskModel(
      {this.id,
      required this.description,
      required this.isComplete,
      required this.title,
      required this.owner_id,
      required this.resident_id,
      required this.shift_id});

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'isComplete': isComplete,
        'shift_id': this.shift_id,
        'owner_id': this.owner_id,
        'resident_id': this.resident_id
      };

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isComplete: json['isComplete'],
      owner_id: json['owner_id'],
      resident_id: json['resident_id'],
      shift_id: json['shift_id']);
}
