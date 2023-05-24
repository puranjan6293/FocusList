import 'package:flutter/material.dart';
import 'package:rmtmang/boxes.dart';
import 'package:rmtmang/person.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'constants/list_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isTextFieldVisible = false;
  final TextEditingController _name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F5),
      body: isTextFieldVisible == true
          ? SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: TextField(
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            boxPersons.put(
                              'key_${_name.text.length > 50 ? _name.text.substring(0, 50) : _name.text}',
                              Person(
                                name: _name.text,
                                // dueTime: DateFormat('dd-MM-yyyy').format(
                                //   DateTime.now(),
                                // ),
                                dueTime: DateTime.now(),
                              ),
                            );
                            isTextFieldVisible = false;
                            _name.clear();
                            Fluttertoast.showToast(
                                msg: "Your task has been saved",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.transparent,
                                textColor: const Color(0xFF1C1C1E),
                                fontSize: 10.0);
                          });
                        },
                        icon: const Icon(
                          Icons.check,
                          color: Color(0xFF1C1C1E),
                        ),
                      ),
                      hintText: 'I want to...',
                      hintStyle: GoogleFonts.roboto(
                        fontSize: 16,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white.withOpacity(0.2),
                        ),
                      ),
                    ),
                    autocorrect: true,
                    style: GoogleFonts.imprima(
                      fontSize: 16,
                      color: const Color(0xFF1C1C1E),
                    ),
                    cursorColor: Colors.black,
                    maxLines: null,
                    controller: _name,
                    onTapOutside: (event) {
                      setState(() {
                        isTextFieldVisible = false;
                        _name.clear();
                      });
                    },
                  ),
                ),
              ),
            )
          : GestureDetector(
              behavior: HitTestBehavior.opaque,
              onDoubleTap: () {
                setState(() {
                  isTextFieldVisible = true;
                });
              },
              child: boxPersons.isNotEmpty
                  ? SafeArea(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        itemCount: boxPersons.length,
                        itemBuilder: (context, index) {
                          Person person = boxPersons.getAt(index);
                          return Dismissible(
                            key: Key(person.name),
                            onDismissed: (direction) {
                              setState(() {
                                boxPersons.deleteAt(index);
                                Fluttertoast.showToast(
                                    msg: "Your task has been deleted",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.transparent,
                                    textColor: const Color(0xFF1C1C1E),
                                    fontSize: 10.0);
                              });
                            },
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: colors[index],
                                radius: 3,
                              ),
                              title: Text(
                                person.name,
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              trailing: Text(
                                // person.dueTime,
                                timeago.format(person.dueTime),
                                style: GoogleFonts.roboto(
                                  fontSize: 9,
                                  color: Colors.black.withOpacity(0.9),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : Center(
                      child: Text(
                        "Double Tap to add & \n Swipe to delete",
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                    ),
            ),
    );
  }
}
