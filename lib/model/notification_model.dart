class ApiModel {
  String? description;
  var time;
  var type;
  ApiModel({this.description, this.time,this.type});


  factory ApiModel.fromJson(Map<String, dynamic> json) {
    return ApiModel(
      description: json['description'],
      time:json['time_taken'],
      type: json['type']
    );
  }
}
