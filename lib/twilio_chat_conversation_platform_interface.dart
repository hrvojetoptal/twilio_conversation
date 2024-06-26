import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'twilio_chat_conversation_method_channel.dart'
    if (dart.library.html) 'package:twilio_chat_conversation/twilio_chat_conversation_web.dart';

abstract class TwilioChatConversationPlatform extends PlatformInterface {
  /// Constructs a TwilioChatConversationPlatform.
  TwilioChatConversationPlatform() : super(token: _token);

  static final Object _token = Object();

  static TwilioChatConversationPlatform _instance =
      MethodChannelTwilioChatConversation();

  /// The default instance of [TwilioChatConversationPlatform] to use.
  ///
  /// Defaults to [MethodChannelTwilioChatConversation].
  static TwilioChatConversationPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [TwilioChatConversationPlatform] when
  /// they register themselves.
  static set instance(TwilioChatConversationPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> generateToken({
    required String accountSid,
    required String apiKey,
    required String apiSecret,
    required String identity,
    required String serviceSid,
  }) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> createConversation({
    required String conversationName,
    required String identity,
  }) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<List?> getConversations() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<List?> getMessages(
      {required String conversationSid, int? messageCount}) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> joinConversation(String conversationSid) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> sendMessage({
    required String conversationSid,
    required String message,
  }) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> addParticipant({
    required String conversationSid,
    required String participantName,
  }) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> receiveMessages(String conversationSid) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<List?> getParticipants(String conversationSid) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> subscribeToMessageUpdate(String conversationSid) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> unSubscribeToMessageUpdate(String conversationSid) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> initializeConversationClient({required String accessToken}) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<Map?> updateAccessToken({required String accessToken}) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> removeParticipant({
    required String conversationSid,
    required String participantName,
  }) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> sendTypingIndicator(String conversationSid) {
    throw UnimplementedError('sendTypingIndicator() has not been implemented.');
  }
}
