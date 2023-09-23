import 'package:flutter/material.dart';
import 'package:gideon_ogbonna_portfolio/utils/text_utils.dart';
import 'package:intl/intl.dart';

class DateWidget extends StatelessWidget {
  const DateWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => StreamBuilder(
        stream: Stream.periodic(const Duration(seconds: 1)),
        builder: (BuildContext context, AsyncSnapshot<Object?> snapshot) =>
            Center(
          child: Row(
            children: <Widget>[
              CustomTextView(text:  DateFormat('E, d MMM')
                    .format(DateTime.now())
                    .toUpperCase()
                    .replaceAll('.', ''),)
            ],
          ),
        ),
      );
}