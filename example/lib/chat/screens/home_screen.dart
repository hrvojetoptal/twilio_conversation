import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:twilio_chat_conversation_example/chat/bloc/chat_bloc.dart';
import 'package:twilio_chat_conversation_example/chat/bloc/chat_events.dart';
import 'package:twilio_chat_conversation_example/chat/bloc/chat_states.dart';
import 'package:twilio_chat_conversation_example/chat/common/api/api_provider.dart';
import 'package:twilio_chat_conversation_example/chat/common/progress_bar.dart';
import 'package:twilio_chat_conversation_example/chat/common/shared_preference.dart';
import 'package:twilio_chat_conversation_example/chat/common/toast_utility.dart';
import 'package:twilio_chat_conversation_example/chat/common/widgets/common_text_button_widget.dart';
import 'package:twilio_chat_conversation_example/chat/common/widgets/common_textfield.dart';
import 'package:twilio_chat_conversation_example/chat/repository/chat_repository.dart';
import 'package:twilio_chat_conversation_example/chat/screens/chat_screen.dart';

class HomeScreen extends StatefulWidget {
  final String? platformVersion;

  const HomeScreen({super.key, this.platformVersion});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ChatBloc? chatBloc;

  String? identity;
  final TextEditingController _userNameController = TextEditingController();
  SharedPreference sharedPreference = SharedPreference();

  @override
  void initState() {
    super.initState();
    chatBloc = BlocProvider.of<ChatBloc>(context);
  }

  Future<String?> getToken({
    required String user,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse(
        'https://periwinkle-butterfly-9112.twil.io/token-service?identity=$user&password=$password',
      ),
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Twilio Chat Conversation'),
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.black,
        body: BlocConsumer<ChatBloc, ChatStates>(
            builder: (BuildContext context, ChatStates state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: Colors.white,
                  child: TextButton(
                    onPressed: () async {
                      const token = '';
                      final repo = ChatRepositoryImpl();
                      String result = await repo.initializeConversationClient(
                        token,
                      );

                      print(result);
                    },
                    child: Text('INIT CLIENT'),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: TextButton(
                    onPressed: () async {
                      final sid = '';
                      final repo = ChatRepositoryImpl();
                      final result = await repo.sendMessage(
                        'Test 2',
                        sid,
                        false,
                      );
                      print(result);
                    },
                    child: Text('SEND TEST'),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: TextButton(
                    onPressed: () async {
                      final sid = '';

                      final repo = ChatRepositoryImpl();
                      final result = await repo.sendTypingIndicator(
                        sid,
                      );
                      print("result: $result");
                    },
                    child: Text('SEND TYPING'),
                  ),
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.80,
                    height: MediaQuery.of(context).size.height * 0.08,
                    child: SvgPicture.asset(
                      "assets/images/twilio_logo_red.svg",
                      color: Colors.red,
                    )),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.16,
                ),
                const Text(
                  "🧑 Please Enter User Name",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  softWrap: true,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.visible,
                    decoration: TextDecoration.none,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.050,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.82,
                    child: TextInputField(
                      icon: const Padding(
                        padding: EdgeInsets.only(top: 0.0),
                        child: Icon(
                          Icons.person,
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                      textCapitalization: TextCapitalization.none,
                      hintText: "",
                      maxLength: 100,
                      textInputFormatter: const [],
                      keyboardType: TextInputType.text,
                      width: MediaQuery.of(context).size.width * 0.90,
                      color: Colors.white,
                      borderColor: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.31),
                          blurRadius: 15,
                          offset: const Offset(-5, 5),
                        )
                      ],
                      controller: _userNameController,
                      textStyle: const TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        overflow: TextOverflow.visible,
                        decoration: TextDecoration.none,
                      ),
                    )),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                CommonTextButtonWidget(
                  isIcon: false,
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.82,
                  bgColor: Colors.blueGrey,
                  borderColor: Colors.white,
                  title: "Generate Token and Initialize Client",
                  titleFontSize: 14.0,
                  titleFontWeight: FontWeight.w600,
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    if (_userNameController.text.trim().isNotEmpty) {
                      identity == _userNameController.text;
                      String? accountSid =
                          await ApiProvider.getEnvironmentKeyByName(
                              keyName: 'twilio_account_sid');
                      String? apiKey =
                          await ApiProvider.getEnvironmentKeyByName(
                              keyName: 'twilio_api_key');
                      String? apiSecret =
                          await ApiProvider.getEnvironmentKeyByName(
                              keyName: 'twilio_api_secret');
                      String? serviceSid =
                          await ApiProvider.getEnvironmentKeyByName(
                              keyName: 'twilio_service_sid');
                      chatBloc!.add(GenerateTokenEvent(credentials: {
                        "accountSid": accountSid,
                        "apiKey": apiKey,
                        "apiSecret": apiSecret,
                        "identity": _userNameController.text,
                        "serviceSid": serviceSid
                      }));
                    } else {
                      ToastUtility.showToastAtCenter("Please enter user name.");
                    }
                  },
                ),
              ],
            ),
          );
        }, listener: (BuildContext context, ChatStates state) {
          if (state is GenerateTokenLoadingState) {
            ProgressBar.show(context);
          }
          if (state is GenerateTokenLoadedState) {
            ProgressBar.dismiss(context);
            initializeConversationClient(accessToken: state.token);
            //  ProgressBar.dismiss(context);
          }
          if (state is GenerateTokenErrorState) {
            ProgressBar.dismiss(context);
            ToastUtility.showToastAtCenter(state.message);
          }

          if (state is InitializeConversationClientLoadingState) {
            ProgressBar.show(context);
          }
          if (state is InitializeConversationClientLoadedState) {
            ProgressBar.dismiss(context);
            SharedPreference.setIdentity(identity: _userNameController.text);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                    create: (context) =>
                        ChatBloc(chatRepository: ChatRepositoryImpl()),
                    child: ChatScreen(identity: _userNameController.text)),
              ),
            );
          }
          if (state is InitializeConversationClientErrorState) {
            ProgressBar.dismiss(context);
            ToastUtility.showToastAtCenter(state.message);
          }
        }));
  }

  void initializeConversationClient({required String accessToken}) {
    chatBloc!.add(InitializeConversationClientEvent(accessToken: accessToken));
  }
}
