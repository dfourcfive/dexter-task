import 'package:form_field_validator/form_field_validator.dart';

class AppFormValidation {
  String? Function(String?) titleValidator = MultiValidator([
    RequiredValidator(errorText: "Title is required"),
  ]);
  String? Function(String?) descriptionlValidator = MultiValidator([
    RequiredValidator(errorText: "description is required"),
  ]);
}
