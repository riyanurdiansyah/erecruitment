class AppRequestWA {
  static Map<String, dynamic> bodyInformasiWithImageTemplate({
    required String nomorWA,
    required String image,
    required String title,
    required String job,
    required String date,
    required String time,
    required String group,
    required String linkGroup,
    required String from,
  }) {
    return {
      "messaging_product": "whatsapp",
      "recipient_type": "individual",
      "to": nomorWA,
      "type": "template",
      "template": {
        "name": "informasi",
        "language": {
          "code": "id",
        },
        "components": [
          {
            "type": "header",
            "parameters": [
              {
                "type": "image",
                "image": {
                  "link": image,
                }
              }
            ]
          },
          {
            "type": "body",
            "parameters": [
              {
                "type": "text",
                "text": title,
              },
              {
                "type": "text",
                "text": job,
              },
              {
                "type": "text",
                "text": date,
              },
              {
                "type": "text",
                "text": time,
              },
              {
                "type": "text",
                "text": group,
              },
              {
                "type": "text",
                "text": linkGroup,
              },
              {
                "type": "text",
                "text": from,
              }
            ]
          }
        ]
      }
    };
  }
}
