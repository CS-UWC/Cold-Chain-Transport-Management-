#define ADC_VREF_mV    1100.0 // in millivolt
#define ADC_RESOLUTION 1024.0
#define PIN_LM35       A1

void setup() {
  Serial.begin(9600);
  // switch to Internal 1.1V Reference
  analogReference(INTERNAL);
}

void loop() {
  // get the ADC value from the temperature sensor
  int adcVal = analogRead(PIN_LM35);
  // convert the ADC value to voltage in millivolt
  float milliVolt = adcVal * (ADC_VREF_mV / ADC_RESOLUTION); //  ADC_VREF_mV = 1100 mV
  // convert the voltage to the temperature in Celsius
  float tempC = milliVolt / 10;
  // convert the Celsius to Fahrenheit
  float tempF = tempC * 9 / 5 + 32;

  // print the temperature in the Serial Monitor:
  Serial.print("Temperature: ");
  Serial.print(tempC);   // print the temperature in Celsius
  Serial.print("  ~  "); // separator between Celsius and Fahrenheit
  Serial.print(tempF);   // print the temperature in Fahrenheit
  Serial.println();

  delay(1000);
}
