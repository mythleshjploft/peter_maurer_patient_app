class ApiEndPoints {
  // final String baseUrl = 'http://192.168.29.86/macchacommunity/api/';
  // final String imgBaseUrl = 'http://192.168.29.86/macchacommunity/';
  // final String socketUrl = "http://192.168.29.86:5000/";
  final String baseUrl = 'http://3.109.98.222:7900/api/';
  final String imgBaseUrl = 'http://3.109.98.222:7900/uploads/images/';
  final String socketUrl = "http://3.109.98.222:7900";
  final String callbackUrl = "http://3.109.98.222:7902/";

  /// Endpoints
  ///
  final String registerAccount = 'app/auth/signup';
  final String login = 'app/auth/login';
  final String forgotPassword = 'app/auth/forgot-password';
  final String countryList = 'common/country';
  final String notesList = 'app/note';
  final String cityList = 'common/city/';
  final String verifyOtp = 'app/auth/verify-otp';
  final String savePassword = 'app/auth/confirm_password';
  final String categoriesList = 'common/categories';
  final String conditionList = 'admin/condition';
  final String profileDetails = 'app/auth/profile';
  final String updateProfile = 'app/auth/update-profile';
  final String notificationList = 'app/notification';
  final String appointmentList = 'app/appointment';
  final String dashboard = 'app/dashboard';
  final String doctorList = 'app/dashboard/doctor';
  final String doctorDetails = 'app/doctor_clinic_detail/new/';
  final String addAppointment = 'app/appointment/book-appointment_new';
  final String chatList = 'common/getChatUsers';
  final String changeAppointmentStatus = 'app/appointment/status/';
  final String rescheduleAppointment = 'app/appointment/reschedule_appointment';
  final String uploadMediaInChat = 'common/upload-media';
  final String socialLogin = 'app/auth/social-login';
  final String diseaseList = 'common/get_pre_exist_deasese';
  final String resetPassword = 'app/auth/reset-password';
  final String getPatientNoteByAppointmentid =
      'common/get_patient_noteByAppointmentid';

  final String initiateChat = 'common/initiate-chat';
}
