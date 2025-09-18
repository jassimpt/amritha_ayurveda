import 'dart:io';
import 'dart:typed_data';
import 'package:amritha_ayurveda/features/modules/register/models/branch_list_model.dart';
import 'package:flutter/services.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:amritha_ayurveda/core/constants/image_constants.dart';
import 'package:amritha_ayurveda/features/modules/register/models/patient_treatment_create_model.dart';

class PdfService {
  static Future<void> generateAndOpenAppointmentPdf({
    required String patientName,
    required String address,
    required String whatsappNumber,
    required String bookedOn,
    Branch? selectedbranch,
    required String treatmentDate,
    required String treatmentTime,
    required List<PatientTreatmentCreateModel> treatments,
    required double totalAmount,
    required double discountAmount,
    required double advanceAmount,
    required double balanceAmount,
  }) async {
    try {
      final pdf = pw.Document();

      final logoSmall = await _loadImage(ImageConstants.logoSmall);
      final logoBig = await _loadImage(ImageConstants.logoBig);
      final pdfSignature = await _loadImage(ImageConstants.pdfSignature);

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(20),
          build: (pw.Context context) {
            return pw.Stack(
              children: [
                pw.Positioned(
                  top: 200,
                  left: 50,
                  right: 50,
                  child: pw.Opacity(
                    opacity: 0.1,
                    child: pw.Center(
                      child: pw.Image(
                        logoBig,
                        width: 300,
                        height: 300,
                      ),
                    ),
                  ),
                ),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    _buildHeader(logoSmall, selectedbranch),
                    pw.SizedBox(height: 30),
                    _buildPatientDetailsSection(
                      patientName: patientName,
                      address: address,
                      whatsappNumber: whatsappNumber,
                      bookedOn: bookedOn,
                      treatmentDate: treatmentDate,
                      treatmentTime: treatmentTime,
                    ),
                    pw.SizedBox(height: 30),
                    _buildTreatmentTable(
                      treatments,
                    ),
                    pw.SizedBox(height: 20),
                    _buildAmountSummary(
                      totalAmount: totalAmount,
                      discountAmount: discountAmount,
                      advanceAmount: advanceAmount,
                      balanceAmount: balanceAmount,
                    ),
                    pw.Spacer(),
                    _buildFooter(
                      pdfSignature,
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      );

      await _saveAndOpenPdf(pdf);
    } catch (e) {
      print('Error generating PDF: $e');
      throw Exception('Failed to generate PDF: $e');
    }
  }

  static pw.Widget _buildHeader(pw.ImageProvider logoSmall, Branch? branch) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Image(
          logoSmall,
          width: 80,
          height: 80,
        ),
        pw.Spacer(),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Text(
              branch?.location ?? "".toUpperCase(),
              style: pw.TextStyle(
                fontSize: 18,
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.black,
              ),
            ),
            pw.SizedBox(height: 5),
            pw.Text(
              branch?.address ?? "",
              style: const pw.TextStyle(
                fontSize: 10,
                color: PdfColors.grey700,
              ),
            ),
            pw.SizedBox(height: 3),
            pw.Text(
              'e-mail: ${branch?.mail}',
              style: const pw.TextStyle(
                fontSize: 10,
                color: PdfColors.grey700,
              ),
            ),
            pw.SizedBox(height: 3),
            pw.Text(
              'Mob: +91 ${branch?.phone}',
              style: const pw.TextStyle(
                fontSize: 10,
                color: PdfColors.grey700,
              ),
            ),
            pw.SizedBox(height: 3),
            pw.Text(
              'GST No: ${branch?.gst}',
              style: pw.TextStyle(
                fontSize: 10,
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }

  static pw.Widget _buildPatientDetailsSection({
    required String patientName,
    required String address,
    required String whatsappNumber,
    required String bookedOn,
    required String treatmentDate,
    required String treatmentTime,
  }) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Patient Details',
          style: pw.TextStyle(
            fontSize: 16,
            fontWeight: pw.FontWeight.bold,
            color: PdfColor.fromHex('#00A651'),
          ),
        ),
        pw.SizedBox(height: 15),
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Expanded(
              flex: 1,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  _buildDetailRow(
                    'Name',
                    patientName,
                  ),
                  pw.SizedBox(height: 8),
                  _buildDetailRow(
                    'Address',
                    address,
                  ),
                  pw.SizedBox(height: 8),
                  _buildDetailRow(
                    'WhatsApp Number',
                    whatsappNumber,
                  ),
                ],
              ),
            ),
            pw.SizedBox(width: 40),
            pw.Expanded(
              flex: 1,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  _buildDetailRow(
                    'Booked On',
                    bookedOn,
                  ),
                  pw.SizedBox(height: 8),
                  _buildDetailRow(
                    'Treatment Date',
                    treatmentDate,
                  ),
                  pw.SizedBox(height: 8),
                  _buildDetailRow(
                    'Treatment Time',
                    treatmentTime,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  static pw.Widget _buildDetailRow(
    String label,
    String value,
  ) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(
          width: 100,
          child: pw.Text(
            label,
            style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.black,
            ),
          ),
        ),
        pw.Expanded(
          child: pw.Text(
            value,
            style: const pw.TextStyle(
              fontSize: 12,
              color: PdfColors.grey700,
            ),
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildTreatmentTable(
      List<PatientTreatmentCreateModel> treatments) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // Table header
        pw.Container(
          padding: const pw.EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          decoration: pw.BoxDecoration(
            color: PdfColor.fromHex('#F5F5F5'),
            border: pw.Border.all(color: PdfColors.grey400),
          ),
          child: pw.Row(
            children: [
              pw.Expanded(
                flex: 3,
                child: pw.Text(
                  'Treatment',
                  style: pw.TextStyle(
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColor.fromHex('#00A651'),
                  ),
                ),
              ),
              pw.Expanded(
                flex: 1,
                child: pw.Center(
                  child: pw.Text(
                    'Price',
                    style: pw.TextStyle(
                      fontSize: 12,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColor.fromHex('#00A651'),
                    ),
                  ),
                ),
              ),
              pw.Expanded(
                flex: 1,
                child: pw.Center(
                  child: pw.Text(
                    'Male',
                    style: pw.TextStyle(
                      fontSize: 12,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColor.fromHex('#00A651'),
                    ),
                  ),
                ),
              ),
              pw.Expanded(
                flex: 1,
                child: pw.Center(
                  child: pw.Text(
                    'Female',
                    style: pw.TextStyle(
                      fontSize: 12,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColor.fromHex('#00A651'),
                    ),
                  ),
                ),
              ),
              pw.Expanded(
                flex: 1,
                child: pw.Center(
                  child: pw.Text(
                    'Total',
                    style: pw.TextStyle(
                      fontSize: 12,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColor.fromHex('#00A651'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        ...treatments.map((treatment) {
          int maleCount = treatment.male ?? 0;
          int femaleCount = treatment.female ?? 0;
          double price =
              double.tryParse(treatment.selectedTreatment?.price ?? '0') ?? 0;
          double total = price * (maleCount + femaleCount);

          return pw.Container(
            padding: const pw.EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.grey400),
            ),
            child: pw.Row(
              children: [
                pw.Expanded(
                  flex: 3,
                  child: pw.Text(
                    treatment.selectedTreatment?.name ?? '',
                    style: const pw.TextStyle(
                      fontSize: 11,
                      color: PdfColors.grey700,
                    ),
                  ),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Center(
                    child: pw.Text(
                      price.toStringAsFixed(0),
                      style: const pw.TextStyle(
                        fontSize: 11,
                        color: PdfColors.grey700,
                      ),
                    ),
                  ),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Center(
                    child: pw.Text(
                      maleCount.toString(),
                      style: const pw.TextStyle(
                        fontSize: 11,
                        color: PdfColors.grey700,
                      ),
                    ),
                  ),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Center(
                    child: pw.Text(
                      femaleCount.toString(),
                      style: const pw.TextStyle(
                        fontSize: 11,
                        color: PdfColors.grey700,
                      ),
                    ),
                  ),
                ),
                pw.Expanded(
                  flex: 1,
                  child: pw.Center(
                    child: pw.Text(
                      total.toStringAsFixed(0),
                      style: const pw.TextStyle(
                        fontSize: 11,
                        color: PdfColors.grey700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  static pw.Widget _buildAmountSummary({
    required double totalAmount,
    required double discountAmount,
    required double advanceAmount,
    required double balanceAmount,
    pw.Font? customFont,
  }) {
    return pw.Column(
      children: [
        pw.Align(
          alignment: pw.Alignment.centerRight,
          child: pw.Container(
            width: 200,
            child: pw.Column(
              children: [
                _buildAmountRow(
                  'Total Amount',
                  totalAmount.toStringAsFixed(0),
                ),
                _buildAmountRow(
                  'Discount',
                  discountAmount.toStringAsFixed(0),
                ),
                _buildAmountRow(
                  'Advance',
                  advanceAmount.toStringAsFixed(0),
                ),
                pw.Divider(color: PdfColors.grey400),
                _buildAmountRow('Balance', balanceAmount.toStringAsFixed(0),
                    isTotal: true),
              ],
            ),
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildAmountRow(String label, String amount,
      {bool isTotal = false}) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(vertical: 4),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            label,
            style: pw.TextStyle(
              fontSize: isTotal ? 14 : 12,
              fontWeight: isTotal ? pw.FontWeight.bold : pw.FontWeight.normal,
              color: isTotal ? PdfColors.black : PdfColors.grey700,
            ),
          ),
          pw.Text(
            amount,
            style: pw.TextStyle(
              fontSize: isTotal ? 14 : 12,
              fontWeight: isTotal ? pw.FontWeight.bold : pw.FontWeight.normal,
              color: isTotal ? PdfColors.black : PdfColors.grey700,
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildFooter(
    pw.ImageProvider pdfSignature,
  ) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        pw.Text(
          'Thank you for choosing us',
          style: pw.TextStyle(
            fontSize: 16,
            fontWeight: pw.FontWeight.bold,
            color: PdfColor.fromHex('#00A651'),
          ),
        ),
        pw.SizedBox(height: 8),
        pw.Text(
          'Your well-being is our commitment, and we\'re honored\nyou\'ve entrusted us with your health journey',
          style: const pw.TextStyle(
            fontSize: 11,
            color: PdfColors.grey600,
          ),
          textAlign: pw.TextAlign.center,
        ),
        pw.SizedBox(height: 20),
        pw.Align(
          alignment: pw.Alignment.centerRight,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              pw.Image(
                pdfSignature,
                width: 100,
                height: 50,
              ),
            ],
          ),
        ),
        pw.SizedBox(height: 20),
        pw.Container(
          padding: const pw.EdgeInsets.symmetric(vertical: 8),
          decoration: const pw.BoxDecoration(
            border: pw.Border(
              top: pw.BorderSide(color: PdfColors.grey400),
            ),
          ),
          child: pw.Text(
            '"Booking amount is non-refundable, and it\'s important to arrive on the allotted time for your treatment"',
            style: pw.TextStyle(
              fontSize: 10,
              color: PdfColors.grey600,
              fontStyle: pw.FontStyle.italic,
            ),
            textAlign: pw.TextAlign.center,
          ),
        ),
      ],
    );
  }

  static Future<pw.ImageProvider> _loadImage(String imagePath) async {
    final byteData = await rootBundle.load(imagePath);
    final uint8List = byteData.buffer.asUint8List();
    return pw.MemoryImage(uint8List);
  }

  static Future<void> _saveAndOpenPdf(pw.Document pdf) async {
    try {
      final output = await getTemporaryDirectory();
      final file = File(
          '${output.path}/appointment_${DateTime.now().millisecondsSinceEpoch}.pdf');
      await file.writeAsBytes(await pdf.save());

      await OpenFilex.open(file.path);
    } catch (e) {
      print('Error saving/opening PDF: $e');
      throw Exception('Failed to save/open PDF: $e');
    }
  }
}
