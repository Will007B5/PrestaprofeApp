import 'package:flutter/material.dart';

import 'package:native_pdf_renderer/native_pdf_renderer.dart';

class PdfHelper {

  //Future que retorna en imagen la primera pagina de un pdf
  static Future loadPreviewFromFile({
    required String path,
  }) async {
    final document = await PdfDocument.openFile(path);
    final page = await document.getPage(1);
    final pageImage = await page.render(width: page.width, height: page.height);
    await page.close();
    return pageImage!.bytes;
  }

}