import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:frontend/core/ui.dart';
import 'package:frontend/data/models/product/product_model.dart';
import 'package:frontend/logic/services/formater.dart';
import 'package:frontend/presentation/screens/product/product_detail_screen.dart';
import 'package:frontend/presentation/widgets/gap_widget.dart';

class ProductListView extends StatelessWidget {
  final List<ProductModel> products;

  const ProductListView({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];

        return CupertinoButton(
          onPressed: () {
            Navigator.pushNamed(context, ProductDetailsScreen.routeName,
                arguments: product);
          },
          padding: EdgeInsets.zero,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: CachedNetworkImage(
                  width: MediaQuery.of(context).size.width / 3,
                  imageUrl: "${product.images?[0]}",
                ),
              ),
              // const Padding(
              //   padding: EdgeInsets.all(8.0), // Adjus
              // ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${product.title}",
                      style: TextStyles.body1
                          .copyWith(fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "${product.description}",
                      style:
                          TextStyles.body2.copyWith(color: AppColors.textLight),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Gap(),
                    Text(
                      Formater.formatPrice(product.price!),
                      style: TextStyles.heading3,
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
