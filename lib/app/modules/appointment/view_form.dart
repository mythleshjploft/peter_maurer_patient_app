import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peter_maurer_patients_app/app/controllers/appointment_controller.dart';
import 'package:peter_maurer_patients_app/app/custom_widget/custom_appbar.dart';
import 'package:peter_maurer_patients_app/app/models/appointment_screen/patient_form_response.dart';
import 'package:peter_maurer_patients_app/app/services/utils/base_functions.dart';

class ViewFormScreen extends StatefulWidget {
  const ViewFormScreen({super.key, required this.appointmentId});
  final String appointmentId;
  @override
  State<ViewFormScreen> createState() => _ViewFormScreenState();
}

class _ViewFormScreenState extends State<ViewFormScreen> {
  AppointmentController controller = Get.find<AppointmentController>();
  @override
  void initState() {
    super.initState();
    controller.patientFormData.value = PatientFormData();
    controller.getPatientFormData(
      appointmentId: widget.appointmentId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Patient Form".tr),
      backgroundColor: Colors.white,
      body: Obx(() {
        if (controller.isFormLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if ((controller.patientFormData.value.id?.toString() ?? "") == "") {
          return const Center(
            child: Text(
              "No Data Found",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          );
        }
        PatientFormData data = controller.patientFormData.value;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              buildDetailWidget(
                  title: "First Name", value: data.firstName?.toString() ?? ""),
              buildDetailWidget(
                  title: "Last Name", value: data.lastName?.toString() ?? ""),
              buildDetailWidget(
                  title: "Email ID", value: data.email?.toString() ?? ""),
              buildDetailWidget(
                  title: "DOB",
                  value: formatBackendDate(data.dob?.toString() ?? "")),
              buildDetailWidget(
                  title: "Place of Birth",
                  value: data.placeOfBirth?.toString() ?? ""),
              buildDetailWidget(
                  title: "Occupation",
                  value: data.occupation?.toString() ?? ""),
              buildDetailWidget(
                  title: "Gender", value: data.gender?.toString() ?? ""),
              buildDetailWidget(
                  title: "Country",
                  value: data.countryId?.name?.toString() ?? ""),
              buildDetailWidget(
                  title: "City", value: data.cityId?.name?.toString() ?? ""),
              buildDetailWidget(
                  title: "Zip Code", value: data.zipCode?.toString() ?? ""),
              buildDetailWidget(
                  title: "Street, No.", value: data.streetNo?.toString() ?? ""),
              buildDetailWidget(
                  title: "Which doctor referred you to us?",
                  value: data.whichDoctorReferredYouToUs?.toString() ?? ""),
              buildDetailWidget(
                  title: "Reason for today's visit",
                  value: data.reasonForTodayVisit?.toString() ?? ""),
              buildDetailWidget(
                  title: "General Practitioner (with City)",
                  value: data.generalPractitioner?.toString() ?? ""),
              buildDetailWidget(
                  title: "Dentist (with City)",
                  value: data.dentistWithCity?.toString() ?? ""),
              buildDetailWidget(
                  title: "Height (in cm)",
                  value: data.height?.toString() ?? ""),
              buildDetailWidget(
                  title: "Weight (in kg)",
                  value: data.weight?.toString() ?? ""),
              buildDetailWidget(
                  title: "Health Insurance (Name)",
                  value: data.healthInsuranceName?.toString() ?? ""),
              buildDetailWidget(
                  title: "Insurance Type",
                  value: (data.insuranceType ?? []).join(", ")),
              buildDetailWidget(
                  title: "Are you in good health?",
                  isTrue: (data.goodHealth?.toString() ?? "false") == "true"),
              buildDetailWidget(
                  title: "Are you currently under medical treatment?",
                  isTrue:
                      (data.medicalTreatment?.toString() ?? "false") == "true"),
              buildDetailWidget(
                  title:
                      "Have you had any illnesses, surgeries, or hospitalizations in the past 5 years?",
                  isTrue: (data.anyIllnesses?.toString() ?? "false") == "true"),
              buildDetailWidget(
                  title: "High blood pressure?",
                  isTrue: (data.highBloodPressure?.toString() ?? "false") ==
                      "true"),
              buildDetailWidget(
                  title: "Low blood pressure?",
                  isTrue:
                      (data.lowBloodPressure?.toString() ?? "false") == "true"),
              buildDetailWidget(
                  title: "Damaged heart valves?",
                  isTrue: (data.damagedHeartValves?.toString() ?? "false") ==
                      "true"),
              buildDetailWidget(
                  title: "Heart Murmurs?",
                  isTrue: (data.heartMurmurs?.toString() ?? "false") == "true"),
              buildDetailWidget(
                  title: "Chest pain (Angina)?",
                  isTrue: (data.chestPain?.toString() ?? "false") == "true"),
              buildDetailWidget(
                  title: "Heart rhythm disorders?",
                  isTrue: (data.heartRhythmDisorders?.toString() ?? "false") ==
                      "true"),
              buildDetailWidget(
                  title: "Heart attack?",
                  isTrue: (data.heartAttack?.toString() ?? "false") == "true"),
              buildDetailWidget(
                  title: "Pacemaker?",
                  isTrue: (data.pacemaker?.toString() ?? "false") == "true"),
              buildDetailWidget(
                  title: "Heart surgeries?",
                  isTrue:
                      (data.heartSurgeries?.toString() ?? "false") == "true"),
              buildDetailWidget(
                  title: "Bronchitis, chronic cough?",
                  isTrue:
                      (data.bronchitisChronicCough?.toString() ?? "false") ==
                          "true"),
              buildDetailWidget(
                  title: "Asthma?",
                  isTrue: (data.asthma?.toString() ?? "false") == "true"),
              buildDetailWidget(
                  title: "Sinus problems?",
                  isTrue:
                      (data.sinusProblems?.toString() ?? "false") == "true"),
              buildDetailWidget(
                  title: "Liver disease?",
                  isTrue: (data.liverDisease?.toString() ?? "false") == "true"),
              buildDetailWidget(
                  title: "Stomach ulcer?",
                  isTrue: (data.stomachUlcer?.toString() ?? "false") == "true"),
              buildDetailWidget(
                  title: "Epilepsy?",
                  isTrue: (data.epilepsy?.toString() ?? "false") == "true"),
              buildDetailWidget(
                  title: "Stroke?",
                  isTrue: (data.stroke?.toString() ?? "false") == "true"),
              buildDetailWidget(
                  title: "Thyroid problems?",
                  isTrue:
                      (data.thyroidProblems?.toString() ?? "false") == "true"),
              buildDetailWidget(
                  title: "Kidney disease?",
                  isTrue:
                      (data.kidneyDisease?.toString() ?? "false") == "true"),
              buildDetailWidget(
                  title: "Swollen joints, arthritis?",
                  isTrue:
                      (data.swollenJointsArthritis?.toString() ?? "false") ==
                          "true"),
              buildDetailWidget(
                  title: "Infectious diseases? Which:",
                  isTrue: (data.infectiousDiseases?.toString() ?? "false") ==
                      "true"),
              buildDetailWidget(
                  title: "HIV infection?",
                  isTrue: (data.hivInfection?.toString() ?? "false") == "true"),
              buildDetailWidget(
                  title: "Tuberculosis (Tb)?",
                  isTrue: (data.tuberculosis?.toString() ?? "false") == "true"),
              buildDetailWidget(
                  title: "Pneumonia?",
                  isTrue: (data.pneumonia?.toString() ?? "false") == "true"),
              buildDetailWidget(
                  title: "Shortness of breath?",
                  isTrue: (data.shortnessOfBreath?.toString() ?? "false") ==
                      "true"),
              buildDetailWidget(
                  title: "Do you smoke?",
                  isTrue: (data.smoking?.toString() ?? "false") == "true"),
              buildDetailWidget(
                  title: "Blood transfusion?",
                  isTrue:
                      (data.bloodTransfusion?.toString() ?? "false") == "true"),
              buildDetailWidget(
                  title: "Blood disorders?",
                  isTrue:
                      (data.bloodDisorders?.toString() ?? "false") == "true"),
              buildDetailWidget(
                  title: "Abnormal tendency to bleed?",
                  isTrue:
                      (data.abnormalBleedingTendency?.toString() ?? "false") ==
                          "true"),
              buildDetailWidget(
                  title: "Hepatitis, jaundice?",
                  isTrue: (data.hepatitisJaundice?.toString() ?? "false") ==
                      "true"),
              buildDetailWidget(
                  title: "Are you pregnant?",
                  isTrue: (data.pregnant?.toString() ?? "false") == "true"),
              buildDetailWidget(
                  title: "Are you currently breastfeeding?",
                  isTrue:
                      (data.breastfeeding?.toString() ?? "false") == "true"),
              buildDetailWidget(
                  title: "Delayed wound healing?",
                  isTrue: (data.delayedWoundHealing?.toString() ?? "false") ==
                      "true"),
              buildDetailWidget(
                  title: "Tumor, cancer?",
                  isTrue: (data.tumorCancer?.toString() ?? "false") == "true"),
              buildDetailWidget(
                  title: "Chemotherapy, radiation therapy?",
                  isTrue: (data.chemotherapyRadiation?.toString() ?? "false") ==
                      "true"),
              buildDetailWidget(
                  title: "Glaucoma (Green star)?",
                  isTrue: (data.glaucoma?.toString() ?? "false") == "true"),
              buildDetailWidget(
                  title: "Artificial joints?",
                  isTrue:
                      (data.artificialJoints?.toString() ?? "false") == "true"),
              buildDetailWidget(
                  title: "Tendency to faint?",
                  isTrue:
                      (data.tendencyToFaint?.toString() ?? "false") == "true"),
              buildDetailWidget(
                  title: "Osteoporosis?",
                  isTrue: (data.steoporosis?.toString() ?? "false") == "true"),
              buildDetailWidget(
                  title: "Do you take hormones?",
                  isTrue: (data.hormones?.toString() ?? "false") == "true"),
              buildDetailWidget(
                  title: "Medication / Category?",
                  isTrue: (data.medicationCategory?.toString() ?? "false") ==
                      "true"),
              buildDetailWidget(
                  title:
                      "Any medications, such as blood thinners like Xarelto, Eliquis, Marcumar, Lixiana?",
                  isTrue:
                      (data.anyMedications?.toString() ?? "false") == "true"),
              buildDetailWidget(
                  title: "Sedatives?",
                  isTrue: (data.sedatives?.toString() ?? "false") == "true"),
              buildDetailWidget(
                  title: "Immunosuppressants?",
                  isTrue: (data.immunosuppressants?.toString() ?? "false") ==
                      "true"),
              buildDetailWidget(
                  title: "Other medications? Please specify:",
                  isTrue:
                      (data.otherMedications?.toString() ?? "false") == "true"),
              buildDetailWidget(
                  title: "Local anesthetic injections?",
                  isTrue:
                      (data.localAnestheticInjections?.toString() ?? "false") ==
                          "true"),
              buildDetailWidget(
                  title: "Penicillin?",
                  isTrue: (data.penicillin?.toString() ?? "false") == "true"),
              buildDetailWidget(
                  title: "Other antibiotics?",
                  isTrue:
                      (data.otherAntibiotics?.toString() ?? "false") == "true"),
              buildDetailWidget(
                  title: "Other allergies?",
                  isTrue:
                      (data.otherAllergies?.toString() ?? "false") == "true"),
              buildDetailWidget(
                  title: "Band-aids (plasters)?",
                  isTrue: (data.bandAids?.toString() ?? "false") == "true"),
              buildDetailWidget(
                  title: "Other medications?",
                  isTrue:
                      (data.otherMedications?.toString() ?? "false") == "true"),
              buildDetailWidget(
                  title: "Bisphosphonate therapy?",
                  isTrue: (data.bisphosphonateTherapy?.toString() ?? "false") ==
                      "true"),
              buildDetailWidget(
                  title: "Referred by a doctor",
                  isTrue:
                      (data.referredByDoctor?.toString() ?? "false") == "true"),
              buildDetailWidget(
                  title: "Internet",
                  isTrue: (data.internet?.toString() ?? "false") == "true"),
              buildDetailWidget(
                  title: "Recommendation",
                  isTrue:
                      (data.recommendation?.toString() ?? "false") == "true"),
              buildDetailWidget(
                  title: "Other",
                  isTrue: (data.other?.toString() ?? "false") == "true"),
              buildSizeHeight(25)
            ]),
          ),
        );
      }),
    );
  }

  buildDetailWidget(
      {required String title, String? value, bool isTrue = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
          Text(value ?? ((isTrue) ? "Yes" : "No"),
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 16))
        ],
      ),
    );
  }
}
