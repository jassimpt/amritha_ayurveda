import 'package:amritha_ayurveda/features/modules/register/controller/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomBranchDropdown extends StatelessWidget {
  const CustomBranchDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterController>(
      builder: (context, controller, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Branch',
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
              child: controller.branchListLoader
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
                      value: controller.selectedBranch,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Select the branch',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: controller.branches.map((branch) {
                        return DropdownMenuItem(
                          value: branch,
                          child: Text(branch.name ?? ''),
                        );
                      }).toList(),
                      onChanged: (value) {
                        controller.setSelectedBranch(value);
                      },
                    ),
            ),
          ],
        );
      },
    );
  }
}
