import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

private String db = "postgres";
private String user = "postgres";
private String password = "postgres";
private Connection conn;
private Statement sql;
private ResultSet res;
private int total = 0;
private int size = 0;
private String output_ordered = "";
private String output_random = "";
private PImage imgTime, imgNumber;

private int color_background = color(255, 255, 255);
private int color_friendly = color(62, 120, 220);
private int color_hostnation = color(53, 214, 181);
private int color_civilian = color(220, 117, 12);
private int color_enemy = color(80, 80, 80);  

public void setup() {
  try {
    int totalcivilian = 0, totalenemy = 0, totalfriendly = 0, totalhostnation = 0;
    Class.forName("org.postgresql.Driver");
    conn = DriverManager.getConnection("jdbc:postgresql:"+db, user, password);
    sql = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
    // DB Query : returns all the rows with at least 1 death.
    res = sql.executeQuery("SELECT civiliankia, enemykia, friendlykia,hostnationkia FROM iraq_osm_wikileaks " +
      "WHERE (civiliankia > 0 " +
      "OR enemykia > 0 " +
      "OR friendlykia > 0 " +
      "OR hostnationkia >0)" +
      "ORDER BY date ASC;");
    while (res.next ()) {
      int[] daycount = new int[5];
      daycount[0] = res.getInt("friendlykia");
      daycount[1] = res.getInt("hostnationkia");
      daycount[2] = res.getInt("civiliankia");
      daycount[3] = res.getInt("enemykia");
      daycount[4] = daycount[0]+daycount[1]+daycount[2]+daycount[3];
      totalfriendly += daycount[0];
      totalhostnation += daycount[1];
      totalcivilian += daycount[2];
      totalenemy += daycount[3];
      String tempOutput = "";
      for (int i=0;i<daycount[0];i++) {
        tempOutput += "F";
      }
      for (int i=0;i<daycount[1];i++) {
        tempOutput += "H";
      }
      for (int i=0;i<daycount[2];i++) {
        tempOutput += "C";
      }
      for (int i=0;i<daycount[3];i++) {
        tempOutput += "E";
      }
      // Randomize sequence of deaths that occured the same day
      String tempOutput_random = shuffle(tempOutput);
      output_ordered += tempOutput;
      output_random += tempOutput_random;
      total += daycount[4];
    }
    size = (int)Math.ceil(Math.sqrt(total));
    size(size*2+15, size+10);

    // Create image for time ordered deaths
    imgTime = initImage(size, size);
    for (int i = 0; i < output_random.length(); i++) {
      int c = color_background;
      try {
        String a = output_random.substring(i, i+1);
        if (a.equals("F")) {
          c = color_friendly;
        } else if (a.equals("H")) {
          c = color_hostnation;
        } else if (a.equals("C")) {
          c = color_civilian;
        } else if (a.equals("E")) {
          c = color_enemy;
        }
      } 
      catch (Exception e) {
        e.printStackTrace();
      }        
      imgTime.pixels[i] = c;
    }
    imgTime.updatePixels();

    // Create image for sum ordered deaths
    imgNumber = initImage(size, size);
    for (int i = 0; i < imgNumber.pixels.length; i++) {
      int c = color_background;
      if (i<=totalfriendly) {
        c = color_friendly;
      } else if (i>totalfriendly&&i<=(totalfriendly+totalhostnation)) {
        c = color_hostnation;
      } else if (i>(totalfriendly+totalhostnation)&&i<=(totalfriendly+totalhostnation+totalcivilian)) {
        c = color_civilian;
      } else if (i>(totalfriendly+totalhostnation+totalcivilian)&&i<=(totalfriendly+totalhostnation+totalcivilian+totalenemy)) {
        c = color_enemy;
      }      
      imgNumber.pixels[i] = c;
    }
    imgNumber.updatePixels();
    image(imgTime, size+10, 5);
    image(imgNumber, 5, 5);
    save("function.tif");
  } 
  catch (Exception e) {
    e.printStackTrace();
  }
}

public void draw() {
  background(255);
  image(imgTime, size+10, 5);
  image(imgNumber, 5, 5);
}

private PImage initImage(int width, int height) {
  PImage img = createImage(width, height, RGB);
  img.loadPixels();
  for (int i = 0; i < img.pixels.length; i++) {
    img.pixels[i] = color_background;
  }
  img.updatePixels();
  return img;
}

// swaps array elements i and j
private void exch(String[] a, int i, int j) {
  String swap = a[i];
  a[i] = a[j];
  a[j] = swap;
}

// take as input an array of strings and rearrange them in random order
private String shuffle(String input) {
  String[] a = input.split("");
  int N = a.length;
  for (int i = 0; i < N; i++) {
    int r = i + (int) (Math.random() * (N-i));   // between i and N-1
    exch(a, i, r);
  }
  String res = "";
  for (int i=0;i<a.length;i++) {
    res+=a[i];
  }
  return res;
}

