import 'package:erecruitment/src/models/exam_m.dart';
import 'package:erecruitment/src/models/question_m.dart';
import 'package:erecruitment/src/repositories/dashboard_repository.dart';
import 'package:erecruitment/src/repositories/test_repository.dart';
import 'package:erecruitment/utils/app_constanta_empty.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
import 'package:uuid/uuid.dart';

import '../models/user_m.dart';

class TestController extends GetxController {
  final Rx<ExamM> exam = examEmpty.obs;

  final Rx<bool> isEdited = false.obs;

  final Rx<String> examId = "".obs;

  final Rx<String> informasiTest = "".obs;

  final Rx<String> questionId = "".obs;

  final Rx<int> page = 1.obs;

  final Rx<int> pageUser = 1.obs;

  final Rx<int> mainPage = 1.obs;

  final RxList<QuestionsM> questions = <QuestionsM>[].obs;

  final RxList<QuestionsM> questionsSearch = <QuestionsM>[].obs;

  final Rx<bool> isLoading = true.obs;

  final TestRepository testRepository = TestRepositoryImpl();

  final DashboardRepository dashboardRepository = DashboardRepositoryImpl();

  final tcSearch = TextEditingController();

  final tcOptionQuestion = TextEditingController();

  final tcOptionTitle = TextEditingController();

  final tcOptionPoint = TextEditingController();

  final tcNama = TextEditingController();

  final tcNamaSamaran = TextEditingController();

  final tcTipe = TextEditingController();

  final tcJumlahSoal = TextEditingController();

  final tcWaktu = TextEditingController();

  final RxList<QuestionIstOptionM> optionsIst = <QuestionIstOptionM>[].obs;

  late QuillEditorController controller;

  final RxList<UserM> users = <UserM>[].obs;

  final RxList<UserM> usersSearch = <UserM>[].obs;

  final Rx<UserM> selectedUser = userEmpty.obs;

  @override
  void onInit() {
    Future.delayed(
      const Duration(seconds: 1),
      () async {
        controller = QuillEditorController();
        controller.onTextChanged((text) {
          debugPrint('listening to $text');
        });
        controller.onEditorLoaded(() {
          debugPrint('Editor Loaded :)');
        });
        await getExam();
        await getExamQuestions();
        await changeLoading(false);
      },
    );
    super.onInit();
  }

  Future getExam() async {
    users.clear();
    double pageTemp = 0;
    final response = await testRepository.getExam(examId.value);
    if (response != null) {
      exam.value = response;
      tcNama.text = response.title;
      tcNamaSamaran.text = response.subname;
      tcWaktu.text = response.time.toString();
      tcJumlahSoal.text = response.number.toString();
      tcTipe.text = response.type;
      informasiTest.value = response.informasi;

      for (int i = 0; i < response.users.length; i++) {
        final dataUser = await testRepository.getUserDetail(response.users[i]);
        if (dataUser != null) {
          users.add(dataUser);
        }
      }

      for (int i = 0; i < users.length; i++) {
        pageTemp = (i + 1) / 3;
        users[i] = users[i].copyWith(page: pageTemp.ceil());
      }
    }
  }

  Future updateExam() async {
    final listUser = List<String>.from(users.map((e) => e.id));
    final body = {
      "id": exam.value.id,
      "number": int.parse(tcJumlahSoal.text),
      "title": tcNama.text,
      "subname": tcNamaSamaran.text,
      "time": int.parse(tcWaktu.text),
      "type": tcTipe.text,
      "informasi": await controller.getText(),
      "users": listUser.map((e) => e).toList(),
    };

    final response = await testRepository.updateExam(body);
    Fluttertoast.showToast(msg: response ?? "Data berhasil diubah");
    if (response == null) {
      getExam();
    }
  }

  Future getExamQuestions() async {
    double pageTemp = 0;
    final response = await testRepository.getQuestionIST(examId.value);
    response.sort(
      (a, b) => DateTime.parse(b.created).compareTo(DateTime.parse(a.created)),
    );
    questions.value = response;
    for (int i = 0; i < questions.length; i++) {
      pageTemp = (i + 1) / 2;
      questions[i] = questions[i].copyWith(page: pageTemp.ceil());
    }
  }

  Future changeLoading(bool newValue) async {
    isLoading.value = newValue;
  }

  void onChangePageUser(int val) {
    pageUser.value = val;
  }

