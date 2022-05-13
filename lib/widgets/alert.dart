import 'package:flutter/material.dart';

enum AlertType { success, error, warning, info }

class AlertComponent extends StatelessWidget {
  final AlertType type;
  final String msg;
  final EdgeInsets? margin;

  AlertComponent(
      {Key? key,
      this.type = AlertType.success,
      required this.msg,
      this.margin = const EdgeInsets.symmetric(horizontal: 25)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: msg.isNotEmpty,
      child: Container(
        margin: margin,
        decoration: BoxDecoration(
          color: getColor(),
          borderRadius: BorderRadius.horizontal(
              left: Radius.circular(5), right: Radius.circular(5)),
        ),
        child: ListTile(
          leading: getIcon(),
          title: Text(
            msg.trim(),
            style: TextStyle(color: Colors.white),
          ),
          minLeadingWidth: 5,
        ),
      ),
    );
  }

  Icon getIcon(){
      switch (type) {
        case AlertType.success:
          return Icon(
            Icons.check_circle_outline,
            color: Colors.white,
          );
        case AlertType.error:
          return Icon(
            Icons.error_outline,
            color: Colors.white,
          );
        case AlertType.warning:
          return Icon(
            Icons.warning_amber_outlined,
            color: Colors.white,
          );
        default:
          return Icon(
            Icons.info_outlined,
            color: Colors.white,
          );
      }
  }

  Color getColor() {
    switch (type) {
      case AlertType.success:
        return Colors.green;
      case AlertType.error:
        return Colors.red;
      case AlertType.warning:
        return Colors.orange;
      case AlertType.info:
        return Colors.blue;
      default:
        return Colors.lightBlueAccent;
    }
  }
}
