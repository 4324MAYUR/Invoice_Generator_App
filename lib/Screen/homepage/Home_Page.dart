import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invoice_generator_app/routes/All_Routes.dart';
import 'package:invoice_generator_app/utils/extensions.dart';
import '../../utils/globlas.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("HOME PAGE")),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    foregroundImage: Globals.image != null
                        ? FileImage(Globals.image!)
                        : null,
                    child: Globals.image == null
                        ?  const Text("Add Logo",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    )
                        : null,
                    radius: 80,
                    backgroundColor: Colors.black,
                  ),
                  FloatingActionButton.small(
                    onPressed: () async {
                      final ImagePicker imagePicker = ImagePicker();
                      final source = await showDialog<ImageSource>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Center(
                              child: Text(
                                "Choose Image Source",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                IconButton(
                                  icon: const Icon(
                                    CupertinoIcons.camera_fill,
                                    size: 25,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(ImageSource.camera);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(
                                    CupertinoIcons.photo,
                                    size: 25,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(ImageSource.gallery);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                      if (source != null) {
                        final XFile? file =
                        await imagePicker.pickImage(source: source);
                        if (file != null) {
                          setState(() {
                            Globals.image = File(file.path);
                          });
                        }
                      }
                    },
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  20.h,
                  TextFormField(
                    onSaved: (val) => Globals.c_name = val,
                    initialValue: Globals.c_name,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Please enter Company Name ";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Company Name",
                      hintText: " Google ",
                      prefixIcon: const Icon(Icons.drive_file_rename_outline_rounded),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  20.h,
                  TextFormField(
                    onSaved: (val) => Globals.slogan = val,
                    initialValue: Globals.slogan,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: "Company Slogan",
                      hintText: "Your slogan here",
                      prefixIcon: const Icon(Icons.lightbulb_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),

                  ),
                  20.h,
                  TextFormField(
                    maxLength: 10,
                    onSaved: (val) => Globals.c_contact = val,
                    initialValue: Globals.c_contact,
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
                      labelText: "Contact",
                      hintText: "Enter number",
                      prefixIcon: const Icon(Icons.local_phone_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                  15.h,
                  TextFormField(
                    onSaved: (val) => Globals.c_address = val,
                    initialValue: Globals.c_address,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Please enter Company Address";
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      labelText: "Company Address",
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
                            .map((e) => e['company'] = Globals.c_name)
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
                          Navigator.of(context).pushNamed(AllRoutes.costomerpage);
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
