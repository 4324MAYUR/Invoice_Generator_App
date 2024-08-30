import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invoice_generator_app/utils/extensions.dart';
import 'package:invoice_generator_app/utils/globlas.dart';
import 'package:invoice_generator_app/routes/All_Routes.dart';

class Customer_Page extends StatefulWidget {
  const Customer_Page({super.key});

  @override
  State<Customer_Page> createState() => _Customer_PageState();
}

class _Customer_PageState extends State<Customer_Page> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text("COSTOER PAGE")),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  20.h,
                  TextFormField(
                    onSaved: (val) => Globals.name = val,
                    initialValue: Globals.name,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Please enter Your Name ";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Costomer Name",
                      prefixIcon: const Icon(Icons.drive_file_rename_outline_rounded),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  20.h,
                  TextFormField(
                    maxLength: 10,
                    onSaved: (val) => Globals.contact = val,
                    initialValue: Globals.contact,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Please enter phone number";
                      } else if (val.length < 10) {
                        return "Number must be 10 digits";
                      }
                      return null;
                    },
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: "Contact Number",
                      hintText: "Enter number",
                      prefixIcon: const Icon(Icons.local_phone_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                  15.h,
                  TextFormField(
                    onSaved: (val) => Globals.address = val,
                    initialValue: Globals.address,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Please enter Your Address";
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      labelText: "Your Address",
                      hintText: "House Num , Area Name",
                      prefixIcon: const Icon(Icons.location_on),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  20.h,
                  ElevatedButton(
                    onPressed: () {
                      bool valid = formKey.currentState!.validate();
                      if (valid) {
                        formKey.currentState!.save();
                        Globals.invoice
                            .map((e) => e['Costomer Name'] = Globals.name)
                            .toList();
                        SnackBar snackBar = const SnackBar(
                          content: Text(" -- Details saved is successfully... --"),
                          backgroundColor: Colors.green,
                          behavior: SnackBarBehavior.floating,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        FocusScope.of(context).unfocus();

                        Future.delayed(const Duration(seconds: 2), ()
                        {
                          Navigator.of(context).pushNamed(AllRoutes.productpage);
                        });
                      }
                      else {
                        SnackBar snackBar = const SnackBar(
                          content: Text("-- Something Went Wrong... --"),
                          backgroundColor: Colors.red,
                          behavior: SnackBarBehavior.floating,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    child: const Text("Next"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
