// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tress_admin/controller/home_controller.dart';
import 'package:tress_admin/widgets/app_button.dart';
import 'package:tress_admin/widgets/app_text.dart';
import 'package:tress_admin/widgets/app_text_heading.dart';
import 'package:tress_admin/widgets/dropdown_menu.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      initState: (_) {},
      builder: (ctrl) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Add a Product"),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    AppTextHeading(text: "Add a Product"),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: ctrl.productNameCtrl, //assign controller to name controller from the homecontroller page
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black)),
                      hintText: "Enter product name",
                      label: AppText(text: "Product Name")),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: ctrl.productDescriptionCtrl, 
                  maxLines: 4,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    hintText: "Enter product description",
                    label: AppText(text: "Description"),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: ctrl.productImageCtrl, 
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black)),
                      hintText: "Enter image link",
                      label: AppText(text: "Image URL")),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: ctrl.productPriceCtrl, 
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black)),
                      hintText: "Enter the price",
                      label: AppText(text: "Price")),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Flexible(
                        child: DropDownMenu(
                      items: ['Cat1', 'Cat2', 'Cat3', 'Cat4'],
                      defaultText:  ctrl.category,
                      onSelected: (selectedValue) {
                        ctrl.category = selectedValue ?? "General";
                        ctrl.update();
                      },
                    )),
                    Flexible(
                        child: DropDownMenu(
                      items: ['Brand1', 'Brand2', 'Brand3'],
                      defaultText: ctrl.brand,
                      onSelected: (selectedValue) {
                        ctrl.brand = selectedValue ?? "Unbranded";
                        ctrl.update();
                      },
                    )),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                AppText(text: "Offer Products?"),
                DropDownMenu(
                      items: ['True', 'False'],
                      defaultText: ctrl.offer.toString(),
                      onSelected: (selectedValue) {
                        ctrl.offer = selectedValue == "True"; // Parse as boolean
                        ctrl.update();
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                AppButton(
                  onPressed: (){
                    ctrl.addProduct(); //calls the add product function from the home controller file
                  }, 
                  text: "Add Product")
              ],
            ),
          ),
        ),
      ),
    );
       },
    );
  }
}
  