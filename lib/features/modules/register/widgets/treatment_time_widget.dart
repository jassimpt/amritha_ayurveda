import 'package:amritha_ayurveda/features/modules/register/controller/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TreatmentTimeWidget extends StatelessWidget {
  const TreatmentTimeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterController>(
      builder: (context, controller, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Treatment Time',
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
                  child: _buildTimeDropdown(
                    context: context,
                    controller: controller,
                    items: controller.hours,
                    selectedValue: controller.selectedHour,
                    hint: 'Hour',
                    onChanged: (String? value) {
                      controller.setSelectedHour(value);
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildTimeDropdown(
                    context: context,
                    controller: controller,
                    items: controller.allMinutes,
                    selectedValue: controller.selectedMinute,
                    hint: 'Minutes',
                    onChanged: (String? value) {
                      controller.setSelectedMinute(value);
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildTimeDropdown({
    required BuildContext context,
    required RegisterController controller,
    required List<String> items,
    required String? selectedValue,
    required String hint,
    required void Function(String?) onChanged,
  }) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          hint: Text(
            hint,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.grey.shade600,
            ),
          ),
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: Color.fromRGBO(0, 104, 55, 1),
            size: 24,
          ),
          isExpanded: true,
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
          dropdownColor: Colors.white,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
