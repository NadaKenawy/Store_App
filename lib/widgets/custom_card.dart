import 'package:flutter/material.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/screens/update_product_page.dart';

// ignore: must_be_immutable
class CustomCard extends StatefulWidget {
  CustomCard({
    required this.productModel,
    super.key,
  });
  ProductModel productModel;

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final updatedProduct = await Navigator.pushNamed(
          context,
          UpdateProductPage.id,
          arguments: widget.productModel,
        );

        if (updatedProduct != null && updatedProduct is ProductModel) {
          setState(() {
            widget.productModel = updatedProduct;
          });
        }
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 40,
                    color: Colors.grey.withOpacity(.2),
                    spreadRadius: 0,
                    offset: const Offset(10, 10))
              ],
            ),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.productModel.title,
                      maxLines: 1,
                      style: const TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          ('\$${widget.productModel.price.toString()}'),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 16),
                        ),
                        IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {},
                            icon: const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            left: 25,
            child: Image.network(
              widget.productModel.image,
              height: 100,
              width: 100,
            ),
          )
        ],
      ),
    );
  }
}
