import 'package:etiqa_app/helper/app_constant.dart';
import 'package:etiqa_app/helper/navigation.dart';
import 'package:etiqa_app/pages/home_page.dart';
import 'package:etiqa_app/services/model/to_do_list_model.dart';
import 'package:etiqa_app/widgets/datepicker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditPage extends StatefulWidget {
  final int index;
  const EditPage({Key? key, required this.index}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  //Declaration variables
  TextEditingController titleController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  DateTime? start;
  DateTime? end;

  //Variable to add in model
  TodoListModel addList = TodoListModel();

  //Declaration form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    //Initialize to previous input
    titleController =
        TextEditingController(text: AppConstant.totalList[widget.index].title);
    startDateController = TextEditingController(
        text: AppConstant.totalList[widget.index].startDate);
    endDateController = TextEditingController(
        text: AppConstant.totalList[widget.index].endDate);

    start = DateTime.parse(DateFormat('yyyy-MM-dd')
        .format(DateFormat('dd MMM yyyy').parse(startDateController.text)));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit'),
      ),
      body: body(),
      bottomNavigationBar: confirmButton(widget.index),
    );
  }

  Widget body() {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Status:',
                    style: TextStyle(color: Colors.grey, fontSize: 17),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    AppConstant.totalList[widget.index].status!,
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: AppConstant.totalList[widget.index].status ==
                                'Completed'
                            ? Colors.green
                            : Colors.red),
                  )
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              const Text(
                'To-Do Title',
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                  //save data in addList.title
                  onSaved: (val) => setState(() => addList.title = val),
                  //show chosen date in input box
                  controller: titleController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  //validation message if no input
                  validator: (input) =>
                      input!.isEmpty ? "This field is required" : null,
                  style: const TextStyle(fontSize: 12),
                  //placeholder
                  decoration: const InputDecoration(
                      // hintText: ('Please key in your To-Do title here'),
                      border: OutlineInputBorder())),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Start Date',
              ),
              const SizedBox(
                height: 5,
              ),
              DatePickerWidget(
                //save data in addList.startDate
                onSaved: (val) => setState(() => addList.startDate = val),
                //show chosen date in input box
                controller: startDateController,
                //validation message if no input
                validator: (input) =>
                    input!.isEmpty ? "This field is required" : null,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      //Date before 2020 cannot be selected
                      firstDate: DateTime(2020),
                      //Date after 2025 cannot be selected
                      lastDate: DateTime(2025));

                  if (pickedDate != null) {
                    start = pickedDate;

                    //Format date
                    String formattedDate =
                        DateFormat('dd MMM yyyy').format(pickedDate);

                    setState(() {
                      addList.startDate = formattedDate;
                      startDateController.text = formattedDate;
                    });
                  }
                },
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'End Date',
              ),
              const SizedBox(
                height: 5,
              ),
              DatePickerWidget(
                //save data in addList.endDate
                onSaved: (val) => setState(() => addList.endDate = val),
                //show chosen date in input box
                controller: endDateController,
                //validation message if no input
                validator: (input) =>
                    input!.isEmpty ? "This field is required" : null,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: start!,
                      //Date before startDate cannot be selected
                      firstDate: start!,
                      //Date after 2025 cannot be selected
                      lastDate: DateTime(2025));

                  if (pickedDate != null) {
                    end = pickedDate;
                    String formattedDate =
                        DateFormat('dd MMM yyyy').format(pickedDate);

                    setState(() {
                      endDateController.text = formattedDate;
                      addList.endDate = formattedDate;
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget confirmButton(ind) {
    return GestureDetector(
      onTap: () {
        var form = formKey.currentState;

        //Validate blank fields
        if (form!.validate()) {
          form.save();

          end ??= DateTime.parse(DateFormat('yyyy-MM-dd')
              .format(DateFormat('dd MMM yyyy').parse(endDateController.text)));

          //Calculate difference hours and minute between endDate and today's date
          Duration diff = end!.difference(DateTime.now());

          String diffReplace = diff
              .toString()
              .replaceFirst(':', ' hrs ')
              .replaceFirst(':', ' min');

          //Update into model
          setState(() {
            AppConstant.totalList.elementAt(ind).title = addList.title!;
            AppConstant.totalList.elementAt(ind).startDate = addList.startDate!;
            AppConstant.totalList.elementAt(ind).endDate = addList.endDate!;
            AppConstant.totalList.elementAt(ind).timeLeft =
                diffReplace.substring(0, diffReplace.length - 9);
          });

          AppNav.cupertinoPushAndRemoveUntil(
              context: context, route: const MyHomePage());
        }
      },
      child: Container(
        height: 70,
        padding: const EdgeInsets.all(8.0),
        decoration: const BoxDecoration(color: Colors.black),
        child: const Center(
          child: Text(
            'Edit',
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
