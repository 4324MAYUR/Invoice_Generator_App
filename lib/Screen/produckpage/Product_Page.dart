import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoice_generator_app/routes/All_Routes.dart';
import 'package:invoice_generator_app/utils/extensions.dart';
import 'package:invoice_generator_app/utils/globlas.dart';

class Product_Page extends StatefulWidget {
  const Product_Page({super.key});

  @override
  State<Product_Page> createState() => _Product_PageState();
}

class _Product_PageState extends State<Product_Page> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Initialize the product list with a structured map
  List<Map<String, String>> allproduct = [
    {
      'name': '',
      'qty': '',
      'price': '',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("PRODUCT PAGE"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: allproduct
                  .map(
                    (e) => Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      20.h,
                      TextFormField(
                        onChanged: (val) => e['name'] = val,
                        initialValue: e['name'],
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please Enter Product Name";
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: "Product Name",
                          hintText: "Enter Product Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
                      20.h,
                      TextFormField(
                        onChanged: (val) => e['qty'] = val,
                        initialValue: e['qty'],
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please enter Product Quantity";
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: "Product Quantity",
                          hintText: "Numbers ..",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
                      20.h,
                      TextFormField(
                        onChanged: (val) => e['price'] = val,
                        initialValue: e['price'],
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please enter Product Price";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                          labelText: "Product Price",
                          hintText: "Enter Product Price",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
                      20.h,
                      ElevatedButton.icon(
                        onPressed: () {
                          allproduct.remove(e);
                          setState(() {});
                        },
                        label: const Text("REMOVE"),
                        icon: const Icon(Icons.remove_circle),
                      ),
                    ],
                  ),
                ),
              )
                  .toList(),
            ),
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: () {
              allproduct.add({
                'name': '',
                'qty': '',
                'price': '',
              });
              setState(() {});
            },
            child: const Icon(Icons.add),
          ),
          10.w,
          FloatingActionButton.extended(
            onPressed: () {
              bool valid = formKey.currentState!.validate();
              if (valid) {
                formKey.currentState!.save();
                Globals.products = allproduct;

                SnackBar snackBar = const SnackBar(
                  content: Text("-- Details saved successfully... --"),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                Navigator.of(context).pushNamed(AllRoutes.pdfpage);
              } else {
                SnackBar snackBar = const SnackBar(
                  content: Text("Something is wrong...!!"),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            icon: const Icon(Icons.picture_as_pdf_outlined),
            label: const Text("PDF"),
          ),
        ],
      ),
    );
  }
}
