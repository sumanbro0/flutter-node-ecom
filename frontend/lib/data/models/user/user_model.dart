class UserModel {
  String? sId;
  String? fullname;
  String? email;
  String? phoneNumber;
  String? city;
  String? state;
  String? address;
  int? profileProgress;
  String? id;
  String? updatedOn;
  String? createdOn;

  UserModel(
      {this.sId,
      this.fullname,
      this.email,
      this.phoneNumber,
      this.city,
      this.state,
      this.address,
      this.profileProgress,
      this.id,
      this.updatedOn,
      this.createdOn});

  UserModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullname = json['fullname'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    city = json['city'];
    state = json['state'];
    address = json['address'];
    profileProgress = json['profileProgress'];
    id = json['id'];
    updatedOn = json['updatedOn'];
    createdOn = json['createdOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['fullname'] = this.fullname;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['city'] = this.city;
    data['state'] = this.state;
    data['address'] = this.address;
    data['profileProgress'] = this.profileProgress;
    data['id'] = this.id;
    data['updatedOn'] = this.updatedOn;
    data['createdOn'] = this.createdOn;
    return data;
  }
}
