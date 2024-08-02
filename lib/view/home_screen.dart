import 'package:fakestore_app_getx/controller/category_controller.dart';
import 'package:fakestore_app_getx/controller/product_controller.dart';
import 'package:fakestore_app_getx/static_methods/styles.dart';
import 'package:fakestore_app_getx/view/products_screen.dart';
import 'package:fakestore_app_getx/view/widgets/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final _categoryController = Get.put(CategoryController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Clr().bgWhite,
      appBar: AppBar(
        forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
        backgroundColor: Clr().white,
        centerTitle: true,
        title: SvgPicture.asset(
          "assets/cart_logo.svg",
          width: 45,
          // color: Clr().primaryColor,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Obx(() => ListView.separated(
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 20,
                    );
                  },
                  itemCount: _categoryController.categoryList.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  itemBuilder: (context, index) {
                    var v = _categoryController.categoryList[index];
                    return InkWell(
                      onTap: () {
                        Get.to(
                          ProductsScreen(
                            sName: v.toString(),
                          ),
                        );
                      },
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Clr().borderColor),
                          borderRadius: BorderRadius.circular(12),
                          color: Clr().white,
                        ),
                        child: Center(
                          child: Text(
                            v,
                            style: Sty().mediumText,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    );
                  },
                ))
          ],
        ),
      ),
    );
  }
}
