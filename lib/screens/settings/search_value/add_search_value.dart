import 'package:flutter/material.dart';
import 'package:flutter_send_whatsapp/constants.dart';
import 'package:flutter_send_whatsapp/controller/search_value_controller.dart';
import 'package:flutter_send_whatsapp/utils/functions.dart';
import 'package:flutter_send_whatsapp/widgets/custom_tex_form_field.dart';
import 'package:flutter_send_whatsapp/widgets/my_app_bar.dart';
import 'package:flutter_send_whatsapp/widgets/my_floating_action_button.dart';
import 'package:get/get.dart';

class AddSearchValue extends StatelessWidget {
  const AddSearchValue({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
      init: SettingsController(),
      builder: (controller) => GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          appBar: const MyAppBar(text: 'إضافة'),
          body: Padding(
            padding: const EdgeInsets.all(25),
            child: Form(
              key: controller.key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextFormField(
                    labelText: labelTextSearchValue,
                    hintText: "",
                    controller: controller.searchValueController,
                    onChanged: (value) async {
                      await controller.isFound(value);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "أملئ الحقل فضلا";
                      }
                      if (controller.isFoundVar) {
                        return "قد تم إدخال هذه القيمة سابقاً";
                      }
                      return null;
                    },
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
          floatingActionButton: MyFloatingActionButton(
            onPressed: () {
              try {
                FocusManager.instance.primaryFocus?.unfocus();
                controller.addSearchValue();
              } catch (e) {
                snackBar("", e.toString());
              }
            },
            text: "حفظ",
            icon: Icons.save,
          ),
        ),
      ),
    );
  }
}
