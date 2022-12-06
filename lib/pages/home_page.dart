import 'package:etiqa_app/helper/app_constant.dart';
import 'package:etiqa_app/helper/modal.dart';
import 'package:etiqa_app/helper/navigation.dart';
import 'package:etiqa_app/pages/add_new.dart';
import 'package:etiqa_app/pages/edit_page.dart';
import 'package:etiqa_app/services/model/to_do_list_model.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool value = false;
  List<bool>? isChecked;
  TodoListModel addList = TodoListModel();

  @override
  void initState() {
    isChecked = List<bool>.filled(AppConstant.totalList.length, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('To-Do List'),
        ),
        body: body(),
        bottomNavigationBar: addButton());
  }

  Widget body() {
    return AppConstant.totalList.isEmpty
        ? SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                //Display text if no data in totalList
                Text("Click on '+' button tu add To-Do list"),
              ],
            ),
          )
        : ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    headerTitle(),
                    const SizedBox(
                      height: 16,
                    ),
                    Column(
                      children:

                          //Iterate based on totalList length
                          List.generate(AppConstant.totalList.length, (index) {
                        return GestureDetector(
                          //To delete item
                          onLongPress: () {
                            Modal.actionModal(
                                context: context,
                                title: 'Are you sure you want to delete?',
                                content:
                                    Text(AppConstant.totalList[index].title!),
                                onConfirm: () {
                                  AppNav.cupertinoPop(context: context);
                                  //Delete by ID
                                  AppConstant.totalList.removeWhere((element) {
                                    return element.id ==
                                        AppConstant.totalList[index].id;
                                  });
                                  //Refresh UI after deleting element from list
                                  setState(() {
                                    //Delete one item
                                    AppConstant.totalList.length - 1;
                                  });
                                });
                          },
                          //Navigate to Edit Page
                          onTap: () => AppNav.cupertinoPush(
                              context: context, route: EditPage(index: index)),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16.0),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.shade300,
                                          blurRadius: 20,
                                          offset: const Offset(0, 5)),
                                    ],
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10))),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //Title
                                    Text(
                                      AppConstant.totalList[index].title!,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        //Start Date
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Start Date',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              AppConstant
                                                  .totalList[index].startDate!,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                        //End Date
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'End Date',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              AppConstant
                                                  .totalList[index].endDate!,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                        //Time Left
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Time Left',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              AppConstant
                                                  .totalList[index].timeLeft!,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 230, 212, 162)
                                          .withOpacity(0.5),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade300,
                                        blurRadius: 10,
                                        offset: const Offset(0, 5)),
                                  ],
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    //Status of 'Incomplete' or 'Completed'
                                    Expanded(
                                      child: Row(
                                        children: [
                                          const Text(
                                            'Status',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            AppConstant
                                                .totalList[index].status!,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ),
                                    //Checkbox
                                    Expanded(
                                      child: CheckboxListTile(
                                          title: const Text(
                                            'Tick if completed',
                                            textAlign: TextAlign.right,
                                          ),
                                          contentPadding: EdgeInsets.zero,
                                          dense: true,
                                          value: isChecked![index],
                                          onChanged: (val) {
                                            setState(
                                              () {
                                                isChecked![index] = val!;

                                                //If ticked, status updated
                                                isChecked![index]
                                                    ? AppConstant
                                                        .totalList[index]
                                                        .status = 'Completed'
                                                    : AppConstant
                                                        .totalList[index]
                                                        .status = 'Incomplete';
                                              },
                                            );
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              )
                            ],
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              )
            ],
          );
  }

  Widget headerTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Currently you have ${AppConstant.totalList.length} to-do items',
        ),
        const Text(
          'If you want to delete the item, press long on the item box.',
        )
      ],
    );
  }

  //Add Button to add To Do List
  Widget addButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () =>
            AppNav.cupertinoPush(context: context, route: const AddNewPage()),
        child: const Icon(Icons.add, color: Colors.white),
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: const EdgeInsets.all(15),
        ),
      ),
    );
  }
}
