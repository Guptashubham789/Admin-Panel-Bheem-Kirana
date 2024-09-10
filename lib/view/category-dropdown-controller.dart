import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CategoryDropDownController extends GetxController{
  RxList<Map<String,dynamic>> categories=<Map<String,dynamic>>[].obs;
  RxString? selectedCategoryId;
  RxString? selectedCategoryName;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

  }

  Future<void> fetchCategories() async{
    try{
      QuerySnapshot<Map<String,dynamic>> querySnapshot=await FirebaseFirestore.instance.collection('categories').get();


      //document fetch karke hm logo es list ke andr add kar liya hai name,img,id category ka
      List<Map<String,dynamic>> categoriesList=[];
      querySnapshot.docs.forEach((DocumentSnapshot<Map<String,dynamic>> document){
        categoriesList.add({
        'categoryId':document.id,
          'categoryImg':document['categoryImg'],
          'categoryName':document['categoryName']
      });
      },);

      categories.value=categoriesList;
      update();
    }catch(e){
      print("Error : $e");
    }
  }

  //set selected category
  void selectedCategory(String? categoryId){
    selectedCategoryId=categoryId?.obs;
    update();
  }

  //fetch category Name
  Future<String?> getCategoryName(String? categoryId) async{
    try{
      DocumentSnapshot<Map<String,dynamic>> snapshot=await FirebaseFirestore.instance
          .collection('categories')
          .doc(categoryId)
          .get();
      if(snapshot.exists){
        return snapshot.data()?['categoryName'];
      }else{
        return null;
      }
    }catch(e){
      print("Error : $e");
      return null;
    }
  }

  void setCategoryName(String? categoryName){
    selectedCategoryName=categoryName?.obs;
  }

}