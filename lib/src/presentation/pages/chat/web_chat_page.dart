import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WebChatPage extends StatefulWidget {
  const WebChatPage({
    super.key,
    required this.no,
  });

  final String no;

  @override
  State<WebChatPage> createState() => _WebChatPageState();
}

class _WebChatPageState extends State<WebChatPage> {
  @override
  void initState() {
    if (widget.no.isNotEmpty && widget.no[0] == "6" && widget.no[1] == "2") {
      // if (kIsWeb) {
      //   launchUrl(Uri.parse(
      //       "https://web.whatsapp.com/send/?phone=${widget.no}&text&type=phone_number&app_absent=0"));
      // } else {
      launchUrl(Uri.parse("https://wa.me/${widget.no}"));
      // }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
