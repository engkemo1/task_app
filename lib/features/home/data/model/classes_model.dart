class ClassesModel {
  String? id;
  String? name;
  String? nameAr;
  String? nameEn;
  String? gradeId;
  String? schoolId;

  ClassesModel(
      {this.id,
        this.name,
        this.nameAr,
        this.nameEn,
        this.gradeId,
        this.schoolId});

  ClassesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    gradeId = json['grade_id'];
    schoolId = json['school_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['grade_id'] = this.gradeId;
    data['school_id'] = this.schoolId;
    return data;
  }
}
