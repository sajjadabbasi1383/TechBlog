import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:tech_blog/controller/pick_file_controller.dart';

PickFileController pickFileController = Get.put(PickFileController());


Future pickFile() async {

  FilePickerResult? result =
      await FilePicker.platform.pickFiles(type: FileType.image,);
  pickFileController.file.value = result!.files.first;
}