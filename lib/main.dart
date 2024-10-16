import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Translate',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Translate Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? _selectedCountry;
  bool isConnected = true;
  String transext = 'Translated text will be appear here...';
  String? _targetCountry;
  List<String> _countryList = [
    "Afrikaans",
    "Arabic",
    "Belarusian",
    "Bulgarian",
    "Bengali",
    "Catalan",
    "Czech",
    "Welsh",
    "Danish",
    "German",
    "Greek",
    "English",
    "Esperanto",
    "Spanish",
    "Estonian",
    "Persian",
    "Finnish",
    "French",
    "Irish",
    "Galician",
    "Gujarati",
    "Hebrew",
    "Hindi",
    "Croatian",
    "Hungarian",
    "Indonesian",
    "Icelandic",
    "Italian",
    "Japanese",
    "Georgian",
    "Kannada",
    "Korean",
    "Lithuanian",
    "Latvian",
    "Macedonian",
    "Marathi",
    "Malay",
    "Maltese",
    "Dutch",
    "Norwegian",
    "Polish",
    "Portuguese",
    "Romanian",
    "Russian",
    "Slovak",
    "Slovenian",
    "Albanian",
    "Swedish",
    "Swahili",
    "Tamil",
    "Telugu",
    "Thai",
    "Tagalog",
    "Turkish",
    "Ukrainian",
    "Urdu",
    "Vietnamese",
    "Chinese",
  ];
  final Map<String, TranslateLanguage> _languageMap = {
    "Afrikaans": TranslateLanguage.afrikaans,
    "Arabic": TranslateLanguage.arabic,
    "Belarusian": TranslateLanguage.belarusian,
    "Bulgarian": TranslateLanguage.bulgarian,
    "Bengali": TranslateLanguage.bengali,
    "Catalan": TranslateLanguage.catalan,
    "Czech": TranslateLanguage.czech,
    "Welsh": TranslateLanguage.welsh,
    "Danish": TranslateLanguage.danish,
    "German": TranslateLanguage.german,
    "Greek": TranslateLanguage.greek,
    "English": TranslateLanguage.english,
    "Esperanto": TranslateLanguage.esperanto,
    "Spanish": TranslateLanguage.spanish,
    "Estonian": TranslateLanguage.estonian,
    "Persian": TranslateLanguage.persian,
    "Finnish": TranslateLanguage.finnish,
    "French": TranslateLanguage.french,
    "Irish": TranslateLanguage.irish,
    "Galician": TranslateLanguage.galician,
    "Gujarati": TranslateLanguage.gujarati,
    "Hebrew": TranslateLanguage.hebrew,
    "Hindi": TranslateLanguage.hindi,
    "Croatian": TranslateLanguage.croatian,
    "Hungarian": TranslateLanguage.hungarian,
    "Indonesian": TranslateLanguage.indonesian,
    "Icelandic": TranslateLanguage.icelandic,
    "Italian": TranslateLanguage.italian,
    "Japanese": TranslateLanguage.japanese,
    "Georgian": TranslateLanguage.georgian,
    "Kannada": TranslateLanguage.kannada,
    "Korean": TranslateLanguage.korean,
    "Lithuanian": TranslateLanguage.lithuanian,
    "Latvian": TranslateLanguage.latvian,
    "Macedonian": TranslateLanguage.macedonian,
    "Marathi": TranslateLanguage.marathi,
    "Malay": TranslateLanguage.malay,
    "Maltese": TranslateLanguage.maltese,
    "Dutch": TranslateLanguage.dutch,
    "Norwegian": TranslateLanguage.norwegian,
    "Polish": TranslateLanguage.polish,
    "Portuguese": TranslateLanguage.portuguese,
    "Romanian": TranslateLanguage.romanian,
    "Russian": TranslateLanguage.russian,
    "Slovak": TranslateLanguage.slovak,
    "Slovenian": TranslateLanguage.slovenian,
    "Albanian": TranslateLanguage.albanian,
    "Swedish": TranslateLanguage.swedish,
    "Swahili": TranslateLanguage.swahili,
    "Tamil": TranslateLanguage.tamil,
    "Telugu": TranslateLanguage.telugu,
    "Thai": TranslateLanguage.thai,
    "Tagalog": TranslateLanguage.tagalog,
    "Turkish": TranslateLanguage.turkish,
    "Ukrainian": TranslateLanguage.ukrainian,
    "Urdu": TranslateLanguage.urdu,
    "Vietnamese": TranslateLanguage.vietnamese,
    "Chinese": TranslateLanguage.chinese,
  };

  final TextEditingController controller = TextEditingController();

  Future<void> translateText(String text, TranslateLanguage sourceLanguage,
      TranslateLanguage targetLanguage) async {
    try {
      // Show progress dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
              child: LoadingAnimationWidget.threeArchedCircle(
            color: Colors.white,
            size: 40,
          ));
        },
      );

      final _onDeviceTranslator = OnDeviceTranslator(
        sourceLanguage: sourceLanguage,
        targetLanguage: targetLanguage,
      );

      final translatedText = await _onDeviceTranslator.translateText(text);

      setState(() {
        transext = translatedText;
      });

      // Hide progress dialog
      Navigator.of(context).pop();
    } catch (e) {
      // Hide progress dialog if there's an error
      Navigator.of(context).pop();
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    _countryList.sort();
    return Scaffold(

      backgroundColor: const Color(0xFF638ECB),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color(0xFF395886),
        title:  Text(
          'Flutter Translate',
          style: GoogleFonts.numans(color: Colors.white,fontSize:20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.4,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButton<String>(
                      menuMaxHeight: 500,
                      hint: Text(
                        'Languages',
                        style: GoogleFonts.numans(color: Colors.white),
                      ),
                      underline: SizedBox.shrink(),
                      icon: Icon(
                        Icons.add,
                        color: Colors.transparent,
                      ),
                      dropdownColor: Color(0xFF395886),
                      elevation: 5,
                      style: const TextStyle(color: Colors.white),
                      value: _selectedCountry,
                      items: _countryList.map((String item) {
                        return DropdownMenuItem<String>(
                          alignment: AlignmentDirectional.centerStart,
                          value: item,
                          child: Text(item,style: GoogleFonts.numans(color: Colors.white),),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedCountry = newValue;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Icon(Icons.keyboard_double_arrow_right,
                      size: 24, color: Colors.white),
                  const SizedBox(width: 5),
                  Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.4,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButton<String>(
                      menuMaxHeight: 500,
                      hint: Text(
                        'Languages',
                        style: GoogleFonts.numans(color: Colors.white),
                      ),
                      icon: Icon(
                        Icons.add,
                        color: Colors.transparent,
                      ),
                      underline: SizedBox.shrink(),
                      dropdownColor: Color(0xFF395886),
                      elevation: 5,
                      style: const TextStyle(color: Colors.white),
                      value: _targetCountry,
                      items: _countryList.map((String item) {
                        return DropdownMenuItem<String>(
                          alignment: AlignmentDirectional.centerStart,
                          value: item,
                          child: Row(
                            children: [
                              Text(item,style: GoogleFonts.numans(color: Colors.white),),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _targetCountry = newValue;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              height: MediaQuery.of(context).size.height * 0.3,
              child: Column(children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                    ),
                    maxLines: null,
                    textAlign: TextAlign.start,
                    style: GoogleFonts.afacad(color: Colors.black,fontSize:17),
                    cursorHeight: 20,
                    cursorColor: Color(0xFF395886),
                  ),
                ),
                Container(
                  color: Color(0xFF638ECB),
                  height: 0.3,
                  width: double.infinity,
                ),
                Container(
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        InkWell(
                            onTap: () {
                              if (controller.text.isNotEmpty) {
                                Clipboard.setData(ClipboardData(
                                    text: controller.text
                                        .toString())); // Copy to clipboard
                                Fluttertoast.showToast(
                                    msg: 'Copied to clipboard',
                                    fontSize: 16,
                                    gravity: ToastGravity.BOTTOM,
                                    textColor: Colors.white,
                                    toastLength: Toast.LENGTH_SHORT,
                                    backgroundColor: Color(0xFF395886));
                              } else {
                                Fluttertoast.showToast(
                                    msg: 'Nothing to copy',
                                    fontSize: 16,
                                    gravity: ToastGravity.BOTTOM,
                                    textColor: Colors.white,
                                    toastLength: Toast.LENGTH_SHORT,
                                    backgroundColor: Color(0xFF395886));
                              }
                            },
                            child: Icon(
                              Icons.copy,
                              color: Color(0xFF638ECB),
                              size: 23,
                            )),
                        SizedBox(
                          width: 14,
                        ),
                        // InkWell(
                        //     onTap: () {
                        //         if(controller.text.isNotEmpty){
                        //           _speak(controller.text.toString());
                        //         }
                        //     },
                        //     child: Icon(
                        //       Icons.record_voice_over_rounded,
                        //       color: Color(0xFF638ECB),
                        //       size: 26,
                        //     ))
                      ],
                    ),
                  ),
                ),
              ]),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                if (controller.text.isEmpty) {
                  Fluttertoast.showToast(
                      msg: 'Please enter text to translate',
                      fontSize: 16,
                      gravity: ToastGravity.BOTTOM,
                      textColor: Colors.white,
                      toastLength: Toast.LENGTH_SHORT,
                      backgroundColor: Color(0xFF395886));
                } else if (_selectedCountry == null) {
                  Fluttertoast.showToast(
                      msg: 'Please select the source language',
                      fontSize: 16,
                      gravity: ToastGravity.BOTTOM,
                      textColor: Colors.white,
                      toastLength: Toast.LENGTH_SHORT,
                      backgroundColor: Color(0xFF395886));
                } else if (_targetCountry == null) {
                  Fluttertoast.showToast(
                      msg: 'Please select the target language',
                      fontSize: 16,
                      gravity: ToastGravity.BOTTOM,
                      textColor: Colors.white,
                      toastLength: Toast.LENGTH_SHORT,
                      backgroundColor: Color(0xFF395886));
                } else {
                  TranslateLanguage sourceLang =
                      _languageMap[_selectedCountry]!;
                  TranslateLanguage targetLang = _languageMap[_targetCountry]!;
                  translateText(controller.text, sourceLang, targetLang);
                }
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                width: 100,
                child: const Center(
                  child: Icon(Icons.arrow_circle_right,
                      color: Colors.white, size: 43),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                color: Color(0xFF395886),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                     Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 182,
                        child: SingleChildScrollView(
                          child: Text(
                            transext,
                            style: GoogleFonts.afacad(color: Colors.white,fontSize:17),
                          ),
                        ),
                      ),
                    ),
                  Container(
                    color: Colors.white,
                    height: 0.2,
                    width: double.infinity,
                  ),
                  Container(
                    height: 40,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                              onTap: () {
                                if (transext.isNotEmpty) {
                                  Clipboard.setData(ClipboardData(
                                      text: transext
                                          .toString())); // Copy to clipboard
                                  Fluttertoast.showToast(
                                      msg: 'Copied to clipboard',
                                      fontSize: 16,
                                      gravity: ToastGravity.BOTTOM,
                                      textColor: Colors.white,
                                      toastLength: Toast.LENGTH_SHORT,
                                      backgroundColor: Color(0xFF395886));
                                } else {
                                  Fluttertoast.showToast(
                                      msg: 'Nothing to copy',
                                      fontSize: 16,
                                      gravity: ToastGravity.BOTTOM,
                                      textColor: Colors.white,
                                      toastLength: Toast.LENGTH_SHORT,
                                      backgroundColor: Color(0xFF395886));
                                }
                              },
                              child: Icon(
                                Icons.copy,
                                color: Colors.white,
                                size: 23,
                              )),
                          SizedBox(
                            width: 14,
                          ),
                          // InkWell(
                          //     onTap: () {},
                          //     child: Icon(
                          //       Icons.record_voice_over_rounded,
                          //       color: Colors.white,
                          //       size: 26,
                          //     ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
