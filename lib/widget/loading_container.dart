import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

///进度条组件
class LoadingContainer extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final bool cover;

  const LoadingContainer(
      {@required this.isLoading,
      this.cover = false,
      @required this.child});

  @override
  Widget build(BuildContext context) {
    return !cover
      ? !isLoading ? child : _loadingView
      : Stack(
        children: <Widget>[child, isLoading ? _loadingView : null],
      );
  }

  Widget get _loadingView {
    return Center(
      child: SpinKitThreeBounce(
        color: Colors.blueAccent,
        size: 30.0,
      ),
    );
  }
}
