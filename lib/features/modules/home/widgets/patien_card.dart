import 'package:amritha_ayurveda/core/utils/date_format_utils.dart';
import 'package:amritha_ayurveda/features/modules/home/model/patient_list_model.dart';
import 'package:flutter/material.dart';

class PatientCard extends StatelessWidget {
  final Patient patient;
  final int index;

  const PatientCard({
    super.key,
    required this.patient,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$index.',
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        patient.name ?? 'N/A',
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        patient.patientdetailsSet != null &&
                                patient.patientdetailsSet!.isNotEmpty
                            ? patient.patientdetailsSet?.first.treatmentName ??
                                "N/A"
                            : "N/A",
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.green[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 16.0,
                  color: Colors.orange[700],
                ),
                const SizedBox(width: 6.0),
                Text(
                  DateFormatUtils.formatToDisplayDate(patient.dateNdTime),
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.orange[700],
                  ),
                ),
                const SizedBox(width: 20.0),
                Icon(
                  Icons.people_outline,
                  size: 16.0,
                  color: Colors.orange[700],
                ),
                const SizedBox(width: 6.0),
                Text(
                  patient.name ?? "N/A",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.orange[700],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'View Booking details',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16.0,
                      color: Colors.green[700],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
