import 'package:flutter/material.dart';
import 'package:political_poster_app/src/common/helpers/size.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SizeHelper s = SizeHelper(context);
    return Center(
      child: SizedBox(
        height: s.hHelper(2.5),
        width: s.hHelper(2.5),
        child: const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
        ),
      ),
    );
  }
}
