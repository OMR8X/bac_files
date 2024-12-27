import 'package:bac_files/core/functions/extractors/extract_relevent_element_function.dart';
import 'package:bac_files/core/functions/formatters/normalize_file_name.dart';
import 'package:bac_files/features/managers/domain/entities/file_category.dart';
import 'package:bac_files/features/managers/domain/entities/file_material.dart';
import 'package:bac_files/features/managers/domain/entities/file_section.dart';
import 'package:bac_files/features/managers/domain/entities/managers.dart';
import 'package:bac_files/features/managers/domain/entities/school.dart';
import 'package:bac_files/features/managers/domain/entities/teacher.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  ///
  late List<FileCategory>? categories;
  late FileMaterial? material;
  late FileSection? section;
  late FileTeacher? teacher;
  late FileSchool? school;
  //
  late FileManagers managers;

  ///
  late List<String> names;

  ///
  setUpAll(() {
    //
    categories = [];
    material = null;
    section = null;
    teacher = null;
    //
    names = [
      ("أ_هُمام_نون_و_القلم_2024_بوت_مكتبتي_التعليمية"),
      ("الاشعة_بدقة_كتابية_عاليه_و_تفصيل_لكل_شي_ساعد_{رياضيات_مع_أ_طاهر}"),
      ("النماذج_الشاملة_للإستاذ_فارس_جقل_كاملة_مع_الحل"),
      ("بكالوريا علمي - إنكليزي أنشطة "),
      ("دليل المعلم الجزء الأول رياضيات "),
      ("دليل المعلم فرنسي 2022"),
      ("دليل كيمياء بكالوريا -حديث-"),
      ("قواعد_تأسيس_+_شاملة_دون_حل_قواعد_فقط"),
      ("كتاب الكيمياء بكالوريا ٢٠٢٠"),
      ("كتاب_الوطنية_٢٠٢٢_التجمع_التعليمي"),
      ("مذاكرات+امتحانات_اللغة_الإنكليزية_الفصل_الأول_ثا_السعادة"),
      ("منهاج_اللغة_الفرنسية_نهائي_بكالوريا_"),
      ("مواضيع ثانوية السعادة"),
      ("مواضيع_اللغة_الإنكليزية_أ_مؤيد_حمدان"),
      ("نوطة التكامل لحسان البيطار"),
      ("نوطة_مدرسة_السعادة_للغة_الإنكليزية")
    ];
    //
    managers = FileManagers(
      categories: const [
        FileCategory(name: "قواعد"),
        FileCategory(name: "قوانين"),
        FileCategory(name: "اختبارات"),
        FileCategory(name: "حلول"),
        FileCategory(name: "شروح"),
        FileCategory(name: "أسئلة"),
        FileCategory(name: "أسئلة دورات"),
        FileCategory(name: "نوط"),
        FileCategory(name: "نماذج"),
        FileCategory(name: "رسومات"),
        FileCategory(name: "مكثفات"),
        FileCategory(name: "كتب"),
        FileCategory(name: "ملحق"),
        FileCategory(name: "سلم"),
        FileCategory(name: "ملخص"),
        FileCategory(name: "مراجعة"),
        FileCategory(name: "مسائل"),
        FileCategory(name: "أفكار"),
      ],
      materials: const [
        FileMaterial(name: "الرياضيات"),
        FileMaterial(name: "الفيزياء"),
        FileMaterial(name: "الكيمياء"),
        FileMaterial(name: "علم الأحياء"),
        FileMaterial(name: "التربية الوطنية"),
        FileMaterial(name: "اللغة العربية"),
        FileMaterial(name: "اللغة الإنجليزية"),
        FileMaterial(name: "اللغة الروسية"),
        FileMaterial(name: "اللغة الفرنسية"),
        FileMaterial(name: "التربية الدينية الإسلامية"),
        FileMaterial(name: "التربية الدينية المسيحية"),
        FileMaterial(name: "الجغرافيا"),
        FileMaterial(name: "التاريخ"),
        FileMaterial(name: "الفلسفة"),
      ],
      schools: const [],
      sections: const [
        FileSection(name: 'الفرع العلمي'),
        FileSection(name: 'الفرع الأدبي'),
      ],
      teachers: const [
        FileTeacher(name: "'فارس جغل'"),
        FileTeacher(name: "'وضاح معلا'"),
        FileTeacher(name: "'عبد العزيز شملان'"),
        FileTeacher(name: "'عادل طنيش'"),
        FileTeacher(name: "'علي شباط'"),
        FileTeacher(name: "'محمد لبابيدي'"),
        FileTeacher(name: "'فراس النجار'"),
        FileTeacher(name: "'أمير سكيكر'"),
        FileTeacher(name: "'همام حمدان'"),
        FileTeacher(name: "'عبد اللطيف ضعيف'"),
        FileTeacher(name: "'رامي تكريتي'"),
        FileTeacher(name: "'رابح الخليل'"),
        FileTeacher(name: "'طارق غبرا'"),
        FileTeacher(name: "'سامح الغلاب'"),
        FileTeacher(name: "'أسامة الحصري'"),
        FileTeacher(name: "'هند حج حسن'"),
        FileTeacher(name: "'أحمد إسماعيل'"),
      ],
    );
  });

  test(
    "testing the formatting of the file name.",
    () {
      for (var n in names) {
        ///
        /// [ Normalize the File name ]
        String actual = normalizeFileName(n);

        /// debugging

        ///
        /// [ Extract Categories ]
        // categories = extractRelevantElement<>(actual, managers.categories);
        // expect(categories, isA<List>());

        ///
        /// [ Extract Material ]

        material = extractRelevantElement<FileMaterial>(actual, managers.materials, (m) {
          return m.name;
        });

        ///
        /// [ Extract School ]

        school = extractRelevantElement<FileSchool>(actual, managers.schools, (e) {
          return e.name;
        });

        ///
        /// [ Extract Section ]

        section = extractRelevantElement<FileSection>(actual, managers.sections, (e) {
          return e.name;
        });

        ///
        /// [ Extract Teacher ]

        teacher = extractRelevantElement<FileTeacher>(actual, managers.teachers, (e) {
          return e.name;
        });
        //
        //
      }
    },
  );
}
