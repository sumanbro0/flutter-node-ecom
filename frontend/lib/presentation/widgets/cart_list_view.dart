import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/data/models/cart/cart_item_model.dart';
import 'package:frontend/logic/cubits/cart_cubit/cart_cubit.dart';
import 'package:frontend/logic/services/formater.dart';
import 'package:frontend/presentation/widgets/link_button.dart';
import 'package:input_quantity/input_quantity.dart';

class CartListView extends StatelessWidget {
  final List<CartItemModel> items;
  final bool shrinkWrap;
  final bool noScroll;

  const CartListView(
      {super.key,
      required this.items,
      this.shrinkWrap = false,
      this.noScroll = false});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: (noScroll) ? const NeverScrollableScrollPhysics() : null,
      shrinkWrap: shrinkWrap,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        return ListTile(
          leading: CachedNetworkImage(
            width: 50,
            imageUrl: item.product!.images![0],
          ),
          title: Text("${item.product?.title}"),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "${Formater.formatPrice(item.product!.price!)} x ${item.quantity} = ${Formater.formatPrice(item.product!.price! * item.quantity!)}"),
              LinkButton(
                onPressed: () {
                  BlocProvider.of<CartCubit>(context)
                      .removeFromCart(item.product!);
                },
                text: "Delete",
                color: Colors.red,
              ),
            ],
          ),
          trailing: InputQty(
            maxVal: 99,
            initVal: item.quantity!,
            minVal: 1,
            onQtyChanged: (value) {
              if (value == item.quantity) return;
              BlocProvider.of<CartCubit>(context)
                  .addToCart(item.product!, value as int);
            },
          ),
        );
      },
    );
  }
}
