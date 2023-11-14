import 'package:erecruitment/src/controllers/auth_controller.dart';
import 'package:erecruitment/utils/app_route_name.dart';
import 'package:erecruitment/utils/app_text_normal.dart';
import 'package:erecruitment/utils/app_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../utils/app_decoration.dart';

class SigninPage extends StatelessWidget {
  SigninPage({super.key});

  final _authC = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Stack(
        children: [
          Center(
            child: SizedBox(
              width: size.width / 1.5,
              height: size.height / 1.5,
              child: Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: Container(
                      color: Colors.blue,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          vertical: 35, horizontal: 50),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const FlutterLogo(
                            size: 100,
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: AppTextNormal.labelW600(
                              "Username",
                              16,
                              Colors.blue,
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          TextFormField(
                            controller: _authC.tcUsername,
                            textInputAction: TextInputAction.next,
                            decoration: textFieldAuthDecoration(
                                fontSize: 14,
                                hintText: "username or email",
                                radius: 4),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (val) => AppValidator.requiredField(val!,
                                errorMsg: "Username tidak boleh kosong"),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: AppTextNormal.labelW600(
                              "Password",
                              16,
                              Colors.blue,
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          TextFormField(
                            obscureText: true,
                            controller: _authC.tcPassword,
                            textInputAction: TextInputAction.go,
                            onEditingComplete: () => _authC.signIn(),
                            decoration: textFieldAuthDecoration(
                                fontSize: 14, hintText: "********", radius: 4),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (val) => AppValidator.requiredField(val!,
                                errorMsg: "Password tidak boleh kosong"),
                          ),
                          Obx(() {
                            if (_authC.errorMessage.isNotEmpty) {
                              return Column(
                                children: [
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  AppTextNormal.labelW600(
                                    _authC.errorMessage.value,
                                    14,
                                    Colors.red,
                                  ),
                                ],
                              );
                            }
                            return const SizedBox();
                          }),
                          const SizedBox(
                            height: 35,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 45,
                            child: ElevatedButton(
                              onPressed: () {
                                _authC.signIn();
                              },
                              child: AppTextNormal.labelBold(
                                "Masuk",
                                18,
                                Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Obx(() {
            if (_authC.isLoading.value) {
              return Center(
                child: Container(
                  alignment: Alignment.center,
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey.shade600,
                  ),
                  child: const CupertinoActivityIndicator(
                    color: Colors.blue,
                  ),
                ),
              );
            }
            return const SizedBox();
          })
        ],
      ),
    );
  }
}
