import 'package:erecruitment/src/models/exam_m.dart';
import 'package:erecruitment/src/models/question_m.dart';
import 'package:erecruitment/src/repositories/test_repository.dart';
import 'package:erecruitment/utils/app_constanta_empty.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class TestController extends GetxController {
  final Rx<ExamM> exam = examEmpty.obs;

  final Rx<bool> isEdited = false.obs;

  final Rx<String> examId = "".obs;

  final Rx<String> questionId = "".obs;

  final Rx<int> page = 1.obs;

  final RxList<QuestionsM> questions = <QuestionsM>[].obs;

  final RxList<QuestionsM> questionsSearch = <QuestionsM>[].obs;

  final Rx<bool> isLoading = true.obs;

  final TestRepository testRepository = TestRepositoryImpl();

  final tcSearch = TextEditingController();

  final tcOptionQuestion = TextEditingController();

  final tcOptionTitle = TextEditingController();

  final tcOptionPoint = TextEditingController();

  final RxList<QuestionIstOptionM> optionsIst = <QuestionIstOptionM>[].obs;

  @override
  void onInit() {
    Future.delayed(
      const Duration(seconds: 1),
      () async {
        await getExam();
        await getExamQuestions();
        await changeLoading(false);
      },
    );
    super.onInit();
  }

  Future getExam() async {
    final response = await testRepository.getExam(examId.value);
    if (response != null) {
      exam.value = response;
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
}
