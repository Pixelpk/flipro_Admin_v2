class ProjectRoles {
  bool? view;
  bool? addValue;
  bool? addNotes;
  bool? uploadProgress;
  bool? addPhotos;
  bool? requestPayment;

  ProjectRoles(
      {this.view =true,
        this.addValue =false,
        this.addNotes =false,
        this.uploadProgress =false,
        this.addPhotos =false,
        this.requestPayment =false,});

  ProjectRoles.fromJson(Map<String, dynamic> json) {
    view = json['view'];
    addValue = json['add_value'];
    addNotes = json['add_notes'];
    uploadProgress = json['upload_progress'];
    addPhotos = json['add_photos'];
    requestPayment = json['request_payment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['"view"'] = view;
    data['"add_value"'] = addValue;
    data['"add_notes"'] = addNotes;
    data['"upload_progress"'] = uploadProgress;
    data['"add_photos"'] = addPhotos;
    data['"request_payment"'] = requestPayment;
    return data;
  }
}
