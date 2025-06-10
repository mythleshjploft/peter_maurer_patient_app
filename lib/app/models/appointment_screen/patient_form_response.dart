// To parse this JSON data, do
//
//     final patientFormResponse = patientFormResponseFromJson(jsonString);

import 'dart:convert';

PatientFormResponse patientFormResponseFromJson(String str) =>
    PatientFormResponse.fromJson(json.decode(str));

String patientFormResponseToJson(PatientFormResponse data) =>
    json.encode(data.toJson());

class PatientFormResponse {
  bool? success;
  String? message;
  PatientFormData? data;

  PatientFormResponse({
    this.success,
    this.message,
    this.data,
  });

  factory PatientFormResponse.fromJson(Map<String, dynamic> json) =>
      PatientFormResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : PatientFormData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class PatientFormData {
  dynamic appointmentId;
  dynamic patientId;
  dynamic anyMedications;
  dynamic asthma;
  dynamic bandAids;
  dynamic bisphosphonateTherapy;
  dynamic bronchitisChronicCough;
  dynamic chestPain;
  dynamic damagedHeartValves;
  dynamic epilepsy;
  dynamic gallbladderSurgery;
  dynamic steoporosis;
  dynamic hivInfection;
  dynamic heartAttack;
  dynamic heartMurmurs;
  dynamic heartRhythmDisorders;
  dynamic heartSurgeries;
  dynamic highBloodPressure;
  dynamic immunosuppressants;
  dynamic infectiousDiseases;
  dynamic internet;
  dynamic kidneyDisease;
  dynamic liverDisease;
  dynamic localAnestheticInjections;
  dynamic lowBloodPressure;
  dynamic medicationCategory;
  dynamic other;
  dynamic otherAntibiotics;
  dynamic otherAllergies;
  dynamic otherMedications;
  dynamic pacemaker;
  dynamic penicillin;
  dynamic recommendation;
  dynamic referredByDoctor;
  dynamic sedatives;
  dynamic sinusProblems;
  dynamic pisphosphonateTherapy;
  dynamic stomachUlcer;
  dynamic stroke;
  dynamic swollenJointsArthritis;
  dynamic thyroidProblems;
  dynamic tuberculosis;
  dynamic abnormalBleedingTendency;
  dynamic artificialJoints;
  dynamic bloodDisorders;
  dynamic bloodTransfusion;
  dynamic breastfeeding;
  dynamic chemotherapyRadiation;
  dynamic cityId;
  dynamic countryId;
  dynamic delayedWoundHealing;
  dynamic dentistWithCity;
  dynamic dob;
  dynamic email;
  dynamic firstName;
  dynamic lastName;
  dynamic gender;
  dynamic generalPractitioner;
  dynamic glaucoma;
  dynamic goodHealth;
  dynamic healthInsuranceName;
  dynamic height;
  dynamic hepatitisJaundice;
  dynamic hormones;
  List<String>? insuranceType;
  dynamic medicalHistory;
  dynamic medicalTreatment;
  dynamic occupation;
  dynamic placeOfBirth;
  dynamic pneumonia;
  dynamic pregnant;
  dynamic reasonForTodayVisit;
  dynamic shortnessOfBreath;
  dynamic smoking;
  dynamic streetNo;
  dynamic tendencyToFaint;
  dynamic tumorCancer;
  dynamic weight;
  dynamic whichDoctorReferredYouToUs;
  dynamic zipCode;
  dynamic privateMobile;
  dynamic workMobile;
  dynamic anyIllnesses;
  dynamic id;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic v;

  PatientFormData({
    this.appointmentId,
    this.patientId,
    this.anyMedications,
    this.asthma,
    this.bandAids,
    this.bisphosphonateTherapy,
    this.bronchitisChronicCough,
    this.chestPain,
    this.damagedHeartValves,
    this.epilepsy,
    this.gallbladderSurgery,
    this.steoporosis,
    this.hivInfection,
    this.heartAttack,
    this.heartMurmurs,
    this.heartRhythmDisorders,
    this.heartSurgeries,
    this.highBloodPressure,
    this.immunosuppressants,
    this.infectiousDiseases,
    this.internet,
    this.kidneyDisease,
    this.liverDisease,
    this.localAnestheticInjections,
    this.lowBloodPressure,
    this.medicationCategory,
    this.other,
    this.otherAntibiotics,
    this.otherAllergies,
    this.otherMedications,
    this.pacemaker,
    this.penicillin,
    this.recommendation,
    this.referredByDoctor,
    this.sedatives,
    this.sinusProblems,
    this.pisphosphonateTherapy,
    this.stomachUlcer,
    this.stroke,
    this.swollenJointsArthritis,
    this.thyroidProblems,
    this.tuberculosis,
    this.abnormalBleedingTendency,
    this.artificialJoints,
    this.bloodDisorders,
    this.bloodTransfusion,
    this.breastfeeding,
    this.chemotherapyRadiation,
    this.cityId,
    this.countryId,
    this.delayedWoundHealing,
    this.dentistWithCity,
    this.dob,
    this.email,
    this.firstName,
    this.lastName,
    this.gender,
    this.generalPractitioner,
    this.glaucoma,
    this.goodHealth,
    this.healthInsuranceName,
    this.height,
    this.hepatitisJaundice,
    this.hormones,
    this.insuranceType,
    this.medicalHistory,
    this.medicalTreatment,
    this.occupation,
    this.placeOfBirth,
    this.pneumonia,
    this.pregnant,
    this.reasonForTodayVisit,
    this.shortnessOfBreath,
    this.smoking,
    this.streetNo,
    this.tendencyToFaint,
    this.tumorCancer,
    this.weight,
    this.whichDoctorReferredYouToUs,
    this.zipCode,
    this.privateMobile,
    this.workMobile,
    this.anyIllnesses,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory PatientFormData.fromJson(Map<String, dynamic> json) =>
      PatientFormData(
        appointmentId: json["appointment_id"],
        patientId: json["patient_id"],
        anyMedications: json["any_medications"],
        asthma: json["asthma"],
        bandAids: json["band_aids"],
        bisphosphonateTherapy: json["bisphosphonate_therapy"],
        bronchitisChronicCough: json["Bronchitis_chronic_cough"],
        chestPain: json["chest_pain"],
        damagedHeartValves: json["damaged_heart_valves"],
        epilepsy: json["epilepsy"],
        gallbladderSurgery: json["gallbladder_surgery"],
        steoporosis: json["steoporosis"],
        hivInfection: json["HIV_infection"],
        heartAttack: json["heart_attack"],
        heartMurmurs: json["heart_murmurs"],
        heartRhythmDisorders: json["heart_rhythm_disorders"],
        heartSurgeries: json["heart_surgeries"],
        highBloodPressure: json["high_blood_pressure"],
        immunosuppressants: json["immunosuppressants"],
        infectiousDiseases: json["infectious_diseases"],
        internet: json["internet"],
        kidneyDisease: json["kidney_disease"],
        liverDisease: json["liver_disease"],
        localAnestheticInjections: json["local_anesthetic_injections"],
        lowBloodPressure: json["low_blood_pressure"],
        medicationCategory: json["medication_Category"],
        other: json["Other"],
        otherAntibiotics: json["other_antibiotics"],
        otherAllergies: json["other_allergies"],
        otherMedications: json["other_medications"],
        pacemaker: json["pacemaker"],
        penicillin: json["penicillin"],
        recommendation: json["recommendation"],
        referredByDoctor: json["referred_by_doctor"],
        sedatives: json["sedatives"],
        sinusProblems: json["sinus_problems"],
        pisphosphonateTherapy: json["pisphosphonate_therapy"],
        stomachUlcer: json["stomach_ulcer"],
        stroke: json["Stroke"],
        swollenJointsArthritis: json["Swollen_joints_arthritis"],
        thyroidProblems: json["thyroid_problems"],
        tuberculosis: json["tuberculosis"],
        abnormalBleedingTendency: json["abnormal_bleeding_tendency"],
        artificialJoints: json["artificial_joints"],
        bloodDisorders: json["blood_disorders"],
        bloodTransfusion: json["blood_transfusion"],
        breastfeeding: json["breastfeeding"],
        chemotherapyRadiation: json["chemotherapy_radiation"],
        cityId: json["city_id"],
        countryId: json["country_id"],
        delayedWoundHealing: json["delayed_wound_healing"],
        dentistWithCity: json["dentist_with_city"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        gender: json["gender"],
        generalPractitioner: json["general_practitioner"],
        glaucoma: json["glaucoma"],
        goodHealth: json["good_health"],
        healthInsuranceName: json["health_insurance_name"],
        height: json["height"],
        hepatitisJaundice: json["hepatitis_jaundice"],
        hormones: json["hormones"],
        insuranceType: json["insurance_type"] == null
            ? []
            : List<String>.from(json["insurance_type"]!.map((x) => x)),
        medicalHistory: json["medical_history"],
        medicalTreatment: json["medical_treatment"],
        occupation: json["occupation"],
        placeOfBirth: json["place_of_birth"],
        pneumonia: json["pneumonia"],
        pregnant: json["pregnant"],
        reasonForTodayVisit: json["reason_for_today_visit"],
        shortnessOfBreath: json["shortness_of_breath"],
        smoking: json["smoking"],
        streetNo: json["street_no"],
        tendencyToFaint: json["tendency_to_faint"],
        tumorCancer: json["tumor_cancer"],
        weight: json["weight"],
        whichDoctorReferredYouToUs: json["which_doctor_referred_you_to_us"],
        zipCode: json["zip_code"],
        privateMobile: json["private_mobile"],
        workMobile: json["work_mobile"],
        anyIllnesses: json["any_illnesses"],
        id: json["_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "appointment_id": appointmentId,
        "patient_id": patientId,
        "any_medications": anyMedications,
        "asthma": asthma,
        "band_aids": bandAids,
        "bisphosphonate_therapy": bisphosphonateTherapy,
        "Bronchitis_chronic_cough": bronchitisChronicCough,
        "chest_pain": chestPain,
        "damaged_heart_valves": damagedHeartValves,
        "epilepsy": epilepsy,
        "gallbladder_surgery": gallbladderSurgery,
        "steoporosis": steoporosis,
        "HIV_infection": hivInfection,
        "heart_attack": heartAttack,
        "heart_murmurs": heartMurmurs,
        "heart_rhythm_disorders": heartRhythmDisorders,
        "heart_surgeries": heartSurgeries,
        "high_blood_pressure": highBloodPressure,
        "immunosuppressants": immunosuppressants,
        "infectious_diseases": infectiousDiseases,
        "internet": internet,
        "kidney_disease": kidneyDisease,
        "liver_disease": liverDisease,
        "local_anesthetic_injections": localAnestheticInjections,
        "low_blood_pressure": lowBloodPressure,
        "medication_Category": medicationCategory,
        "Other": other,
        "other_antibiotics": otherAntibiotics,
        "other_allergies": otherAllergies,
        "other_medications": otherMedications,
        "pacemaker": pacemaker,
        "penicillin": penicillin,
        "recommendation": recommendation,
        "referred_by_doctor": referredByDoctor,
        "sedatives": sedatives,
        "sinus_problems": sinusProblems,
        "pisphosphonate_therapy": pisphosphonateTherapy,
        "stomach_ulcer": stomachUlcer,
        "Stroke": stroke,
        "Swollen_joints_arthritis": swollenJointsArthritis,
        "thyroid_problems": thyroidProblems,
        "tuberculosis": tuberculosis,
        "abnormal_bleeding_tendency": abnormalBleedingTendency,
        "artificial_joints": artificialJoints,
        "blood_disorders": bloodDisorders,
        "blood_transfusion": bloodTransfusion,
        "breastfeeding": breastfeeding,
        "chemotherapy_radiation": chemotherapyRadiation,
        "city_id": cityId,
        "country_id": countryId,
        "delayed_wound_healing": delayedWoundHealing,
        "dentist_with_city": dentistWithCity,
        "dob": dob?.toIso8601String(),
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "gender": gender,
        "general_practitioner": generalPractitioner,
        "glaucoma": glaucoma,
        "good_health": goodHealth,
        "health_insurance_name": healthInsuranceName,
        "height": height,
        "hepatitis_jaundice": hepatitisJaundice,
        "hormones": hormones,
        "insurance_type": insuranceType == null
            ? []
            : List<dynamic>.from(insuranceType!.map((x) => x)),
        "medical_history": medicalHistory,
        "medical_treatment": medicalTreatment,
        "occupation": occupation,
        "place_of_birth": placeOfBirth,
        "pneumonia": pneumonia,
        "pregnant": pregnant,
        "reason_for_today_visit": reasonForTodayVisit,
        "shortness_of_breath": shortnessOfBreath,
        "smoking": smoking,
        "street_no": streetNo,
        "tendency_to_faint": tendencyToFaint,
        "tumor_cancer": tumorCancer,
        "weight": weight,
        "which_doctor_referred_you_to_us": whichDoctorReferredYouToUs,
        "zip_code": zipCode,
        "private_mobile": privateMobile,
        "work_mobile": workMobile,
        "any_illnesses": anyIllnesses,
        "_id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
