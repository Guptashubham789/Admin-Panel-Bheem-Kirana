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