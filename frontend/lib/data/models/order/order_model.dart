// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:frontend/data/models/cart/cart_item_model.dart';
import 'package:frontend/data/models/user/user_model.dart';

class OrderModel extends Equatable {
  String? sId;
  UserModel? user;
  List<CartItemModel>? items;
  String? status;
  String? razorPayOrderId;
  double? totalAmount;
  DateTime? updatedOn;
  DateTime? createdOn;

  OrderModel(
      {this.sId,
      this.status,
      this.updatedOn,
      this.createdOn,
      this.items,
      this.user,
      this.razorPayOrderId,
      this.totalAmount});

  OrderModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = UserModel.fromJson(json["user"]);
    items = (json["items"] as List<dynamic>)
        .map((item) => CartItemModel.fromJson(item))
        .toList();
    totalAmount = double.tryParse(json["totalAmount"].toString());
    razorPayOrderId = json["razorPayOrderId"];
    status = json['status'];
    updatedOn = DateTime.tryParse(json['updatedOn']);
    createdOn = DateTime.tryParse(json['createdOn']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['user'] = user!.toJson();
    data['items'] =
        items!.map((item) => item.toJson(objectMode: true)).toList();
    data['razorPayOrderId'] = this.razorPayOrderId;
    data['totalAmount'] = this.totalAmount;
    data['status'] = this.status;
    data['updatedOn'] = this.updatedOn?.toIso8601String();
    data['createdOn'] = this.createdOn?.toIso8601String();
    return data;
  }

  @override
  List<Object?> get props => [sId];
}
