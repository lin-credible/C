import java.lang.reflect.*;

class Private {
  private String field = "This is a private var";

  private void method() {
    System.out.println("Call the private method.");
  }
}

public class AccessTest {
  public static void main(String[] args) throws Exception {
    Private privateObj = new Private();
    Field f = Private.class.getDeclaredField("field");
    f.setAccessible(true);
    System.out.println(f.get(privateObj));
    
    Method m = Private.class.getDeclaredMethod("method", new Class[0]);
    m.setAccessible(true);
    m.invoke(privateObj, new Object[0]);
  }
}
