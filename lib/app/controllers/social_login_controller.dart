import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SocialLoginController extends GetxController {
  RxString userEmail = "".obs;
  RxString userName = "".obs;
  RxString userPhone = "".obs;
  RxString userId = "".obs;

  Future<String> signInWithGoogle() async {
    try {
      await GoogleSignIn().signOut();
      final GoogleSignInAccount? googleSignInAccount =
          await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleSignInAuthentication =
          await googleSignInAccount?.authentication;
      if (googleSignInAuthentication?.accessToken == null &&
          googleSignInAuthentication?.idToken == null) {
        return "Authorization revoked";
      }
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication?.accessToken,
        idToken: googleSignInAuthentication?.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;
      if (user != null) {
        userEmail.value = user.email ?? "";
        userName.value = user.displayName ?? "";
        userPhone.value = user.phoneNumber ?? "";
        userId.value = user.uid;
        log("Access Token : ${googleSignInAuthentication?.accessToken}");
        log("ID Token : ${googleSignInAuthentication?.idToken}");
        log(
          "User Credentials :::: UID: ${user.uid}, Name - ${user.displayName}, Email - ${user.email}, Phone - ${user.phoneNumber}, Photo - ${user.photoURL}",
        );
      }
      return "";
    } catch (e) {
      log("Exception ::: ${e.toString()}");
      return "Authorization revoked";
    }
  }

  Future<bool> signOutFromGoogle() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  Map<String, dynamic>? userData;

  Future<String> signInWithApple() async {
    try {
      final credentials = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      userEmail.value = credentials.email?.toString() ?? "";
      userName.value = credentials.givenName?.toString() ?? "";
      userId.value = credentials.userIdentifier?.toString() ?? "";

      log("Access Token : ${credentials.userIdentifier}");
      log("ID Token : ${credentials.identityToken}");
      log("User Credentials :::: Name - ${credentials.givenName}, Email - ${credentials.email}");
      return "";
    } catch (e) {
      log("Exception ::: ${e.toString()}");
      return "Authorization revoked";
    }
  }
//   Future signInWithFacebook() async {
//     try {
//       await FacebookAuth.instance.logOut();
//       userData = null;
//       final LoginResult loginResult = await FacebookAuth.instance.login(
//         permissions: ['email', 'public_profile'],
//       );
//       if (loginResult.status == LoginStatus.success) {
//         final userInfo = await FacebookAuth.instance.getUserData();
//         userData = userInfo;
//         if (kDebugMode) {
//           print(userData);
//         }
//         String? email = userData?["email"];

//         if (userData?["id"] != null) {
//           log(
//             "User Credentials :::: Name - ${userData?["name"]}, Email - $email, Phone - ${userData?["phone"]}, Photo - ${userData?["photoURL"]}",
//           );
//         }
//       } else {
//         if (kDebugMode) {
//           print('ResultStatus: ${loginResult.status}');
//           print('Message: ${loginResult.message}');
//         }
//       }
//     } catch (e) {
//       showSnackBar(subtitle: "$e");
//     }
//   }

// Login using Social Account
  // socialLoginApi({required String type}) async {
  //   SignupController signupController = Get.put(SignupController());
  //   String deviceToken =
  //       await BaseStorage.read(StorageKeys.fcmToken) ?? fcmToken;
  //   Map<String, String> data = {
  //     "id": userId.value,
  //     "type": type,
  //     "deviceToken": deviceToken
  //   };
  //   BaseApiService()
  //       .post(apiEndPoint: ApiEndPoints().socialLogin, data: data)
  //       .then((value) {
  //     if (value?.statusCode == 200) {
  //       try {
  //         VerifyLoginOtpResponse response =
  //             VerifyLoginOtpResponse.fromJson(value?.data);
  //         if (response.success ?? false) {
  //           // BaseStorage.write(StorageKeys.userLocation,
  //           //     response.result?.address.toString() ?? "");

  //           if (response.data?.isSignUp ?? true) {
  //             signupController.emailController.text = userEmail.value;
  //             signupController.nameController.text = userName.value;
  //             signupController.phoneController.text = userPhone.value;
  //             signupController.isEmailVerified.value = false;
  //             signupController.isPhoneVerified.value = false;
  //             signupController.isReferralVerified.value = false;
  //             signupController.socialId.value = userId.value;
  //             signupController.socialType.value = type;
  //             Get.to(() => const SignUpScreen(
  //                   isSocialLogin: true,
  //                 ));
  //           } else {
  //             BaseStorage.write(
  //                 StorageKeys.apiToken, response.data?.token?.toString() ?? "");

  //             BaseStorage.write(StorageKeys.userId,
  //                 response.data?.user?.id?.toString() ?? "");
  //             BaseStorage.write(StorageKeys.userImage,
  //                 response.data?.user?.avatar?.toString() ?? "");
  //             BaseStorage.write(StorageKeys.userName,
  //                 response.data?.user?.name?.toString() ?? "");
  //             BaseStorage.write(StorageKeys.nickName,
  //                 response.data?.user?.username?.toString() ?? "");
  //             showSnackBar(subtitle: response.message ?? "", isSuccess: true);
  //             if ((response.data?.user?.step?.toString() ?? "1") == "1") {
  //               Get.to(() => const NicknameScreen());
  //             } else if ((response.data?.user?.step?.toString() ?? "1") ==
  //                 "2") {
  //               Get.to(() => const HideProfileScreen());
  //             } else if ((response.data?.user?.step?.toString() ?? "1") ==
  //                 "3") {
  //               Get.to(() => const OnBoardLocationScreen());
  //             } else if ((response.data?.user?.step?.toString() ?? "1") ==
  //                     "4" &&
  //                 ((int.tryParse((response.data?.userdetail?.details?.page
  //                                 ?.toString() ??
  //                             "1")) ??
  //                         1) <
  //                     9)) {
  //               Get.to(() => SignUpStepsScreen(
  //                     isFromLogin: true,
  //                     page: (int.tryParse(response
  //                                     .data?.userdetail?.details?.page
  //                                     ?.toString() ??
  //                                 "1") ??
  //                             0) -
  //                         1,
  //                     responseData: response.data,
  //                   ));
  //             } else if ((response.data?.user?.step?.toString() ?? "1") ==
  //                     "4" &&
  //                 (int.tryParse((response.data?.userdetail?.details?.page
  //                                 ?.toString() ??
  //                             "1")) ??
  //                         1) >=
  //                     9) {
  //               onUserLogin();
  //               BaseStorage.write(StorageKeys.isLoggedIn, true);
  //               Get.offAll(() => const DashboardScreen());
  //             } else {
  //               Get.to(() => const SignUpStepsScreen());
  //             }
  //           }
  //         } else {
  //           showSnackBar(subtitle: response.message ?? "");
  //         }
  //       } catch (e) {
  //         showSnackBar(subtitle: parsingError);
  //       }
  //     } else {
  //       showSnackBar(subtitle: "Something went wrong, please try again");
  //     }
  //   });
  // }
}
