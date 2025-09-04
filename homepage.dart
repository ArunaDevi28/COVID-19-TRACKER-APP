import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:arunadevi/panels/worldwidepanel.dart';
import 'package:arunadevi/panels/mostaffectedcountries.dart';
import 'package:arunadevi/panels/infopanel.dart';
import 'package:arunadevi/pages/countryPage.dart';
import 'package:arunadevi/pages/thankyou.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:pie_chart/pie_chart.dart';

class DataSource {
  static String quote =
      "Nothing in life is to be feared, it is only to be understood. "
      "Now is the time to understand more, so that we may fear less.";
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic> worldData = {};
  List<dynamic> countryData = [];

  Future fetchWorldWideData() async {
    final url = Uri.parse('https://disease.sh/v3/covid-19/all');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          worldData = json.decode(response.body);
        });
      }
    } catch (e) {
      print("Error fetching world data: $e");
    }
  }

  Future fetchCountryData() async {
    final url = Uri.parse('https://disease.sh/v3/covid-19/countries?sort=cases');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          countryData = json.decode(response.body);
        });
      }
    } catch (e) {
      print("Error fetching country data: $e");
    }
  }

  Future fetchData() async {
    await fetchWorldWideData();
    await fetchCountryData();
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('COVID-19 TRACKER'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              AdaptiveTheme.of(context).mode.isDark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () {
              AdaptiveTheme.of(context).toggleThemeMode();
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: fetchData,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 100,
                width: double.infinity,
                color: Colors.orange.shade100,
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    DataSource.quote,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.orange.shade800,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'WorldWide',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => CountryPage()),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'Regional',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              worldData.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : WorldwidePanel(worldData: worldData),
              if (worldData.isNotEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: PieChart(
                      dataMap: {
                        'Confirmed': worldData['cases'].toDouble(),
                        'Active': worldData['active'].toDouble(),
                        'Recovered': worldData['recovered'].toDouble(),
                        'Deaths': worldData['deaths'].toDouble(),
                      },
                      chartType: ChartType.disc,
                      chartRadius: MediaQuery.of(context).size.width / 3.5,
                      animationDuration: Duration(milliseconds: 800),
                      colorList: [
                        Colors.red,
                        Colors.blue,
                        Colors.green,
                        Colors.grey.shade700,
                      ],
                      chartValuesOptions: ChartValuesOptions(
                        showChartValuesInPercentage: true,
                        showChartValues: true,
                        decimalPlaces: 1,
                        showChartValueBackground: false,
                      ),
                      legendOptions: LegendOptions(
                        showLegends: true,
                        legendPosition: LegendPosition.bottom,
                        legendTextStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Most Affected Countries',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              countryData.isEmpty
                  ? Container()
                  : MostAffectedPanel(countryData: countryData),
              SizedBox(height: 20),
              Infopanel(),
              SizedBox(height: 20),
              Center(
                child: Text(
                  'WE ARE TOGETHER IN THE FIGHT',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ThankYouPage()),
                    );
                  },
                  icon: Icon(Icons.exit_to_app),
                  label: Text('Finish & Exit'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    textStyle: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
