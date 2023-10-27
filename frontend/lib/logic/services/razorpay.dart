import 'package:frontend/data/models/order/order_model.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorPayServices {
  static final _instance = Razorpay();
  static Future<void> checkOutOrder(
    OrderModel orderModel, {
    required Function(PaymentSuccessResponse) onSuccess,
    required Function(PaymentFailureResponse) onFailure,
  }) async {
    var options = {
      'key': 'rzp_test_tEqNZlBqO5bwyI',
      'order_id': "${orderModel.razorPayOrderId}",
      'name': 'Ecommerce App',
      'description': '${orderModel.sId}',
      'prefill': {
        'contact': '${orderModel.user?.phoneNumber}',
        'email': '${orderModel.user?.phoneNumber}'
      }
    };
    _instance.on(Razorpay.EVENT_PAYMENT_SUCCESS,
        (PaymentSuccessResponse response) {
      onSuccess(response);
      _instance.clear();
    });
    _instance.on(Razorpay.EVENT_PAYMENT_ERROR,
        (PaymentFailureResponse response) {
      onFailure(response);
      _instance.clear();
    });

    _instance.open(options);
  }
}
