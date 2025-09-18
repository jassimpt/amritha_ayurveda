import 'package:amritha_ayurveda/core/utils/custom_snackbar.dart';
import 'package:amritha_ayurveda/core/utils/enums.dart';
import 'package:amritha_ayurveda/core/utils/field_validation_utils.dart';
import 'package:amritha_ayurveda/core/utils/loader_utils.dart';
import 'package:amritha_ayurveda/features/modules/auth/widgets/custom_universal_textfield.dart';
import 'package:amritha_ayurveda/features/modules/home/controller/home_controller.dart';
import 'package:amritha_ayurveda/features/modules/register/controller/register_controller.dart';
import 'package:amritha_ayurveda/features/modules/register/models/patient_treatment_create_model.dart';
import 'package:amritha_ayurveda/features/modules/register/widgets/custom_add_treatment_dialogue.dart';
import 'package:amritha_ayurveda/features/modules/register/widgets/custom_branch_dropdown.dart';
import 'package:amritha_ayurveda/features/modules/register/widgets/custom_patient_treatment_card.dart';
import 'package:amritha_ayurveda/features/modules/register/widgets/custom_save_button.dart';
import 'package:amritha_ayurveda/features/modules/register/widgets/payment_option_widget.dart';
import 'package:amritha_ayurveda/features/modules/register/widgets/treatment_date_picker.dart';
import 'package:amritha_ayurveda/features/modules/register/widgets/treatment_time_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController whatsappController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController totalAmountController = TextEditingController();
  final TextEditingController discountAmountController =
      TextEditingController();
  final TextEditingController advanceAmountController = TextEditingController();
  final TextEditingController balanceAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  _initializeData() async {
    final pro = context.read<RegisterController>();

    pro.clearAll();
    await Future.wait<dynamic>([
      pro.getBranchData(),
      pro.getTreatmentList(),
    ]);
  }

  @override
  void dispose() {
    nameController.dispose();
    whatsappController.dispose();
    addressController.dispose();
    totalAmountController.dispose();
    discountAmountController.dispose();
    advanceAmountController.dispose();
    balanceAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Register',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 24),
            CustomUniversalTextfield(
              label: 'Name',
              controller: nameController,
              hintText: 'Enter your full name',
            ),
            const SizedBox(height: 20),
            CustomUniversalTextfield(
              label: 'Whatsapp Number',
              controller: whatsappController,
              hintText: 'Enter your Whatsapp number',
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            CustomUniversalTextfield(
              label: 'Address',
              controller: addressController,
              hintText: 'Enter your full address',
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            const Text(
              'Location',
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
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Choose your location',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                icon: const Icon(Icons.keyboard_arrow_down),
                items: const [
                  DropdownMenuItem(
                    value: 'location1',
                    child: Text('Location 1'),
                  ),
                  DropdownMenuItem(
                    value: 'location2',
                    child: Text('Location 2'),
                  ),
                ],
                onChanged: (value) {},
              ),
            ),
            const SizedBox(height: 20),
            const CustomBranchDropdown(),
            const SizedBox(height: 20),
            const Text(
              'Treatments',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            Consumer<RegisterController>(
              builder: (context, registerPro, child) => ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: registerPro.patientTreatmentList.length,
                itemBuilder: (context, index) {
                  PatientTreatmentCreateModel treatmentData =
                      registerPro.patientTreatmentList[index];
                  return CustomPatientTreatmentCard(
                    treatmentData: treatmentData,
                    index: index,
                  );
                },
              ),
            ),
            CustomSaveButton(
              buttnLabel: '+ Add Treatment',
              onPressed: () {
                _showAddTreatmentDialog(context);
              },
            ),
            const SizedBox(height: 20),
            CustomUniversalTextfield(
              label: 'Total Amount',
              controller: totalAmountController,
              hintText: 'Enter total amount',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            CustomUniversalTextfield(
              label: 'Discount Amount',
              controller: discountAmountController,
              hintText: 'Enter discount amount',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            const PaymentOptionWidgetBuiltIn(),
            const SizedBox(height: 20),
            CustomUniversalTextfield(
              label: 'Advance Amount',
              controller: advanceAmountController,
              hintText: 'Enter advance amount',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            CustomUniversalTextfield(
              label: 'Balance Amount',
              controller: balanceAmountController,
              hintText: 'Enter balance amount',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            const TreatmentDatePicker(),
            const SizedBox(height: 20),
            const TreatmentTimeWidget(),
            const SizedBox(height: 20),
            Consumer<RegisterController>(
              builder: (context, registerPro, child) => CustomSaveButton(
                buttnLabel: "Save",
                onPressed: registerPro.appointmentLoader
                    ? null
                    : () => _handleSaveAppointment(),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  void _showAddTreatmentDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return const AddTreatmentDialog();
      },
    );
  }

  Future<void> _handleSaveAppointment() async {
    final registerController = context.read<RegisterController>();
    final homeController = context.read<HomeController>();

    if (!FieldValidationUtils.validateFields(
      context: context,
      nameController: nameController,
      whatsappController: whatsappController,
      addressController: addressController,
      totalAmountController: totalAmountController,
    )) {
      return;
    }

    try {
      LoaderUtils.showLoader(context: context);

      bool success = await registerController.createAppointment(
        name: nameController.text.trim(),
        phone: whatsappController.text.trim(),
        address: addressController.text.trim(),
        totalAmount: totalAmountController.text.trim(),
        discountAmount: discountAmountController.text.trim(),
        advanceAmount: advanceAmountController.text.trim(),
        balanceAmount: balanceAmountController.text.trim(),
      );

      LoaderUtils.hideLoader(context);

      if (success) {
        LoaderUtils.showLoader(context: context);
        await homeController.getPatientsData();
        showCustomSnackBar(
          context: context,
          type: SnackBarType.success,
          content: 'Appointment created successfully',
        );
        LoaderUtils.hideLoader(context);
        Navigator.pop(context);
      } else {
        showCustomSnackBar(
          context: context,
          type: SnackBarType.error,
          content: 'Failed to create appointment. Please try again.',
        );
      }
    } catch (e) {
      LoaderUtils.hideLoader(context);

      showCustomSnackBar(
        context: context,
        type: SnackBarType.error,
        content: 'An error occurred. Please try again.',
      );
    }
  }
}
