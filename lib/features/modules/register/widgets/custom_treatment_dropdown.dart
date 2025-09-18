import 'package:amritha_ayurveda/core/utils/string_utils.dart';
import 'package:amritha_ayurveda/features/modules/register/controller/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomTreatmentDropdown extends StatelessWidget {
  const CustomTreatmentDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterController>(
      builder: (context, controller, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Treatment',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: controller.treatmentListLoader
                  ? const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.green),
                          ),
                        ),
                      ),
                    )
                  : DropdownButtonFormField(
                      value: controller.selectedTreatment,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Select Treatment',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: controller.treatments.map((treatment) {
                        return DropdownMenuItem(
                          value: treatment,
                          child: Text(StringUtils.truncateForDropdown(
                              treatment.name ?? '')),
                        );
                      }).toList(),
                      onChanged: (value) {
                        controller.setSelectedTreatment(value);
                      },
                    ),
            ),
          ],
        );
      },
    );
  }
}
