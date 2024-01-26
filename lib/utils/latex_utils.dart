import 'dart:developer';

class LatexUtils {
  //显示转换
  //参考：https://www.mathjax.org/#demo
  static String convertVersion(String content) {
    try {
      String parseLatex = content
          .replaceAll(r"$$", r'$')
          .replaceAll(r"\[", r'~begin~')
          .replaceAll(r"\]", r'~end~')
          .replaceAll(r"\(", r'~begin~')
          .replaceAll(r"\)", r'~end~');

      RegExp exp = RegExp(r'~begin~([^]*?)~end~');

      List<String> latexList = [];

      exp.allMatches(parseLatex).forEach((element) {
        String latex = element[0]!
            .replaceAll("\n", "")
            .replaceAll("~begin~", r"$")
            .replaceAll("~end~", r"$");
        latexList.add(latex);
      });

      for (String element in latexList) {
        parseLatex = parseLatex.replaceFirst(exp, element);
      }
      return parseLatex;
    } catch (e) {
      log("转义失败");
      return "";
    }
  }
}
