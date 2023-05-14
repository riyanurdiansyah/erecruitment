import '../src/domain/entities/side_navbar_entity.dart';
import '../src/domain/entities/template_entity.dart';

List<SideNavbarEntity> listSidebar = [
  SideNavbarEntity(
    title: "Home",
    image: "assets/images/sidebar/test.webp",
    route: "home",
    role: 1,
    tipe: "disc",
  ),
  SideNavbarEntity(
    title: "User",
    image: "assets/images/sidebar/test.webp",
    route: "user",
    role: 1,
    tipe: "disc",
  ),
  SideNavbarEntity(
    title: "DISC",
    image: "assets/images/sidebar/test.webp",
    route: "disc",
    role: 1,
    tipe: "disc",
  ),
  SideNavbarEntity(
    title: "Papi Kostick",
    image: "assets/images/sidebar/test.webp",
    route: "papi-kostick",
    role: 1,
    tipe: "papi-kostick",
  ),
  SideNavbarEntity(
    title: "Blast",
    image: "assets/images/sidebar/test.webp",
    route: "blast",
    role: 99,
    tipe: "blast",
  ),
];

List<String> listMenus = [
  "Instruksi",
  "Pertanyaan",
];

List<String> listBlast = [
  "Single",
  "Multiple",
];

List<TemplateEntity> templateBlast = [
  const TemplateEntity(
    name: "Informasi",
    kode: "informasi",
  ),
];
