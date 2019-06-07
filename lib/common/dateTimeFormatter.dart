import 'package:intl/intl.dart';
var _formatter = new DateFormat('dd-MM-yyyy');

String dateTimeToString(DateTime date){
    return _formatter.format(date);
}

DateTime stringToDateTime(String timeString){
    return _formatter.parse(timeString);
}