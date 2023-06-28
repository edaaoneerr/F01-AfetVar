import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class EarthquakePage extends StatefulWidget {
  @override
  _EarthquakePageState createState() => _EarthquakePageState();
}

class _EarthquakePageState extends State<EarthquakePage> {
  stt.SpeechToText speech = stt.SpeechToText();
  TextEditingController _additionalInfoController = TextEditingController();
  String _selectedSituation = 'Tehlikedeyim';
  List<String> _selectedOptions = [];
  String _spokenText = '';
  bool _isListening = false;
  String _selectedOption = '';

  @override
  void initState() {
    super.initState();
    _additionalInfoController.addListener(() {
      setState(() {
        _spokenText = _additionalInfoController.text;
      });
    });
  }

  @override
  void dispose() {
    _additionalInfoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _selectedSituation == 'Tehlikedeyim' ? Colors.red : Colors.green,
        title: const Text('Deprem Bildirimi'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
          const Text(
          'Durumunuzu Seçin:',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: () {
            handleSituationChange('Tehlikedeyim');
          },
          style: ElevatedButton.styleFrom(
            primary: _selectedSituation == 'Tehlikedeyim'
                ? Colors.red
                : Colors.grey[300],
            padding: const EdgeInsets.symmetric(
                vertical: 8.0, horizontal: 12.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: const Text(
            'Tehlilkedeyim',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.white,
            ),
          ),
        ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                handleSituationChange('Güvendeyim');
              },
              style: ElevatedButton.styleFrom(
                primary: _selectedSituation == 'Güvendeyim'
                    ? Colors.green
                    : Colors.grey[300],
                padding: const EdgeInsets.symmetric(
                    vertical: 8.0, horizontal: 12.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text(
                'Güvendeyim',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.white,
                ),
              ),
            ),
          if (_selectedSituation == 'Tehlikedeyim') ...[
        const SizedBox(height: 8.0),
    Column(
    children: [
      const SizedBox(height: 16.0),
      const Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Rahat nefes alabiliyor musunuz?',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
      ),
      Row(children: [
        Expanded(
        child: RadioListTile(
          title: const Text('Evet'),
          value: 'Evet',
          groupValue: _selectedOption,
          onChanged: (value) {
            setState(() {
              _selectedOption = value as String;
            });
          },
        ),
      ),

        Expanded(
          child: RadioListTile(
            title: const Text('Hayır'),
            value: 'Hayır',
            groupValue: _selectedOption,
            onChanged: (value) {
              setState(() {
                _selectedOption = value as String;
              });
            },
          ),
        ),
      ],),
      const SizedBox(height: 16.0),
      const Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Bulunduğunuz yerde canlı olduğunu düşündüğünüz kaç kişi var?',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
      ),
      Row(children: [ Expanded(
        child: RadioListTile(
          title: const Text('1+'),
          value: '1+',
          groupValue: _selectedOption,
          onChanged: (value) {
            setState(() {
              _selectedOption = value as String;
            });
          },
        ),
      ),

        Expanded(
          child: RadioListTile(
            title: const Text('5+'),
            value: '5+',
            groupValue: _selectedOption,
            onChanged: (value) {
              setState(() {
                _selectedOption = value as String;
              });
            },
          ),
        ),
        Expanded(
          child: RadioListTile(
            title: const Text('9+'),
            value: '9+',
            groupValue: _selectedOption,
            onChanged: (value) {
              setState(() {
                _selectedOption = value as String;
              });
            },
          ),
        ),
      ],),
      const SizedBox(height: 16.0),
      Align(
        alignment: Alignment.centerLeft,
        child: const Text(
          'Vücudunuzda yara, kırık gibi canınızı acıtacak bir belirti var mı?',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
      ),
      Row(children: [ Expanded(
        child: RadioListTile(
          title: const Text('Evet'),
          value: 'Evet',
          groupValue: _selectedOption,
          onChanged: (value) {
            setState(() {
              _selectedOption = value as String;
            });
          },
        ),
      ),

        Expanded(
          child: RadioListTile(
            title: const Text('Hayır'),
            value: 'Hayır',
            groupValue: _selectedOption,
            onChanged: (value) {
              setState(() {
                _selectedOption = value as String;
              });
            },
          ),
        ),
      ],),
   ]
    ),
    const SizedBox(height: 16.0),
    const Text(
    'Birden fazla seçebilirsiniz:',
    style: TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.bold,
    color: Colors.red,
    ),
    ),
    const SizedBox(height: 8.0),
    Wrap(
    spacing: 8.0,
    runSpacing: 8.0,
    children: [
    'Hareket edemiyorum',
    'Yukarıdan yardım sesleri duyuyorum',
    'Sesim yukarı ulaşmıyor',
    'Kimse yok',
    'Hareket edebiliyorum fakat önüm kapalı',
    ].map((situation) {
    return ElevatedButton(
    onPressed: () {
    handleOptionChange(situation);
    },
    style: ElevatedButton.styleFrom(
    primary: _selectedOptions.contains(situation)
    ? Colors.red
        : Colors.grey[300],
    padding: const EdgeInsets.symmetric(
    vertical: 8.0, horizontal: 12.0),
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8.0),
    ),
    ),
    child: Text(
    situation,
    style: const TextStyle(
    fontSize: 12.0,
    color: Colors.white,
    ),
    ),
    );
    }).toList(),
    ),
    ],
    if (_selectedSituation == 'Güvendeyim') ...[
      const SizedBox(height: 18.0),
      Column(
          children: [
            const SizedBox(height: 16.0),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Güvenli bir alanda mısınız?',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
            Row(children: [
              Expanded(
                child: RadioListTile(
                  title: const Text('Evet'),
                  value: 'Evet',
                  groupValue: _selectedOption,
                  onChanged: (value) {
                    setState(() {
                      _selectedOption = value as String;
                    });
                  },
                ),
              ),

              Expanded(
                child: RadioListTile(
                  title: const Text('Hayır'),
                  value: 'Hayır',
                  groupValue: _selectedOption,
                  onChanged: (value) {
                    setState(() {
                      _selectedOption = value as String;
                    });
                  },
                ),
              ),
            ],),
            const SizedBox(height: 16.0),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Bulunduğunuz yerde 50+ kişinni güvenli kalması mümkün mü (Arabada iseniz, hayırı işaretleyiniz.)?',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
            Row(children: [ Expanded(
              child: RadioListTile(
                title: const Text('Evet'),
                value: 'Evet',
                groupValue: _selectedOption,
                onChanged: (value) {
                  setState(() {
                    _selectedOption = value as String;
                  });
                },
              ),
            ),

              Expanded(
                child: RadioListTile(
                  title: const Text('Hayır'),
                  value: 'Hayır',
                  groupValue: _selectedOption,
                  onChanged: (value) {
                    setState(() {
                      _selectedOption = value as String;
                    });
                  },
                ),
              ),
            ],),
            const SizedBox(height: 16.0),
            Align(
              alignment: Alignment.centerLeft,
              child: const Text(
                'Vücudunuzda yara, kırık gibi canınızı acıtacak bir belirti var mı?',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
            Row(children: [ Expanded(
              child: RadioListTile(
                title: const Text('Evet'),
                value: 'Evet',
                groupValue: _selectedOption,
                onChanged: (value) {
                  setState(() {
                    _selectedOption = value as String;
                  });
                },
              ),
            ),

              Expanded(
                child: RadioListTile(
                  title: const Text('Hayır'),
                  value: 'Hayır',
                  groupValue: _selectedOption,
                  onChanged: (value) {
                    setState(() {
                      _selectedOption = value as String;
                    });
                  },
                ),
              ),
            ],),
          ]
      ),
    const SizedBox(height: 16.0),
    const Text(
    'Birden fazla seçebilirsiniz:',
    style: TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.bold,
    color: Colors.green,
    ),
    ),
    const SizedBox(height: 8.0),
    Wrap(
    spacing: 8.0,
    runSpacing: 8.0,
    children: [
    'Toplanma alanındayım',
    'Yaralılar var',
    'Yaralarım var',
    'Vücudumda kırıklar olabilir',
    'Araçta sıkıştım',
    'Çocuklarım var',
    'Yaşlılar var',
    'Engelliler var',
    ].map((option) {
    bool isSelected = _selectedOptions.contains(option);
    return ElevatedButton(
    onPressed: () {
    handleOptionChange(option);
    },
    style: ElevatedButton.styleFrom(
    primary: isSelected ? Colors.green : Colors.grey[300],
    padding: const EdgeInsets.symmetric(
    vertical: 8.0, horizontal: 12.0),
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8.0),
    ),
    ),
    child: Text(
    option,
    style: TextStyle(
    fontSize: 12.0,
    color: isSelected ? Colors.white : Colors.black,
    ),
    ),
    );
    }).toList(),
    )],
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Ek Bilgi:',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextField(
                        controller: _additionalInfoController,
                        decoration: const InputDecoration(
                          hintText: 'Ek bilgi girin',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16.0),
    FloatingActionButton(
    onPressed: toggleListening,
    child: Icon(_isListening ? Icons.mic_off : Icons.mic),
    backgroundColor: _selectedSituation == 'Tehlikedeyim' ? Colors.red : Colors.green, // Set the background color
    foregroundColor: Colors.white, // Set the icon color
    elevation: 4.0, // Set the elevation
    shape: CircleBorder(), // Set the shape as a circle
    )]
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                submitForm();
              },
              style: ElevatedButton.styleFrom(
                primary: _selectedSituation == 'Tehlikedeyim' ? Colors.red : Colors.green,// Set the background color
                onPrimary: Colors.white, // Set the text color
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 24.0), // Set the padding
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0), // Set the border radius
                ),
              ),
              child:  Expanded(
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Acil Durum Bildirimi'),
                            content: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Acil durum merkezlerine afet bildirimi gönderildi.',
                                  style: TextStyle(fontFamily: 'SFPro', fontSize: 16),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Kısa süre içerisinde, konumunuza acil durum merkezleri gönderilecektir.',
                                  style: TextStyle(fontFamily: 'SFPro', fontSize: 16),
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'Kapat',
                                  style: TextStyle(fontFamily: 'SFPro', fontSize: 16),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                        child: Text(
                          'Formu Gönder',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            backgroundColor: _selectedSituation == 'Tehlikedeyim' ? Colors.red : Colors.green,
                            fontFamily: 'SFPro',
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
            ),
          ],
        ),
      ),
    );
  }

  void handleSituationChange(String situation) {
    setState(() {
      _selectedSituation = situation;
      _selectedOptions.clear();
    });
  }

  void handleOptionChange(String option) {
    setState(() {
      if (_selectedOptions.contains(option)) {
        _selectedOptions.remove(option);
      } else {
        _selectedOptions.add(option);
      }
    });
  }

  void toggleListening() async {
    if (!_isListening) {
      bool isAvailable = await speech.initialize(
        onStatus: (status) {},
        onError: (error) {},
      );

      if (isAvailable) {
        setState(() {
          _isListening = true;
        });
        speech.listen(
          onResult: (result) {
            setState(() {
              _additionalInfoController.text = result.recognizedWords;
            });
          },
        );
      }
    }
  }

  void submitForm() {
    // Perform form submission logic here
  }
}

