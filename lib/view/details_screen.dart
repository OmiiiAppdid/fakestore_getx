import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../controller/proDetails_controller.dart';
import '../static_methods/styles.dart';

class DetailsScreen extends StatelessWidget {
  final int productId;
  final ProDetailsController _proDetailsController =
      Get.put(ProDetailsController());

  DetailsScreen({required this.productId});

  @override
  Widget build(BuildContext context) {
    _proDetailsController.getDetails(productId);
    var _razorpay = Razorpay();

    return Scaffold(
        backgroundColor: Clr().white,
        appBar: AppBar(
            forceMaterialTransparency: true,
            automaticallyImplyLeading: false,
            backgroundColor: Clr().white,
            centerTitle: true,
            title: Obx(
              () => Text(
                _proDetailsController.details.value.title,
                style: Sty()
                    .largeText
                    .copyWith(fontWeight: FontWeight.w600, fontSize: 20),
              ),
            )),
        body: SingleChildScrollView(child: Obx(() {
          final product = _proDetailsController.details.value;
          if (product.id == 0) {
            return Center(
                child: CircularProgressIndicator(
              color: Clr().primaryColor,
            ));
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 24,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    width: MediaQuery.of(context).size.width,
                    height: 450,
                    fit: BoxFit.cover,
                    imageUrl: product.image,
                    errorWidget: (context, url, error) => Image.network(
                        fit: BoxFit.cover,
                        'https://www.kudratikahumbo.com/wp-content/uploads/2019/12/Hero-Banner-Placeholder-Light-1024x480-1.png'),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title,
                        style: Sty().mediumText.copyWith(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        "₹ ${product.price.toString()}/-",
                        style: Sty().largeText.copyWith(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        "Description",
                        style: Sty()
                            .mediumText
                            .copyWith(color: Clr().hintColor.withOpacity(0.8)),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        product.description,
                        style: Sty()
                            .smallText
                            .copyWith(height: 1.2, color: Clr().hintColor),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Center(
                        child: SizedBox(
                          height: 48,
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: ElevatedButton(
                            onPressed: () {
                              // STM().redirect2page(context, const MyCart());
                            },
                            // style: ElevatedButton.styleFrom(
                            //     backgroundColor: Clr().greenColor, elevation: 1),
                            child: Text(
                              "Add To Cart",
                              style: Sty().mediumText.copyWith(
                                  color: Clr().primaryColor,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: SizedBox(
                          height: 48,
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: ElevatedButton(
                            onPressed: () {
                              var options = {
                                'key': 'rzp_test_EJAeyQngpBjLFd',
                                'amount': product.price.toString(),
                                'name': product.title,
                                'theme.color': '#2ca9bc',
                                'timeout': 900,
                                // 'external': {
                                //   'wallets': ['paytm']
                                // }
                              };
                              try {
                                _razorpay.open(options);
                                debugPrint('Success fdfdf');
                              } catch (e) {
                                debugPrint('Error: $e');
                                print(e.toString());
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Clr().primaryColor,
                                elevation: 1),
                            child: Text(
                              "Buy Now",
                              style: Sty().mediumText.copyWith(
                                  color: Clr().white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                )
              ],
            );
          }
        })));
  }
}
