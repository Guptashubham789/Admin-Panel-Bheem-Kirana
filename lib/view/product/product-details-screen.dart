import 'package:admin_grocery/models/product-model.dart';
import 'package:admin_grocery/utils/app-constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
class SingleProductScreen extends StatefulWidget {
   ProductModel productModel;
   SingleProductScreen({super.key, required  this.productModel});

  @override
  State<SingleProductScreen> createState() => _SingleProductScreenState();
}

class _SingleProductScreenState extends State<SingleProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
        backgroundColor: AppConstant.appMainColor,
      ),
      body: Container(
        child: Column(
          children: [
            Card(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Product Name :'),
                        Text(widget.productModel.productName,overflow: TextOverflow.ellipsis,),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Product Price :'),
                        Text(
                        widget.productModel.fullPrice!=''?
                        widget.productModel.fullPrice :
                        widget.productModel.salePrice,overflow: TextOverflow.ellipsis,),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Delivery Time :'),
                        Text(widget.productModel.deliveryTime,overflow: TextOverflow.ellipsis,),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Is Sale? :'),
                        Text(widget.productModel.isSale?"true":"False",overflow: TextOverflow.ellipsis,),
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      height: Get.height/6,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(widget.productModel.productImages[0]),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      height: Get.height/6,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(widget.productModel.productImages[1]),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Categories Name : "),
                        Text(widget.productModel.categoryName.toString())
                      ],
                    ),
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
