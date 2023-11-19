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
  name: "",
  position: "",
  page: 0,
);

const examEmpty = ExamM(
  id: "",
  title: "",
  subname: "",
  created: "",
  updated: "",
  type: "",
  informasi: "",
  time: 0,
  number: 0,
  users: [],
  shuffle: false,
);
