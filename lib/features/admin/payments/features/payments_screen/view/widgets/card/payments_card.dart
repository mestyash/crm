import 'package:crm/core/domain/entity/payment/payment_model.dart';
import 'package:crm/core/presentation/ui/custom_cupertino_dialog/custom_cupertino_dialog.dart';
import 'package:crm/core/presentation/ui/delete_icon/delete_icon.dart';
import 'package:crm/core/styles/project_theme.dart';
import 'package:crm/features/admin/payments/features/payments_screen/bloc/payments_bloc.dart';
import 'package:crm/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentsCard extends StatelessWidget {
  final PaymentModel payment;

  const PaymentsCard({
    super.key,
    required this.payment,
  });

  void _deleteDialog(BuildContext context) {
    final _l10n = context.l10n;
    CustomCupertinoDialog(
      context: context,
      title: _l10n.paymentsScreenDeletePayment,
      content: _l10n.paymentsScreenDeletePaymentConfirm,
      firstActionText: _l10n.cancel,
      firstAction: () => Navigator.pop(context),
      secondActionText: _l10n.delete,
      secondAction: () {
        context.read<PaymentsBloc>().add(PaymentsEventDelete(id: payment.id));
      },
    );
  }

  void _createPdfDialog(BuildContext context) {
    final _l10n = context.l10n;
    CustomCupertinoDialog(
      context: context,
      title: _l10n.paymentsScreenCreatePdf,
      content: _l10n.paymentsScreenCreatePdfConfirm,
      firstActionText: _l10n.cancel,
      firstAction: () => Navigator.pop(context),
      secondActionText: _l10n.create,
      isRedSecondAction: false,
      secondAction: () {
        context.read<PaymentsBloc>().add(PaymentsEventPdf(data: payment));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 5.r),
      margin: EdgeInsets.only(bottom: 15.h),
      decoration: BoxDecoration(
        color: _theme.cardColor,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: ProjectShadow.boxShadow1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                payment.student.fullName1,
                style: _textTheme.displaySmall,
              ),
              Spacer(),
              SizedBox(width: 5.w),
              Visibility(
                visible: !payment.hasPdf,
                child: DeleteIcon(action: () => _deleteDialog(context)),
              ),
              SizedBox(width: 10.w),
              GestureDetector(
                onTap: () => _createPdfDialog(context),
                child: Icon(
                  Icons.picture_as_pdf_rounded,
                  size: 20.r,
                ),
              )
            ],
          ),
          SizedBox(height: 10.h),
          Text(
            '${payment.sum} ₽',
            style: _textTheme.titleSmall,
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              RichText(
                maxLines: 1,
                overflow: TextOverflow.fade,
                softWrap: false,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Дата:  ',
                      style: _textTheme.bodyLarge
                          ?.copyWith(fontStyle: FontStyle.italic),
                    ),
                    TextSpan(
                      text: payment.stringCreatedAt,
                      style: _textTheme.bodyLarge?.copyWith(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Text(
                payment.stringPaymentMonth,
                style: _textTheme.bodyLarge,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
