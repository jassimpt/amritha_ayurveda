import 'package:amritha_ayurveda/core/utils/enums.dart';
import 'package:amritha_ayurveda/features/modules/register/controller/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentOptionWidgetBuiltIn extends StatelessWidget {
  const PaymentOptionWidgetBuiltIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterController>(
      builder: (context, controller, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Payment Option',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Radio<PaymentOption>(
                        value: PaymentOption.cash,
                        groupValue: controller.selectedPaymentOption,
                        onChanged: (PaymentOption? value) {
                          if (value != null) {
                            controller.setSelectedPaymentOption(value);
                          }
                        },
                        activeColor: const Color.fromRGBO(0, 104, 55, 1),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                      ),
                      Text(
                        'Cash',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: controller.selectedPaymentOption ==
                                  PaymentOption.cash
                              ? const Color.fromRGBO(0, 104, 55, 1)
                              : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Radio<PaymentOption>(
                        value: PaymentOption.card,
                        groupValue: controller.selectedPaymentOption,
                        onChanged: (PaymentOption? value) {
                          if (value != null) {
                            controller.setSelectedPaymentOption(value);
                          }
                        },
                        activeColor: const Color.fromRGBO(0, 104, 55, 1),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                      ),
                      Text(
                        'Card',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: controller.selectedPaymentOption ==
                                  PaymentOption.card
                              ? const Color.fromRGBO(0, 104, 55, 1)
                              : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Radio<PaymentOption>(
                        value: PaymentOption.upi,
                        groupValue: controller.selectedPaymentOption,
                        onChanged: (PaymentOption? value) {
                          if (value != null) {
                            controller.setSelectedPaymentOption(value);
                          }
                        },
                        activeColor: const Color.fromRGBO(0, 104, 55, 1),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                      ),
                      Text(
                        'UPI',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: controller.selectedPaymentOption ==
                                  PaymentOption.upi
                              ? const Color.fromRGBO(0, 104, 55, 1)
                              : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
