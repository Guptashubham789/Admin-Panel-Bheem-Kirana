import 'dart:io';

import 'package:admin_grocery/utils/app-constant.dart';
import 'package:admin_grocery/view/category-dropdown-controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/product-images-controller.dart';

class AddProductScreen extends StatelessWidget {
   AddProductScreen({super.key});
   AddProductImagesController addProductImagesController=Get.put(AddProductImagesController());
   CategoryDropDownController categoryDropDownController=Get.put(CategoryDropDownController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text('Add Product'),
      ),
      body: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Select Images'),
                ElevatedButton(
                    onPressed: (){
                      addProductImagesController.showImagesPickerDialog();
                    },
                    child: Text('Select Images')
                ),
              ],
            ),
            //show images
            GetBuilder<AddProductImagesController>(
              init: AddProductImagesController(),
                builder: (addProductImagesController){
                return addProductImagesController.selectedImages.length>0
                    ?Container(
                  width: Get.width-20,
                  height: Get.height/3.0,
                  child: GridView.builder(
                    itemCount: addProductImagesController.selectedImages.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 20,
                        crossAxisSpacing: 10,
                      ),
                      itemBuilder: (BuildContext context,int index){
                      return Stack(
                        children: [
                          Image.file(
                            File(addProductImagesController.selectedImages[index].path),
                            fit: BoxFit.cover,
                            height: Get.height/4,
                            width: Get.width/2,
                          ),
                          Positioned(child: InkWell(
                            onTap: (){
                              addProductImagesController.removeImage(index);
                            },
                            child: CircleAvatar(
                              backgroundColor: AppConstant.appMainColor,
                              child: Icon(Icons.close,color: AppConstant.appTextColor,),
                            ),
                          ))
                        ],
                      );
                      },
                  ),
                )
                    :SizedBox.shrink();
            }),
          ],
        ),
      ),
    );
  }
}
