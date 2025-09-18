import 'package:amritha_ayurveda/features/modules/home/controller/home_controller.dart';
import 'package:amritha_ayurveda/features/modules/home/widgets/custom_app_bar.dart';
import 'package:amritha_ayurveda/features/modules/home/widgets/empty_state.dart';
import 'package:amritha_ayurveda/features/modules/home/widgets/loading_state.dart';
import 'package:amritha_ayurveda/features/modules/home/widgets/patien_card.dart';
import 'package:amritha_ayurveda/features/modules/home/widgets/register_button.dart';
import 'package:amritha_ayurveda/features/modules/home/widgets/search_section.dart';
import 'package:amritha_ayurveda/features/modules/home/widgets/sort_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _initializePatientData();
  }

  _initializePatientData() async {
    final pro = context.read<HomeController>();
    await pro.getPatientsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: const CustomAppBar(),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: Column(
          children: [
            const SearchSection(),
            const SortSection(),
            Expanded(child: Consumer<HomeController>(
              builder: (context, controller, child) {
                if (controller.patientListLoader) {
                  return const LoadingState();
                }

                if (controller.patients.isEmpty) {
                  return const EmptyState();
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: controller.patients.length,
                  itemBuilder: (context, index) {
                    return PatientCard(
                      patient: controller.patients[index],
                      index: index + 1,
                    );
                  },
                );
              },
            )),
            RegisterButton(
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _refreshData() async {
    final pro = context.read<HomeController>();
    await pro.getPatientsData();
  }
}
