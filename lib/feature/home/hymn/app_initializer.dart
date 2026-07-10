import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'hymn_models.dart';
import 'hymn_pin_button.dart';

class AppInitializer {
  static late Isar isar;
  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([
      LocalHymnSchema,
      UserHymnPrefSchema,
      NoteFolderSchema,
      UserNoteSchema,
      EditProposalSchema,
    ], directory: dir.path);

    await GlobalPinService().init();
  }
}
