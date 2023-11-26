import 'package:erecruitment/src/models/sidebar_m.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

final customToolBarList = [
  ToolBarStyle.video,
  ToolBarStyle.bold,
  ToolBarStyle.italic,
  ToolBarStyle.align,
  ToolBarStyle.color,
  ToolBarStyle.background,
  ToolBarStyle.listBullet,
  ToolBarStyle.listOrdered,
  ToolBarStyle.addTable,
  ToolBarStyle.editTable,
  ToolBarStyle.link,
  ToolBarStyle.underline,
  ToolBarStyle.size,
];

final localSidebars = [
  SidebarM(
    route: "",
    id: "d",
    role: [0, 1],
    title: "Test",
    created: "",
    updated: "",
    submenus: [],
  ),
  SidebarM(
    route: "",
    id: "a",
    role: [0, 1],
    title: "Kelola",
    created: "",
    updated: "",
    submenus: [
      SidebarM(
        route: "kelola-user",
        id: "b",
        role: [0, 1],
        title: "User",
        created: "",
        updated: "",
        submenus: [
          SidebarM(
            route: "kelola-test",
            id: "c",
            role: [0, 1],
            title: "Test X",
            created: "",
            updated: "",
            submenus: [
              SidebarM(
                route: "kelola-test",
                id: "c",
                role: [0, 1],
                title: "Test Z",
                created: "",
                updated: "",
                submenus: [],
              )
            ],
          )
        ],
      ),
      SidebarM(
        route: "kelola-test",
        id: "c",
        role: [0, 1],
        title: "Test",
        created: "",
        updated: "",
        submenus: [
          SidebarM(
            route: "kelola-test",
            id: "c",
            role: [0, 1],
            title: "Test U",
            created: "",
            updated: "",
            submenus: [],
          )
        ],
      )
    ],
  ),
];
