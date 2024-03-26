import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';

part 'settings.freezed.dart';
part 'settings.g.dart';

enum AthanSoundSettings { silent, vibrate, sound }

enum JuristicSchool { standard, hanafi }

@Freezed()
@Collection(ignore: { 'copyWith','props'})
class Settings with _$Settings {
  const factory Settings({
    int? method,
    String? language,
    @Index() @Default('SETTINGS') String? name,
    @Default('mishary_alAfasi_fajr.mp3') String fajrAthan,
    @Default('mishary_alAfasi.mp3') String regularAthan,
    @enumerated @Default(JuristicSchool.standard) JuristicSchool juristicSchool,
    @enumerated
    @Default(AthanSoundSettings.sound)
    AthanSoundSettings fajrAthanSoundsSettings,
    @enumerated
    @Default(AthanSoundSettings.silent)
    AthanSoundSettings sharooqAthanSoundSettings,
    @enumerated
    @Default(AthanSoundSettings.sound)
    AthanSoundSettings dhuhrAthanSoundSettings,
    @enumerated
    @Default(AthanSoundSettings.sound)
    AthanSoundSettings asrAthanSoundSettings,
    @enumerated
    @Default(AthanSoundSettings.sound)
    AthanSoundSettings maghribAthanSoundSettings,
    @enumerated
    @Default(AthanSoundSettings.sound)
    AthanSoundSettings ishaAthanSoundSettings,
    @Default(0) int fajrOffsetDisplay,
    @Default(0) int sharooqOffsetDisplay,
    @Default(0) int dhuhrOffsetDisplay,
    @Default(0) int asrOffsetDisplay,
    @Default(0) int maghribOffsetDisplay,
    @Default(0) int ishaOffsetDisplay,
  }) = _Settings;
  const Settings._();
  Id get isarId => 0;
}
// Map<String, int> required authorities = {
//      'University of Islamic Sciences, Karachi': 1,
//      'Islamic Society of North America': 2,
//      'Muslim World League': 3,
//      'Umm Al-Qura University, Makkah': 4,
//      'Egyptian General Authority of Survey': 5,
//      'Institute of Geophysics, University of Tehran': 7,
//      'Gulf Region': 8,
//      'Kuwait': 9,
//      ' Qatar': 10,
//      ' Majlis Ugama Islam Singapura, Singapore': 11,
//      ' Union Organization islamic de France': 12,
//      ' Diyanet İşleri Başkanlığı, Turkey': 13,
//      ' Spiritual Administration of Muslims of Russia': 14,
//      ' Moonsighting Committee Worldwide (also requires shafaq parameter)': 15,
//      ' Dubai (unofficial)': 16,
//    };

//Map<String, String> athanReceiters = {
//     'Mishary-AlAfasi': 'mishary_alAfasi.mp3',
//     'Islam Subhy': 'IslamSubhy.mp3',
//   };
