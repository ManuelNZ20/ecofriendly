class SizesApp {
  static SizesLoginApp sizesLoginApp = SizesLoginApp();
  static SizesCartScreen sizesCartScreen = SizesCartScreen();
}

class SizesLoginApp {
  double get kBorderRadious => 10;
}

class SizesCartScreen {
  double get borderRadious => 10.0;
  double get wBorderSide => 2.0;
  double get wCard => 200.0;
  double get hCard => 260.0;
  double get paddingCard => 10.0;
  double get wImgCard => 90;
  double get hImgCard => 120;
  double get chipPercentageBorderRadious => 50.0;
}
