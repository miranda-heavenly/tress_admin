import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:tress_admin/model/product/product.dart';

class HomeController extends GetxController{

//create instance of firestore
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  //create collection reference for product collections
  late CollectionReference productCollection;

  //Create controllers for input fields
  TextEditingController productNameCtrl = TextEditingController();
  TextEditingController productDescriptionCtrl = TextEditingController();
  TextEditingController productImageCtrl = TextEditingController();
  TextEditingController productPriceCtrl = TextEditingController();

  //initialize dropdown fields
  String brand = "Brand";
  String category ="Category";
  bool offer = true;

  List <Product> products =[];

  @override
  Future<void> onInit() async {
    productCollection = firestore.collection('products'); //assigns a reference to a Firestore collection named "products"  to the variable
    await fetchProducts(); //The await keyword ensures that the code execution pauses until fetchProducts completes. 
    super.onInit();
  }


//adding products to firebase database
addProduct(){

  //create document reference for product document
  try {
  DocumentReference doc = productCollection.doc();
  
  //create an instance of a product
  Product product = Product(
        id: doc.id,
        name: productNameCtrl.text,
        description: productDescriptionCtrl.text,
        category: category,
        image: productImageCtrl.text,
        price: double.tryParse(productPriceCtrl.text),
        brand: brand,
        offer: offer
  );
  //convert product to json format. this is handled by the product.g.dart file.
  final productJson = product.toJson();
  
  //add product to document
  doc.set(productJson);

  //if the try is successful
  Get.snackbar("Success", "Product added successfully", colorText: Colors.green);
  setValuesDefault();
} 

on Exception catch (e) {
  //if there is an exception
  Get.snackbar("Error", e.toString(), colorText: Colors.red);
  print(e);
}
}

//fetching products from the database
fetchProducts() async {
  try {
  QuerySnapshot productSnapshop = await productCollection.get();
  final List<Product> retreivedProducts = productSnapshop.docs.map((doc) => 
  Product.fromJson(doc.data() as Map<String, dynamic>)).toList(); // retrieves new product data from Firestore.
  
  products.clear(); //first clear the list before adding to avoid duplicates. only manipulates the local list, not the database.
  products.assignAll(retreivedProducts);

  // Get.snackbar("Success", "Products fetched successfully", colorText: Colors.green);
} 
on Exception catch (e) {
  Get.snackbar("Erroe", e.toString(), colorText: Colors.red);
  print(e);
}
finally {
   update();
}
 
}

//delete products
deleteProducts(String id) async {
 try {
  await productCollection.doc(id).delete();
  fetchProducts();
  Get.snackbar("Success", "Product deleted successfully", colorText: Colors.green);

} 
on Exception catch (e) {
 Get.snackbar("Error", e.toString(), colorText: Colors.red);
 print(e);
}
}

//Clearing up the input fields anfter form submission
setValuesDefault(){
  productNameCtrl.clear();
  productDescriptionCtrl.clear();
  productImageCtrl.clear();
  productPriceCtrl.clear();

  brand = "Brand";
  category ="Category";
  offer = true;
  update();

}

}