import '../../../utils/constants.dart';

sealed class ChatModel {
  String model;
  ChatModel({required this.model});
}

class GptTurboChatModel extends ChatModel {
  GptTurboChatModel() : super(model: kChatGptTurboModel);
}

class GptTurbo0301ChatModel extends ChatModel {
  GptTurbo0301ChatModel() : super(model: kChatGptTurbo0301Model);
}

class ChatModelFromValue extends ChatModel {
  ChatModelFromValue({required super.model});
}

class Gpt4ChatModel extends ChatModel {
  Gpt4ChatModel() : super(model: kChatGpt4);
}

class Gpt40314ChatModel extends ChatModel {
  Gpt40314ChatModel() : super(model: kChatGpt40314);
}

class Gpt432kChatModel extends ChatModel {
  Gpt432kChatModel() : super(model: kChatGpt432k);
}

class Gpt432k0314ChatModel extends ChatModel {
  Gpt432k0314ChatModel() : super(model: kChatGpt432k0314);
}

class GptTurbo0631Model extends ChatModel {
  GptTurbo0631Model() : super(model: kChatGptTurbo0613);
}

class Gpt40631ChatModel extends ChatModel {
  Gpt40631ChatModel() : super(model: kChatGpt40631);
}

// enum ChatModel {
//   gptTurbo,
//
//   ///DEPRECATION DATE
//   ///June 1st, 2023
//   gptTurbo0301,
//   gpt_4,
//
//   ///DEPRECATION DATE
//   ///June 1st, 2023
//   gpt_4_0314,
//   gpt_4_32k,
//
//   ///DEPRECATION DATE
//   ///June 1st, 2023
//   gpt_4_32k_0314
// }
//
// extension ChatModelExtension on ChatModel {
//   String get name {
//     switch (this) {
//       case ChatModel.gptTurbo0301:
//         return kChatGptTurbo0301Model;
//       case ChatModel.gptTurbo:
//         return kChatGptTurboModel;
//       case ChatModel.gpt_4:
//         return kChatGpt4;
//       case ChatModel.gpt_4_0314:
//         return kChatGpt40314;
//       case ChatModel.gpt_4_32k:
//         return kChatGpt432k;
//       case ChatModel.gpt_4_32k_0314:
//         return kChatGpt432k0314;
//       default:
//         return "";
//     }
//   }
// }
