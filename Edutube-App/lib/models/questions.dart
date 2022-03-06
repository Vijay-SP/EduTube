class Question {
  final int id, answer;
  final String question;
  final List<String> options;

  Question(
      {required this.id,
      required this.question,
      required this.answer,
      required this.options});
}

const List sample_data = [
  {
    "id": 1,
    "question":
        "The cow dung + urine + agricultural waste are ready to be used as farm yard manure after how many days?",
    "options": [
      '30 – 50 days',
      '50 – 90 days.',
      '90 to 120 days.',
      '120 to 150 days.'
    ],
    "answer_index": 2,
  },
  {
    "id": 2,
    "question": "Which country occupies the maximum area under OF?",
    "options": ['United States of America.', 'England', 'Australia', 'Italy'],
    "answer_index": 1,
  },
  {
    "id": 3,
    "question": "Which Indian state occupies the maximum area under OF?",
    "options": [
      'Rajasthan',
      'Uttar Pradesh',
      'Madhya Pradesh',
      'Andhra Pradesh'
    ],
    "answer_index": 3,
  },
  {
    "id": 4,
    "question": "Who gave the term organic farming?",
    "options": [
      'Rudolf Steiner.',
      'Sir Albert Howard.',
      'F. H. Howard.',
      'Walter James'
    ],
    "answer_index": 4,
  },
];
