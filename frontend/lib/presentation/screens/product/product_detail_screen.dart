import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:frontend/core/ui.dart';
import 'package:frontend/data/models/product/product_model.dart';
import 'package:frontend/logic/cubits/cart_cubit/cart_cubit.dart';
import 'package:frontend/logic/cubits/cart_cubit/cart_state.dart';
import 'package:frontend/logic/services/formater.dart';
import 'package:frontend/presentation/widgets/gap_widget.dart';
import 'package:frontend/presentation/widgets/primary_button.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductModel productModel;
  const ProductDetailsScreen({super.key, required this.productModel});
  static const String routeName = "ProductDetailsScreen";
  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("${widget.productModel.title}"),
        ),
        body: SafeArea(
          child: ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width,
                child: CarouselSlider.builder(
                  itemCount: widget.productModel.images?.length ?? 0,
                  slideBuilder: (index) {
                    String url = widget.productModel.images![index];
                    return CachedNetworkImage(imageUrl: url);
                  },
                ),
              ),
              const Gap(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.productModel.title}",
                        style: TextStyles.heading3,
                      ),
                      Text(
                        Formater.formatPrice(widget.productModel.price),
                        style: TextStyles.heading2,
                      ),
                      const Gap(
                        size: 10,
                      ),
                      BlocBuilder<CartCubit, CartState>(
                          builder: (context, state) {
                        bool isInCart = BlocProvider.of<CartCubit>(context)
                            .cartContains(widget.productModel);
                        return PrimaryButton(
                          text: isInCart
                              ? "Product Already in cart"
                              : "Add to cart",
                          color:
                              isInCart ? AppColors.textLight : AppColors.accent,
                          onPressed: () {
                            if (isInCart) {
                              return;
                            }
                            BlocProvider.of<CartCubit>(context)
                                .addToCart(widget.productModel, 1);
                          },
                        );
                      }),
                      const Gap(
                        size: 10,
                      ),
                      Text(
                        "Description",
                        style: TextStyles.body2
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ]),
              ),
            ],
          ),
        ));
  }
}
