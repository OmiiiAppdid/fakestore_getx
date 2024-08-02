import 'package:cached_network_image/cached_network_image.dart';
import 'package:fakestore_app_getx/controller/product_controller.dart';
import 'package:fakestore_app_getx/static_methods/styles.dart';
import 'package:fakestore_app_getx/view/widgets/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsScreen extends StatefulWidget {
  final sName;

  ProductsScreen({super.key, this.sName});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final _productController = Get.put(ProductController());

  @override
  void initState() {
    _productController.fetchProducts(widget.sName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Clr().white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
        backgroundColor: Clr().white,
        centerTitle: true,
        title: Text(widget.sName),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Obx(() {
              return GridView.builder(
                shrinkWrap: true,
                itemCount: _productController.productList.length,
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    mainAxisExtent: 295),
                itemBuilder: (context, index) {
                  var v = _productController.productList[index];
                  return AppLayouts().productLayout(
                      context,
                      index,
                      _productController.productList[index],
                      _productController.productList[index].id);
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
