import 'package:erecruitment/src/controllers/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

class KelolaUserPage extends StatelessWidget {
  KelolaUserPage({super.key});

  final _dC = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        ToolBar(
          toolBarConfig: _dC.customToolBarList,
          // toolBarColor: _toolbarColor,
          padding: const EdgeInsets.all(8),
          iconSize: 25,
          // iconColor: _toolbarIconColor,
          activeIconColor: Colors.greenAccent.shade400,
          controller: _dC.controller,
          direction: Axis.horizontal,
        ),
        Expanded(
          child: QuillHtmlEditor(
            text: "<h1>Hello</h1>This is a quill html editor example 😊",
            hintText: 'Hint text goes here',
            controller: _dC.controller,
            isEnabled: true,
            ensureVisible: false,
            minHeight: 500,
            autoFocus: false,
            // textStyle: editorTextStyle,
            // hintTextStyle: _hintTextStyle,
            hintTextAlign: TextAlign.start,
            padding: const EdgeInsets.only(left: 10, top: 10),
            hintTextPadding: const EdgeInsets.only(left: 20),
            // backgroundColor: _backgroundColor,
            inputAction: InputAction.newline,
            onEditingComplete: (s) => debugPrint('Editing completed $s'),
            loadingBuilder: (context) {
              return const Center(
                  child: CircularProgressIndicator(
                strokeWidth: 1,
                color: Colors.red,
              ));
            },
            onFocusChanged: (focus) {
              debugPrint('has focus $focus');
              // setState(() {
              //   _hasFocus = focus;
              // });
            },
            onTextChanged: (text) => debugPrint('widget text change $text'),
            onEditorCreated: () {
              debugPrint('Editor has been loaded');
              // setHtmlText('Testing text on load');
            },
            onEditorResized: (height) => debugPrint('Editor resized $height'),
            onSelectionChanged: (sel) =>
                debugPrint('index ${sel.index}, range ${sel.length}'),
          ),
        ),
      ]),
    );
  }
}
