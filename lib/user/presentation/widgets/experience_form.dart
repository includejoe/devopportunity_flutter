import 'package:dev_opportunity/base/presentation/widgets/buttons/dialog_button.dart';
import 'package:dev_opportunity/base/presentation/widgets/buttons/main_button.dart';
import 'package:dev_opportunity/base/presentation/widgets/inputs/date_input.dart';
import 'package:dev_opportunity/base/presentation/widgets/inputs/text_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExperienceForm extends StatefulWidget {
  const ExperienceForm({super.key});

  @override
  State<ExperienceForm> createState() => _ExperienceFormState();
}

class _ExperienceFormState extends State<ExperienceForm> {
  bool _experienceToPresent = true;

  // controllers
  final _companyController = TextEditingController();
  final _jobTitleController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _descriptionController = TextEditingController();

  // focus nodes
  final _companyFocusNode = FocusNode();
  final _jobTitleFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();

  // errors
  String? _companyError;
  String? _jobTitleError;
  String? _startDateError;
  String? _endDateError;
  String? _descriptionError;

  @override
  Widget build(BuildContext context) {
  final theme = Theme.of(context);

    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: theme.colorScheme.background,
        insetPadding: const EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Add Experience",
                  style: theme.textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 25,),
                TextInput(
                  controller: _companyController,
                  textInputType: TextInputType.text,
                  inputAction: TextInputAction.next,
                  enabled: true,
                  label: "Company",
                  placeholder: "ex. XYZ Limited",
                  error: _companyError,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_jobTitleFocusNode);
                  },
                ),
                const SizedBox(height: 15,),
                TextInput(
                  controller: _jobTitleController,
                  textInputType: TextInputType.text,
                  inputAction: TextInputAction.next,
                  enabled: true,
                  label: "Job Title",
                  placeholder: "ex. Software Engineer",
                  error: _jobTitleError,
                  focusNode: _jobTitleFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_jobTitleFocusNode);
                  },
                ),
                const SizedBox(height: 15,),
                DateInput(
                  controller: _startDateController,
                  label: "Start Date",
                  error: _startDateError,
                ),
                const SizedBox(height: 5,),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Present", style: theme.textTheme.bodyMedium),
                    const SizedBox(width: 5,),
                    Switch(
                      activeColor: theme.colorScheme.primary,
                      activeTrackColor: theme.colorScheme.primary.withOpacity(0.4),
                      value: _experienceToPresent,
                      onChanged: (value) {
                        setState(() {
                          _experienceToPresent = value;
                          if(value) {
                            _endDateController.text = "Present";
                          }
                        });
                      }
                    ),
                  ],
                ),
                _experienceToPresent != true ? DateInput(
                  controller: _endDateController,
                  label: "End Date",
                  error: _endDateError,
                ): const SizedBox(),
                _experienceToPresent != true ? const SizedBox(height: 15,): const SizedBox(),
                TextInput(
                  controller: _descriptionController,
                  textInputType: TextInputType.text,
                  inputAction: TextInputAction.done,
                  enabled: true,
                  label: "Description",
                  error: _descriptionError,
                  focusNode: _descriptionFocusNode,
                  maxLines: 5,
                  height: 100,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).unfocus();
                  },
                ),
                const SizedBox(height: 15,),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                        onTap: () {Navigator.pop(context);},
                        child: DialogButton(
                          btnText: "Cancel",
                          height: 40,
                          width: 70,
                          background: Colors.transparent,
                          color: theme.colorScheme.onBackground,
                        )
                    ),
                    const SizedBox(width: 10,),
                    InkWell(
                      onTap: () {},
                      child: const DialogButton(
                        btnText: "Save",
                        height: 40,
                        width: 70
                      )
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
  }
}
