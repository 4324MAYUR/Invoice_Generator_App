import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:invoice_generator_app/utils/globlas.dart';

class Pdf_Page extends StatefulWidget {
  const Pdf_Page({super.key});

  @override
  State<Pdf_Page> createState() => _Pdf_PageState();
}

class _Pdf_PageState extends State<Pdf_Page> {
  Future<Uint8List> getPdf() async {
    // 1. Generate object
    pw.Document pdf = pw.Document();

    // 2. Add and design Page
    pdf.addPage(
      pw.Page(
        margin: const pw.EdgeInsets.all(20),
        build: (pw.Context cnt) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // Invoice Header
            pw.Container(
              padding: const pw.EdgeInsets.all(10),
              decoration: pw.BoxDecoration(
                color: PdfColors.teal,
                borderRadius: pw.BorderRadius.circular(10),
              ),
              child: pw.Center(
                child: pw.Text(
                  'INVOICE',
                  style: pw.TextStyle(
                    fontSize: 30,
                    color: PdfColors.white,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
            ),
            pw.SizedBox(height: 20),

            // Invoice Details
            pw.Container(
              padding: const pw.EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: pw.BoxDecoration(
                color: PdfColors.grey300,
                borderRadius: pw.BorderRadius.circular(10),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'Invoice Number: ${Globals.in_num ?? 'N/A'}',
                    style: pw.TextStyle(
                      fontSize: 14,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.black,
                    ),
                  ),
                  pw.SizedBox(height: 5),
                  pw.Text(
                    'Customer Name: ${Globals.name ?? 'N/A'}',
                    style: pw.TextStyle(
                      fontSize: 14,
                      color: PdfColors.black,
                    ),
                  ),
                  pw.SizedBox(height: 5),
                  pw.Text(
                    'Invoice Date: ${Globals.date?.toIso8601String() ?? 'N/A'}',
                    style: pw.TextStyle(
                      fontSize: 14,
                      color: PdfColors.black,
                    ),
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 20),

            // Product List
            pw.Text(
              'Products:',
              style: pw.TextStyle(
                fontSize: 18,
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.teal,
              ),
            ),
            pw.SizedBox(height: 10),
            pw.Table.fromTextArray(
              headers: ['Product Name', 'Price', 'Quantity', 'Total'],
              data: Globals.products.map((product) {
                final name = product['name'] ?? 'Unknown Product';
                final price = double.tryParse(product['price'] ?? '0') ?? 0;
                final quantity = int.tryParse(product['qty'] ?? '0') ?? 0;
                final total = price * quantity;
                return [
                  name,
                  price.toStringAsFixed(2),
                  quantity.toString(),
                  total.toStringAsFixed(2),
                ];
              }).toList(),
              border: pw.TableBorder.all(
                color: PdfColors.teal,
                width: 2,
              ),
              headerStyle: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.white,
              ),
              headerDecoration: pw.BoxDecoration(
                color: PdfColors.teal,
              ),
              cellAlignment: pw.Alignment.centerLeft,
              cellStyle: pw.TextStyle(
                fontSize: 12,
                color: PdfColors.black,
              ),
              cellPadding: const pw.EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            ),
            pw.SizedBox(height: 20),

            // Footer
            pw.Container(
              padding: const pw.EdgeInsets.all(10),
              decoration: pw.BoxDecoration(
                color: PdfColors.teal,
                borderRadius: pw.BorderRadius.circular(10),
              ),
              child: pw.Center(
                child: pw.Text(
                  'Thank You For Shopping!',
                  style: pw.TextStyle(
                    fontSize: 16,
                    color: PdfColors.white,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    // 3. Save pdf
    return pdf.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("PDF PAGE")),
      ),
      body: PdfPreview(
        build: (format) async => await getPdf(),
        pdfFileName: "INVOICE_${Globals.name?.toUpperCase() ?? 'UNKNOWN'}",
      ),
    );
  }
}
