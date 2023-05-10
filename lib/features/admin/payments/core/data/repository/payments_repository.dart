import 'dart:io';
import 'package:crm/core/api/payments/payments_supabase.dart';
import 'package:crm/core/api/students/students_supabase.dart';
import 'package:crm/core/data/dto/payment/payment_mapper.dart';
import 'package:crm/core/data/dto/user/user_mapper.dart';
import 'package:crm/core/domain/entity/payment/payment_model.dart';
import 'package:crm/core/domain/entity/user/user_model.dart';
import 'package:crm/core/utils/date/date_utils.dart';
import 'package:crm/features/admin/payments/core/domain/payments_usecase.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter/services.dart' show rootBundle;

class PaymentsRepository extends IPaymentsRepository {
  final StudentsSupabase _studentsSupabase;
  final PaymentsSupabase _paymentsSupabase;

  PaymentsRepository({
    required StudentsSupabase studentsSupabase,
    required PaymentsSupabase paymentsSupabase,
  })  : _studentsSupabase = studentsSupabase,
        _paymentsSupabase = paymentsSupabase;

  @override
  Future<List<PaymentModel>> getPaymentsByRange(
    GetPaymentsByRangeParams params,
  ) async {
    try {
      final List<dynamic> payments;
      if (params.studentId == null) {
        final response = await _paymentsSupabase.getPaymentsByRange(
          startDate: CustomDateUtils.prepareDateForBackend(params.startDate),
          endDate: CustomDateUtils.prepareDateForBackend(params.endDate),
        );
        payments = response['payload']['payments'] as List<dynamic>;
      } else {
        final response = await _paymentsSupabase.getStudentPaymentsByRange(
          startDate: CustomDateUtils.prepareDateForBackend(params.startDate),
          endDate: CustomDateUtils.prepareDateForBackend(params.endDate),
          id: params.studentId!,
        );
        payments = response['payload']['payments'] as List<dynamic>;
      }
      return payments.map((e) => mapPayment(e)).toList();
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  @override
  Future<List<UserModel>> searchStudents({required String surname}) async {
    try {
      final response = await _studentsSupabase.searchStudentsBySurname(surname);
      final students = response['payload']['students'] as List<dynamic>;
      return students.map((e) => mapUser(e)).toList();
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  @override
  Future<void> uploadPayment(UploadPaymentParams params) async {
    try {
      await _paymentsSupabase.createPayment(
        ApiPaymentModel(
            studentId: params.userId,
            sum: params.sum,
            paymentMonth: CustomDateUtils.prepareDateForBackend(params.date),
            createdAt: CustomDateUtils.prepareDateForBackend(DateTime.now())),
      );
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  @override
  Future<void> deletePayment({required int id}) async {
    try {
      await _paymentsSupabase.deletePayment(id: id);
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  @override
  Future<void> setPdfStatus({required int id}) async {
    try {
      await _paymentsSupabase.setPdfStatus(id: id);
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  @override
  Future<void> createPdf({required PaymentModel data}) async {
    try {
      final nowDate = DateTime.now();

      final robotoFont = await PdfGoogleFonts.robotoRegular();
      final robotoBoldFont = await PdfGoogleFonts.robotoBold();

      final print = pw.SvgImage(
        svg: await rootBundle.loadString('assets/print.svg'),
        height: 125,
        width: 125,
      );

      final style = pw.TextStyle(font: robotoFont);
      final boldStyle = pw.TextStyle(font: robotoBoldFont);
      final h1Text = style.copyWith(fontSize: 12.5);
      final h2Text = style.copyWith(fontSize: 11.25);
      final bodyText = style.copyWith(fontSize: 10);

      final pdf = pw.Document();
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4.copyWith(
            marginBottom: 0,
            marginLeft: 0,
            marginRight: 0,
            marginTop: 0,
          ),
          build: (pw.Context context) {
            return pw.Container(
              width: 400,
              padding: pw.EdgeInsets.symmetric(horizontal: 15, vertical: 17.5),
              child: pw.Stack(
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text('ООО ОБРАЗОВАТЕЛЬНЫЙ ЦЕНТР',
                                  style: h1Text),
                              pw.SizedBox(height: 1.5),
                              pw.Text('"РОСТОК"', style: h1Text),
                            ],
                          ),
                          pw.Spacer(),
                          pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text('Серия: ББ', style: bodyText),
                              pw.SizedBox(height: 1.5),
                              pw.Text('ОГРН: 1229200003889', style: bodyText),
                              pw.SizedBox(height: 1.5),
                              pw.Text('ИНН: 9200011824', style: bodyText),
                            ],
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 22.5),
                      pw.RichText(
                        text: pw.TextSpan(
                          children: [
                            pw.TextSpan(
                              text: 'КВИТАНЦИЯ № ',
                              style: h2Text,
                            ),
                            pw.TextSpan(
                              text: '${data.id}',
                              style: boldStyle.copyWith(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                      pw.SizedBox(height: 10),
                      _underlineRow(
                        bodyText,
                        boldStyle.copyWith(fontSize: 11.25),
                        title: 'Учреждение',
                        text: 'ООО ОБРАЗОВАТЕЛЬНЫЙ ЦЕНТР "РОСТОК"',
                      ),
                      _underlineRow(
                        bodyText,
                        h2Text,
                        title: 'Принято от',
                        text: data.student.fullName1.toUpperCase(),
                      ),
                      _underlineRow(
                        bodyText,
                        h2Text,
                        title: 'Сумма, всего',
                        text: data.sum.toString() + ' ₽',
                      ),
                      pw.SizedBox(height: 5),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.end,
                        children: [
                          pw.Text('"', style: h1Text),
                          _underlineText(
                            h2Text,
                            text: '  ' + nowDate.day.toString() + '  ',
                          ),
                          pw.Text('" ', style: h1Text),
                          _underlineText(
                            h2Text,
                            text: '  ' +
                                DateFormat('MMMM').format(nowDate) +
                                '  ',
                          ),
                          pw.Text(
                            ' ' + nowDate.year.toString() + ' г.',
                            style: boldStyle.copyWith(fontSize: 11.25),
                          ),
                        ],
                      ),
                    ],
                  ),
                  pw.Positioned(
                    top: 120,
                    left: 115,
                    child: print,
                  ),
                ],
              ),
            );
          },
        ),
      );

      final appStorage = await getApplicationDocumentsDirectory();
      final path =
          '${appStorage.path}/${DateTime.now().millisecondsSinceEpoch.toString()}.pdf';
      final file = File(path);
      await file.writeAsBytes(await pdf.save());
      await OpenFilex.open(path);
      await file.delete();
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }
}

pw.Padding _underlineRow(
  pw.TextStyle bodyText,
  pw.TextStyle h2Text, {
  required String title,
  required String text,
}) {
  return pw.Padding(
    padding: pw.EdgeInsets.only(bottom: 5),
    child: pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Text(
          '$title ',
          style: bodyText,
        ),
        pw.SizedBox(width: 5),
        pw.Expanded(
          child: _underlineText(h2Text, text: text),
        ),
      ],
    ),
  );
}

pw.Container _underlineText(pw.TextStyle style, {required String text}) {
  return pw.Container(
    padding: pw.EdgeInsets.only(bottom: 1),
    decoration: pw.BoxDecoration(
      border: pw.Border(
        bottom: pw.BorderSide(
          color: PdfColor.fromHex('#000000'),
          width: 1.0, // Underline thickness
        ),
      ),
    ),
    child: pw.Text(
      text,
      style: style,
    ),
  );
}
