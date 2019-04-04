//importazione delle librerie
import processing.serial.*;
Serial myPort;
String sensorReading="";
import java.io.BufferedWriter;
import java.io.FileWriter;
//nome del file di output
String outFilename = "datafutura.csv";

String timestamp = "";


void setup() {
  println(Serial.list()); 
  size(400,200);  //dimensione finestra
  myPort = new Serial(this,Serial.list()[0], 9600);       //porta seriale arduino
  myPort.bufferUntil('\n');
  writeText("data visualization, stop with any key");            //visualizzazione dati
  
}

void draw() {
  //serialEvent controlla il disply
}  

void serialEvent (Serial myPort){
 sensorReading = myPort.readStringUntil('\n');
  if(sensorReading != null){
    sensorReading=trim(sensorReading); //legge valori della fotoresistenza
    timestamp=year()+"/"+month()+"/"+day()+" "+hour()+":"+minute()+":"+second()+"," ; //dati di anno, mese, giorno, ore, minuto, secondo
  }
  // realizza i dati su data/ora
  
  //pubblica il testo "magnitude, dati data/ora e il valore della magnitudine
  writeText("magnitude: " + timestamp + sensorReading); 
  
  appendTextToFile(outFilename, timestamp +   sensorReading);

}

//formato della scrittura
void writeText(String textToWrite){     
  background(255);
  fill(0);
  text(textToWrite, width/20, height/2);   
}


void keyPressed() {

  exit();  // Blocca il programma dopo che un pulsante qualsiasi è premuto
}


void appendTextToFile(String filename, String text){
  File f = new File(dataPath(filename));
  if(!f.exists()){
    createFile(f);
  }
  try {
    PrintWriter out = new PrintWriter(new BufferedWriter(new FileWriter(f, true)));   // vero per pubblicare l'output
    out.println(text);
    out.close();                                      // clean close permette di leggere/modificare dati durante l'esecuzione
  }catch (IOException e){
      e.printStackTrace();
  }
}

// crea una nuova sottocartellla contenente il file

void createFile(File f){
  File parentDir = f.getParentFile();
  try{
    parentDir.mkdirs(); 
    f.createNewFile();
     }
    catch(Exception e){
    e.printStackTrace();
    }
}    
