import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/services/update_product.dart';
import 'package:store_app/widgets/custom_button.dart';
import 'package:store_app/widgets/custom_text_field.dart';

class UpdateProductPage extends StatefulWidget {
  const UpdateProductPage({
    super.key,
  });
  static String id = 'UpdateProductPage';

  @override
  State<UpdateProductPage> createState() => _UpdateProductPageState();
}

class _UpdateProductPageState extends State<UpdateProductPage> {
  String? pName, pDesc, pImage, pPrice;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    ProductModel productModel =
        ModalRoute.of(context)!.settings.arguments as ProductModel;
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Update Product',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                CustomTextField(
                  onChanged: (data) {
                    pName = data;
                  },
                  hintText:"Title", 
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextField(
                  onChanged: (data) {
                    pDesc = data;
                  },
                  hintText:
                      "Description",
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextField(
                  inputType: TextInputType.number,
                  onChanged: (data) {
                    pPrice = data;
                  },
                  hintText: "Price",
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextField(
                  onChanged: (data) {
                    pImage = data;
                  },
                  hintText: "Image", 
                ),
                const SizedBox(
                  height: 50,
                ),
                CustomButon(
                  text: 'Update',
                  onTap: () async {
                    setState(() {
                      isLoading = true;
                    });
                    try {
                      await updateProduct(productModel);
                      ProductModel updatedProduct = ProductModel(
                        id: productModel.id,
                        title: pName ?? productModel.title,
                        description: pDesc ?? productModel.description,
                        price: double.parse(
                            pPrice ?? productModel.price.toString()),
                        image: pImage ?? productModel.image,
                        category: productModel.category,
                        rating: productModel.rating,
                      );
                      Navigator.pop(context, updatedProduct);
                    } catch (e) {
                      print(e);
                    }

                    setState(() {
                      isLoading = false;
                    });
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> updateProduct(ProductModel productModel) async {
    await UpdateProductService().updateProduct(
      title: pName == null ? productModel.title : pName!,
      price: pPrice == null ? productModel.price.toString() : pPrice!,
      desc: pDesc == null ? productModel.description : pDesc!,
      image: pImage == null ? productModel.image : pImage!,
      id: productModel.id!,
      category: productModel.category,
    );
  }
}
