import 'package:flutter/material.dart';

Color primaryBlack = Color(0xff202c3b);

class DataSource {
  static String quote =
      "Nothing in life is to be feared, it is only to be understood. "
      "Now is the time to understand more, so that we may fear less."; // ✅ Added semicolon

  static List<Map<String, String>> questionAnswers = [
    {
      "question": "What is a coronavirus?",
      "answer": "Coronaviruses are a large family of viruses which may cause illness in animals or humans."
    },
    {
      "question": "What is COVID-19?",
      "answer": "COVID-19 is the infectious disease caused by the most recently discovered coronavirus."
    },
    {
      "question": "What are the symptoms of COVID-19?",
      "answer": "The most common symptoms of COVID-19 are fever, tiredness, and dry cough. Some patients may have aches and pains."
    },
    {
      "question": "How does COVID-19 spread?",
      "answer": "People can catch COVID-19 from others who have the virus. It spreads primarily through droplets from the nose or mouth."
    },
    {
      "question": "What can I do to protect myself?",
      "answer": "Regularly wash your hands with soap, maintain social distancing, and avoid touching your face."
    },
    {
      "question": "Is there a vaccine for COVID-19?",
      "answer": "Yes, vaccines have been developed and distributed to help protect people from COVID-19."
    },
    {
      "question": "Can COVID-19 be caught from someone with no symptoms?",
      "answer": "Yes. The disease can spread from people who have no symptoms or are in the incubation period."
    },
    {
      "question": "What should I do if I have symptoms?",
      "answer": "Stay home, isolate yourself, wear a mask, and contact your local health authority or doctor."
    },
    {
      "question": "Can antibiotics prevent or treat COVID-19?",
      "answer": "No. Antibiotics do not work against viruses; they only work on bacterial infections."
    },
    {
      "question": "How long is the incubation period for COVID-19?",
      "answer": "The incubation period ranges from 1–14 days, most commonly around five days."
    },
  ];
}
