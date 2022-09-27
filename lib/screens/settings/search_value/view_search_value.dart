import 'package:flutter/material.dart';
import 'package:flutter_send_whatsapp/controller/search_value_controller.dart';
import 'package:flutter_send_whatsapp/screens/settings/search_value/add_search_value.dart';
import 'package:flutter_send_whatsapp/screens/settings/search_value/edit_search_value.dart';
import 'package:flutter_send_whatsapp/utils/functions.dart';
import 'package:flutter_send_whatsapp/widgets/my_floating_action_button.dart';
import 'package:get/get.dart';

class ViewSearchValue extends StatelessWidget {
  const ViewSearchValue({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
      init: SettingsController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: const Text('كلمات البحث'),
        ),
        body: ListView.separated(
          itemCount: controller.searchVluesList.length,
          itemBuilder: ((context, index) {
            return Dismissible(
              key: UniqueKey(),
              confirmDismiss: (DismissDirection dismissDirection) async {
                switch (dismissDirection) {
                  case DismissDirection.endToStart:
                  case DismissDirection.startToEnd:
                    return await controller.showConfirmationDialog(
                            context, index) ==
                        true;
                  case DismissDirection.horizontal:
                  case DismissDirection.vertical:
                  case DismissDirection.up:
                  case DismissDirection.down:
                  case DismissDirection.none:
                    break;
                }
                return false;
              },
              background: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                color: Colors.red,
                alignment: Alignment.centerLeft,
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              direction: DismissDirection.startToEnd,
              child: ListTile(
                trailing: GestureDetector(
                    onTap: () {
                      controller.showConfirmationDialog(context, index);
                    },
                    child: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    )),
                title: Text(controller.searchVluesList[index]),
                onTap: () {
                  controller.updateIndex = index;
                  controller.searchValueController.text =
                      controller.searchVluesList[index].toString();
                  goTo(context, const EditSearchValue());
                },
              ),
            );
          }),
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              color: Colors.black,
            );
          },
        ),
        floatingActionButton: MyFloatingActionButton(
          onPressed: () {
            controller.searchValueController.clear();
            goTo(context, const AddSearchValue());
          },
          text: "إضافة",
          icon: Icons.add,
        ),
      ),
    );
  }
}
