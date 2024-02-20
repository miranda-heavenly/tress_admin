import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tress_admin/controller/home_controller.dart';
import 'package:tress_admin/model/product/product.dart';
import 'package:tress_admin/pages/add_product_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      initState: (_) {},
      builder: (ctrl) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Products"),
            centerTitle: true,
            ),
          body: ListView.builder(
            itemCount: ctrl.products.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(ctrl.products[index].name ?? ''),
                subtitle: Text(ctrl.products[index].price.toString()),
                trailing: IconButton(
                    onPressed: () {
                      ctrl.deleteProducts(ctrl.products[index].id??'');
                    },
                    icon: Icon(Icons.delete), color: Colors.red[900],),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Get.to(AddProductPage());
            },
          ),
        );
      },
    );
  }
}
