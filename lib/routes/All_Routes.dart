import 'package:flutter/cupertino.dart';
import 'package:invoice_generator_app/Screen/homepage/Home_Page.dart';
import 'package:invoice_generator_app/Screen/splashpage/Splash_Page.dart';
import 'package:invoice_generator_app/Screen/CustomerPage/Customer_Page.dart';
import 'package:invoice_generator_app/Screen/produckpage/Product_Page.dart';
import 'package:invoice_generator_app/Screen/pdfpage/Pdf_Page.dart';

class AllRoutes
{
  static String splashpage = "/";
  static String homepage = "Home_Page";
  static String costomerpage = "Customer_Page";
  static String productpage = "Product_Page";
  static String pdfpage = "Pdf_Page";

  static Map<String,Widget Function (BuildContext)> routes =
  {
    splashpage : (context) => const Splash_Page(),
    homepage : (context) => const Home_Page(),
    costomerpage : (context) => const Customer_Page(),
    productpage : (context) => const Product_Page(),
    pdfpage : (context) => const Pdf_Page(),
  };
}