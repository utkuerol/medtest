import 'package:medtest/logic/model/category.dart';
import 'package:medtest/logic/model/question.dart';
import 'package:medtest/logic/model/question_type.dart';
import 'package:medtest/logic/model/textmultiplechoice_question.dart';

class MockData {
  static final List<Question> questions = [
    TextMultipleChoiceQuestion(
      1,
      Category.categoryB,
      QuestionType.textMultipleChoice,
      """Das Auge hat die Fähigkeit, sich in alle Richtungen zu bewegen. Um dies
möglich zu machen, gibt es sechs äussere Augenmuskeln, vier gerade und zwei
schräge. Sie werden alle von Hirnnerven gesteuert.
Die geraden Muskeln, dazu gehören der M. rectus superior, M. rectus inferior, der M.
rectus medialis und der M. rectus lateralis, setzen alle vor dem Äquator des
Augapfels an. Die geraden Muskeln werden vom Nervus oculomotorius und dem
Nervus abducens gesteuert.

Welche Aussage trifft gemäss obigen Text zu?""",
      [
        'Die schrägen Augenmuskeln werden von N. oculomotorius versorgt.',
        'Es gibt sechs gerade Augenmuskeln',
        'Der N. abducens ist ein Hirnnerv',
        'Die schrägen Augenmuskeln setzt hinter dem Äquator des Augapfels an',
        'Der M. rectus medialis ist ein schräger Augenmuskel',
      ],
      0,
    ),
    TextMultipleChoiceQuestion(
      1,
      Category.categoryB,
      QuestionType.textMultipleChoice,
      """Das Auge hat die Fähigkeit, sich in alle Richtungen zu bewegen. Um dies
möglich zu machen, gibt es sechs äussere Augenmuskeln, vier gerade und zwei
schräge. Sie werden alle von Hirnnerven gesteuert.
Die geraden Muskeln, dazu gehören der M. rectus superior, M. rectus inferior, der M.
rectus medialis und der M. rectus lateralis, setzen alle vor dem Äquator des
Augapfels an. Die geraden Muskeln werden vom Nervus oculomotorius und dem
Nervus abducens gesteuert.

Welche Aussage trifft gemäss obigen Text zu?""",
      [
        'Die schrägen Augenmuskeln werden von N. oculomotorius versorgt.',
        'Es gibt sechs gerade Augenmuskeln',
        'Der N. abducens ist ein Hirnnerv',
        'Die schrägen Augenmuskeln setzt hinter dem Äquator des Augapfels an',
        'Der M. rectus medialis ist ein schräger Augenmuskel',
      ],
      0,
    ),
    TextMultipleChoiceQuestion(
      1,
      Category.categoryB,
      QuestionType.textMultipleChoice,
      """Das Auge hat die Fähigkeit, sich in alle Richtungen zu bewegen. Um dies
möglich zu machen, gibt es sechs äussere Augenmuskeln, vier gerade und zwei
schräge. Sie werden alle von Hirnnerven gesteuert.
Die geraden Muskeln, dazu gehören der M. rectus superior, M. rectus inferior, der M.
rectus medialis und der M. rectus lateralis, setzen alle vor dem Äquator des
Augapfels an. Die geraden Muskeln werden vom Nervus oculomotorius und dem
Nervus abducens gesteuert.

Welche Aussage trifft gemäss obigen Text zu?""",
      [
        'Die schrägen Augenmuskeln werden von N. oculomotorius versorgt.',
        'Es gibt sechs gerade Augenmuskeln',
        'Der N. abducens ist ein Hirnnerv',
        'Die schrägen Augenmuskeln setzt hinter dem Äquator des Augapfels an',
        'Der M. rectus medialis ist ein schräger Augenmuskel',
      ],
      0,
    )
  ];
}
