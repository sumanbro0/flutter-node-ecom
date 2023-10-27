import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/ui.dart';
import 'package:frontend/presentation/widgets/gap_widget.dart';

class OrderPlacedScreen extends StatefulWidget {
  const OrderPlacedScreen({super.key});
  static const routeName = "order_placed";
  @override
  State<OrderPlacedScreen> createState() => _OrderPlacedScreenState();
}

class _OrderPlacedScreenState extends State<OrderPlacedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Placed!"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(CupertinoIcons.cube_box_fill,
                  color: AppColors.textLight, size: 100),
              const Gap(size: -8),
              Text(
                "Order Placed!",
                style: TextStyles.heading3.copyWith(color: AppColors.textLight),
              ),
              const Gap(size: -5),
              Text(
                "You can check out the status by going to Profile > My Orders",
                style: TextStyles.body2.copyWith(color: AppColors.textLight),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