  void onChangePage(int val) {
    page.value = val;
  }

  void onSearch(String query) {
    double pageTemp = 0;
    List<QuestionsM> questionsTemp = [];
    if (query.isEmpty) {
      questionsTemp.clear();
      questionsSearch.clear();
    } else {
      questionsTemp = questions
          .where((e) => e.question.toLowerCase().contains(query.toLowerCase()))
          .toList();
      for (int i = 0; i < questionsTemp.length; i++) {
        pageTemp = (i + 1) / 2;
        questionsTemp[i] = questionsTemp[i].copyWith(page: pageTemp.ceil());
      }
      questionsSearch.value = questionsTemp;
    }
  }

  void onSearchUser(String query) {
    double pageTemp = 0;
    List<UserM> usersTemp = [];
    if (query.isEmpty) {
      usersTemp.clear();
      usersSearch.clear();
    } else {
      usersTemp = users
          .where((e) => e.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      for (int i = 0; i < usersTemp.length; i++) {
        pageTemp = (i + 1) / 2;
        usersTemp[i] = usersTemp[i].copyWith(page: pageTemp.ceil());
      }
      usersSearch.value = usersTemp;
    }
  }

  void addToListOption() {
    optionsIst.add(
      QuestionIstOptionM(
        answer: false,
        point: int.parse(tcOptionPoint.text.isEmpty ? "0" : tcOptionPoint.text),
        teks: tcOptionTitle.text,
      ),
    );
    tcOptionTitle.clear();
    tcOptionPoint.clear();
  }

  void onChangeMainPage(int newVal) {
    mainPage.value = newVal;
  }

  void onCheckOptionIst(int index, bool newVal) {
    for (int i = 0; i < optionsIst.length; i++) {
      optionsIst[i] = optionsIst[i].copyWith(answer: false);
    }
    optionsIst[index] = optionsIst[index].copyWith(answer: newVal);
  }

  void deleteListOptionIst(int index) {
    optionsIst.removeAt(index);
  }

  void updateQuestionIst() async {
    final body = {
      "exam_id": examId.value,
      "id": questionId.value,
      "question": tcOptionQuestion.text,
      "options": optionsIst.map((obj) => obj.toJson()).toList(),
      "updated": DateTime.now().toIso8601String(),
      "status": true,
    };
    final response = await testRepository.updateQuestionIST(body);
    if (response != null) {
      Fluttertoast.showToast(msg: "ERROR: $response");
    } else {
      cancelEdit();
      getExamQuestions();
    }
  }

  void addQuestionIst() async {
    const Uuid uuid = Uuid();
    String randomUuid = uuid.v4();
    final body = {
      "exam_id": examId.value,
      "id": randomUuid,
      "question": tcOptionQuestion.text,
      "options": optionsIst.map((obj) => obj.toJson()).toList(),
      "created": DateTime.now().toIso8601String(),
      "updated": DateTime.now().toIso8601String(),
      "status": true,
    };
    final response = await testRepository.addQuestionIST(body);
    if (response != null) {
      Fluttertoast.showToast(msg: "ERROR: $response");
    } else {
      tcOptionQuestion.clear();
      optionsIst.clear();
      getExamQuestions();
    }
  }

  void deleteQuestionIST(String id) async {
    final body = {
      "exam_id": examId.value,
      "id": id,
    };
    final response = await testRepository.deleteQuestionIST(body);
    if (response != null) {
      Fluttertoast.showToast(msg: "ERROR: $response");
    } else {
      if (isEdited.value) {
        cancelEdit();
      }
      getExamQuestions();
    }
  }

  void editQuestion(QuestionsM quest) {
    isEdited.value = true;
    tcOptionQuestion.text = quest.question;
    optionsIst.value = quest.options;
    questionId.value = quest.id;
  }

  void cancelEdit() {
    isEdited.value = false;
    optionsIst.clear();
    tcOptionTitle.clear();
    tcOptionQuestion.clear();
    tcOptionPoint.clear();
    questionId.value = "";
  }

  void addUsersToTemp() async {
    double pageTemp = 0;
    users.add(selectedUser.value);
    selectedUser.value = userEmpty;
    for (int i = 0; i < users.length; i++) {
      pageTemp = (i + 1) / 3;
      users[i] = users[i].copyWith(page: pageTemp.ceil());
    }
  }
}
