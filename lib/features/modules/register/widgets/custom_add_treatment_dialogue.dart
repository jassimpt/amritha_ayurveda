import 'package:amritha_ayurveda/core/utils/custom_snackbar.dart';
import 'package:amritha_ayurveda/core/utils/enums.dart';
import 'package:amritha_ayurveda/features/modules/register/controller/register_controller.dart';
import 'package:amritha_ayurveda/features/modules/register/models/patient_treatment_create_model.dart';
import 'package:amritha_ayurveda/features/modules/register/widgets/custom_treatment_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTreatmentDialog extends StatefulWidget {
  final PatientTreatmentCreateModel? existingTreatment;
  final int? editIndex;

  const AddTreatmentDialog({
    Key? key,
    this.existingTreatment,
    this.editIndex,
  }) : super(key: key);

  @override
  State<AddTreatmentDialog> createState() => _AddTreatmentDialogState();
}

class _AddTreatmentDialogState extends State<AddTreatmentDialog> {
  int maleCount = 0;
  int femaleCount = 0;
  bool isEditMode = false;

  @override
  void initState() {
    super.initState();

    if (widget.existingTreatment != null) {
      isEditMode = true;
      maleCount = widget.existingTreatment!.male ?? 0;
      femaleCount = widget.existingTreatment!.female ?? 0;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        final controller =
            Provider.of<RegisterController>(context, listen: false);
        controller
            .setSelectedTreatment(widget.existingTreatment!.selectedTreatment);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterController>(
      builder: (context, controller, child) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTreatmentDropdown(),
                const SizedBox(height: 24),
                const Text(
                  'Add Patients',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                _buildPatientCounterRow(
                  label: 'Male',
                  count: maleCount,
                  onIncrement: () {
                    setState(() {
                      maleCount++;
                    });
                  },
                  onDecrement: () {
                    setState(() {
                      if (maleCount > 0) maleCount--;
                    });
                  },
                ),
                const SizedBox(height: 16),
                _buildPatientCounterRow(
                  label: 'Female',
                  count: femaleCount,
                  onIncrement: () {
                    setState(() {
                      femaleCount++;
                    });
                  },
                  onDecrement: () {
                    setState(() {
                      if (femaleCount > 0) femaleCount--;
                    });
                  },
                ),
                const SizedBox(height: 24),
                Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      _saveTreatment(controller);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(0, 104, 55, 1),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      isEditMode ? 'Update' : 'Save',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPatientCounterRow({
    required String label,
    required int count,
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
  }) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            height: 45,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Center(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(0, 104, 55, 1),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: onDecrement,
            icon: const Icon(
              Icons.remove,
              color: Colors.white,
              size: 20,
            ),
            padding: EdgeInsets.zero,
          ),
        ),
        const SizedBox(width: 12),
        Container(
          width: 50,
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              count.toString(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(0, 104, 55, 1),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: onIncrement,
            icon: const Icon(
              Icons.add,
              color: Colors.white,
              size: 20,
            ),
            padding: EdgeInsets.zero,
          ),
        ),
      ],
    );
  }

  void _saveTreatment(RegisterController controller) {
    if (controller.selectedTreatment == null) {
      showCustomSnackBar(
        context: context,
        type: SnackBarType.error,
        content: 'Please select a treatment',
      );

      return;
    }

    if (maleCount == 0 && femaleCount == 0) {
      showCustomSnackBar(
        context: context,
        type: SnackBarType.error,
        content: 'Please add at least one patient',
      );
      return;
    }

    final patientTreatment = PatientTreatmentCreateModel(
      male: maleCount,
      female: femaleCount,
      selectedTreatment: controller.selectedTreatment,
    );

    if (isEditMode && widget.editIndex != null) {
      controller.updatePatientTreatment(widget.editIndex!, patientTreatment);

      showCustomSnackBar(
        context: context,
        type: SnackBarType.success,
        content: 'Treatment updated successfully',
      );
    } else {
      controller.addPatientTreatment(patientTreatment);

      showCustomSnackBar(
        context: context,
        type: SnackBarType.success,
        content: 'Treatment added successfully',
      );
    }

    controller.setSelectedTreatment(null);

    Navigator.of(context).pop();
  }
}
