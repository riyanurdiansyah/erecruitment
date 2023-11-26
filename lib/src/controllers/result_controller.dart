import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/app_constanta_empty.dart';
import '../models/exam_m.dart';
import '../models/user_m.dart';
import '../repositories/auth_repository.dart';
import '../repositories/menu_repository.dart';

class ResultController extends GetxController {
  late SharedPreferences prefs;

  final Rx<bool> isShowUse = false.obs;

  final Rx<int> selectedTabIndex = 0.obs;

  final MenuRepository menuRepository = MenuRepositoryImpl();

  final AuthRepository authRepository = AuthRepositoryImpl();

  final RxList<ExamM> exams = <ExamM>[].obs;

  final Rx<UserM> user = userEmpty.obs;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  void onInit() async {
    prefs = await SharedPreferences.getInstance();
    await getUserDetail();
    await getExams();
    super.onInit();
  }

  Future<void> getUserDetail() async {
    final data =
        await authRepository.getUser(prefs.getString("username") ?? "");
    if (data != null) {
      user.value = data;
    }
  }

  Future getExams() async {
    final data = await menuRepository.getExams();

    exams.value = data.where((e) => user.value.quizes.contains(e.id)).toList();
  }

  Future<UserCredential?> googleSignIn() async {
    // Initialize Firebase
    User? user;
    FirebaseAuth auth = FirebaseAuth.instance;
    // The `GoogleAuthProvider` can only be
    // used while running on the web
    GoogleAuthProvider authProvider = GoogleAuthProvider();
    authProvider.addScope("https://mail.google.com/");

    try {
      final UserCredential userCredential =
          await auth.signInWithPopup(authProvider);
      return userCredential;
    } catch (e) {
      print(e);
      return null;
    }
  }

  void sendMail({
    required String email,
    required String mailMessage,
  }) async {
    await _googleSignIn.signOut();
    final user = await googleSignIn();

    if (user == null || user.user == null) return;

    final sender = user.user!.email!;
    final token = user.credential!.accessToken!;

    print("AUTHENTICATED : $sender");

    final smtpServer = gmailSaslXoauth2(sender, token);

    final message = Message()
      ..from = Address(sender, "Mail Service")
      ..recipients = ["riyanurdiansyah@gmail.com"]
      ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
      ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";

    message.headers['Authorization'] = 'Bearer $token';
    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: $sendReport');
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }
}
