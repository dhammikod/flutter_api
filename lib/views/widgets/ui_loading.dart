part of 'widgets.dart';

class UILoading {
  static Container bigloadingBlock() {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: double.infinity,
      color: Colors.black12,
      child: SpinKitFadingCircle(
        size: 50,
        color: Colors.purple,
      ),
    );
  }

  static Container smallloadingBlock() {
    return Container(
      alignment: Alignment.center,
      width: 30,
      height: 30,
      child: SpinKitFadingCircle(
        size: 30,
        color: Colors.blue,
      ),
    );
  }
}
