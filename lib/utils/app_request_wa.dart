class AppRequestWA {
  static Map<String, dynamic> bodyInfoUtama({
    required String nomorWA,
    required String title,
    required String job,
    required String date,
    required String time,
    required String group,
    required String linkGroup,
    required String from,
    required String fromDivisi,
    required String fromEmail,
  }) {
    return {
      "messaging_product": "whatsapp",
      "to": nomorWA,
      "type": "template",
      "template": {
        "name": "info_utama",
        "language": {"code": "ID"},
        "components": [
          {
            "type": "button",
            "sub_type": "url",
            "index": 0,
            "parameters": [
              {
                "type": "text",
                "text": "6283819045192",
              }
            ]
          },
          {
            "type": "body",
            "parameters": [
              {"type": "text", "text": title},
              {"type": "text", "text": "TMS Group"},
              {"type": "text", "text": job},
              {"type": "text", "text": date},
              {"type": "text", "text": time},
              {"type": "text", "text": group},
              {"type": "text", "text": "Indonesia"},
              {"type": "text", "text": linkGroup},
              {"type": "text", "text": fromDivisi},
              {"type": "text", "text": from},
              {"type": "text", "text": fromEmail},
              {"type": "text", "text": "Terima Kasih"}
            ]
          }
        ]
      }
    };
  }
}
