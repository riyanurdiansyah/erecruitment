import 'package:erecruitment/src/models/exam_m.dart';
import 'package:erecruitment/src/models/user_m.dart';

final userEmpty = UserM(
  email: "",
  ended: "",
  id: "",
  quizes: [],
  started: "",
  username: "",
  role: 99,
);

final examEmpty = ExamM(
  id: "",
  title: "",
  created: "",
  updated: "",
  type: "",
  time: 0,
  number: 0,
  users: [],
);
