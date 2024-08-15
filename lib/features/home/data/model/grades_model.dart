class GradesModel {
  String? id;
  String? name;
  String? nameAr;
  String? nameEn;
  String? schoolId;

  GradesModel({this.id, this.name, this.nameAr, this.nameEn, this.schoolId});

  GradesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    schoolId = json['school_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['school_id'] = this.schoolId;
    return data;
  }
}
