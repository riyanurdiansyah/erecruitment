class AppRequestWA {
  static Map<String, dynamic> bodyInfoUtama({
    required String undangan,
    required String tempat,
    required String job,
    required String date,
    required String time,
    required String group,
    required String keterangan,
    required String linkGroup,
    required String from,
    required String fromDivisi,
    required String fromEmail,
    required String nomorWA,
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
              {"type": "text", "text": undangan},
              {"type": "text", "text": tempat},
              {"type": "text", "text": job},
              {"type": "text", "text": date},
              {"type": "text", "text": time},
              {"type": "text", "text": group},
              {"type": "text", "text": keterangan},
              {"type": "text", "text": linkGroup},
              {"type": "text", "text": from},
              {"type": "text", "text": fromDivisi},
              {"type": "text", "text": fromEmail},
              {"type": "text", "text": "Terima Kasih"}
            ]
          }
        ]
      }
    };
  }
}
