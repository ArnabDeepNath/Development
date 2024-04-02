import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:excel/excel.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:open_file/open_file.dart';

void createExcelFile() async {
  if (Platform.isAndroid) {
    var status = await Permission.storage.status;
    if (status.isGranted) {
      var excel = Excel.createExcel();

      for (int i = 1; i <= 17; i++) {
        var sheet = excel['Sheet$i'];

        // Set column headers
        sheet.appendRow([
          TextCellValue('Column 1'),
          TextCellValue('Column 2'),
          TextCellValue('Column 3'),
        ]);

        // Add data to the sheet
        sheet.appendRow([
          TextCellValue('Data 1'),
          TextCellValue('Data 2'),
          TextCellValue('Data 3')
        ]);
        sheet.appendRow([
          TextCellValue('Data 4'),
          TextCellValue('Data 5'),
          TextCellValue('Data 6')
        ]);
        sheet.appendRow([
          TextCellValue('Data 7'),
          TextCellValue('Data 8'),
          TextCellValue('Data 9')
        ]);

        // Keep cells blank (by not adding data)

        // Add columns (by adding empty cells to each row)
        for (int col = 4; col <= 6; col++) {
          for (int row = 0; row < sheet.maxRows; row++) {
            var cell = sheet.cell(
                CellIndex.indexByColumnRow(rowIndex: row, columnIndex: col));
            cell.value = TextCellValue(''); // Empty cell
          }
        }
      }

      // Save the Excel file
      String downloadDir = '/storage/emulated/0/Download/';
      String filePath = '$downloadDir/excel2.xlsx';
      List<int>? fileBytes = excel.save();
      if (fileBytes != null) {
        File file = File(filePath);
        if (await file.exists()) {
          await file.delete();
        }
        await file.create(recursive: true);
        await file.writeAsBytes(fileBytes);
        print('Permission granted');
        // Open the file
        OpenFile.open(filePath);
      }
    } else if (status.isDenied ||
        status.isRestricted ||
        status.isPermanentlyDenied) {
      print('Permission denied');
    } else {
      // Request permission
      var status = await Permission.storage.request();
      // Handle permission status
      if (status.isGranted) {
        // Permission granted
        // Call createExcelFile() again
        createExcelFile();
      } else {
        print('Permission denied');
      }
    }
  } else {
    print('This functionality is only available on Android');
  }
}
