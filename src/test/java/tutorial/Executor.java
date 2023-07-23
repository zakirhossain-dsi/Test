package tutorial;

import java.math.BigDecimal;
import java.math.RoundingMode;

public class Executor {
    public static void main(String[] args) {
        Double x = 3.5d;
        BigDecimal bd = BigDecimal.valueOf(123.455);
        System.out.println(bd.setScale(2, RoundingMode.HALF_DOWN));
    }
}
