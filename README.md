# admin_grocery

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

Step 1 : (Drawer widget bnana hai)
-----------------------------------
1. Hme ek widget bnana hai drawer-widget  and es widget ko main-screen ke ander call karna hai.

Step 2 : (Get real time users data from firebase flutter using getx )
---------------------------------------------------------------------
1. Users pr click krne pr all user ka name phone ,img etc aa jaaye.
        
        
        body: StreamBuilder(
        stream: FirebaseFirestore.instance
        .collection('users')
        .orderBy('createdOn',descending: true)
        .snapshots(),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
        if(snapshot.hasError){
        return Center(
        child: Text('Error occured while fetching category!!'),
        );
        }
        if(snapshot.connectionState==ConnectionState.waiting){
        return Container(
        height: Get.height/5,
        child: Center(
        child:CupertinoActivityIndicator(),
        ),
        );
        }

            //jo data fetch kar rhe hai kya vh empty to nhi hai agr empty h to center me
            if(snapshot.data!.docs.isEmpty){
              return Center(
                child: Text('No users found!!'),
              );
            }
            if(snapshot.data!=null){
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context,index){
                    final data=snapshot.data!.docs[index];
                    Usermodel usermodel=Usermodel(
                      uId: data['uId'],
                      username: data['username'],
                      email: data['email'],
                      phone: data['phone'],
                      userImg:data['userImg'],
                      userDeviceToken: data['userDeviceToken'],
                      country: data['country'],
                      userAddress: data['userAddress'],
                      street: data['street'],
                      userCity: data['userCity'],
                      isAdmin: data['isAdmin'],
                      isActive: data['isActive'],
                      createdOn: data['createdOn'],
                    );
                    return Card(
                      elevation: 5,

                      child: ListTile(
                        title: Text(usermodel.username),
                        leading: CircleAvatar(
                          backgroundColor: AppConstant.appMainColor,
                          backgroundImage: NetworkImage(usermodel.userImg),
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(usermodel.email,style: TextStyle(color: Colors.black,fontSize: 10.0),),
                            SizedBox(
                              width: Get.width/20.0,
                            ),

                          ],
                        ),
                        trailing: Icon(Icons.edit),
                      ),
                    );
                  }

              );
            }
            return Container();
          }
      ),
    );
    }
    }


(Real time count)
----------------
1. Ek controller bnayenge

           import 'dart:async';
        
        import 'package:cloud_firestore/cloud_firestore.dart';
        import 'package:get/get.dart';
        
        class GetUserLengthController extends GetxController{

            final FirebaseFirestore _firestore=FirebaseFirestore.instance;
            late StreamSubscription<QuerySnapshot<Map<String,dynamic>>> _userControllerSubscription;
        
            final Rx<int> userCollectionLength=Rx<int>(0);
        
            @override
            void onInit() {
            // TODO: implement onInit
            super.onInit();
            _userControllerSubscription=_firestore.collection('users').where('isAdmin',isEqualTo: false).snapshots().listen((snapshot){
            userCollectionLength.value=snapshot.size;
            });
            }
            @override
            void onClose() {
            // TODO: implement onClose
            
        _userControllerSubscription.cancel();
        super.onClose();
        }
        
        }

Step 3 : (Get real time users orders from firebase flutter (Part 1))
-----------------------------------------------------------------------
Step 4 : (How to handle order status of flutter ecommerce app)

---------------------------------------------------------------
Step 5 : (Part-1) Pick multiple images from camera and gallery flutter
-----------------------------
1. sabse phle ek screen bnana hai 
   2. phir ek controller bnana hai 
      3. Dependency add
               image_picker:,device_init_plus:,intl:,permission_handler:,app_setting,
               firebase_storage:
               import 'package:device_info_plus/device_info_plus.dart';
               import 'package:firebase_storage/firebase_storage.dart';
               import 'package:flutter/material.dart';
               import 'package:get/get.dart';
               import 'package:image_picker/image_picker.dart';
               import 'package:permission_handler/permission_handler.dart';
      
               class AddProductImagesController extends GetxController{
               final ImagePicker _picker=ImagePicker();
               RxList<XFile> selectedImages =<XFile>[].obs;
      
             final RxList<String> arrImagesUrl= <String>[].obs;
             final FirebaseStorage storageRef=FirebaseStorage.instance;
             Future<void> showImagesPickerDialog() async{
                 PermissionStatus status;
                 DeviceInfoPlugin deviceInfoPlugin=DeviceInfoPlugin();
                 AndroidDeviceInfo androidDeviceInfo=await deviceInfoPlugin.androidInfo;

           if(androidDeviceInfo.version.sdkInt<=32){
               status=await Permission.storage.request();
           }else{
               status=await Permission.mediaLibrary.request();
           }
           //
           if(status==PermissionStatus.granted){
               Get.defaultDialog(
                   title: "Choose Image",
                   middleText: "Pick an image from the camera or gallery?",
                   actions: [
                       ElevatedButton(
                           onPressed: (){},
                           child: Text('Camera')
                       ),
                       ElevatedButton(
                           onPressed: (){},
                           child: Text('Gallery')
                       ),
                   ]

               );
           }

           if(status== PermissionStatus.denied){
               Get.snackbar("Error", "Please allow permission for further usage..");
               openAppSettings();
           }
           if(status== PermissionStatus.permanentlyDenied){
               Get.snackbar("Error", "Please allow permission for further usage..");
               openAppSettings();
           }
       }
         }
      
Step : (camera and gallery ))
------------------------
selectedImage("camera");
selectedImage("gallery");

    Future<void> selectedImage(String type)async{
        List<XFile> imgs=[];
        if(type=='gallery'){
            try{
                imgs=await _picker.pickMultiImage(imageQuality: 80);
                update();
            }catch(e){
                Get.snackbar("Error", "error gallery not open");
            }
        }else{
            final img=await _picker.pickImage(source: ImageSource.camera,imageQuality: 80);

            if(img != null){
                imgs.add(img);
                update();
            }
        }
        if(imgs.isEmpty){
            selectedImages.addAll(imgs);
            update();
        }
    }

Step : Display selected images in gridview builder using image picker
---------------------------------------------------------------
addscreen pr
------------
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

Delete images
--------------
      void removeImage(int index){
      selectedImages.removeAt(index);
      update();
      }

