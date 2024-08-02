import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../controller/product_controller.dart';
import '../../model/proDetails_model.dart';
import '../../static_methods/styles.dart';
import '../details_screen.dart';

class AppLayouts {
  final _productController = Get.put(ProductController());

  Widget productLayout(ctx, index, v, pID) {
    var v = _productController.productList[index];
    var id = pID;

    return InkWell(
      onTap: () {
        Get.to(DetailsScreen(productId: id,
          // sID: id,
          // sName: v.title,
        ));
      },
      child: Container(
        decoration: BoxDecoration(
            color: Clr().white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Clr().borderColor)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  width: MediaQuery.of(ctx).size.width,
                  height: 200,
                  fit: BoxFit.cover,
                  // imageUrl: v['image'].toString(),
                  imageUrl: v.image,
                  errorWidget: (context, url, error) => Image.network(
                      fit: BoxFit.cover,
                      'https://www.kudratikahumbo.com/wp-content/uploads/2019/12/Hero-Banner-Placeholder-Light-1024x480-1.png'),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                // v.,
                v.title,
                style: Sty().mediumText,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                v.description,
                style: Sty()
                    .smallText
                    .copyWith(height: 1.2, color: Clr().hintColor),
                textAlign: TextAlign.left,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
