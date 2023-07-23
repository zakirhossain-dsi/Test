package exercise.java.time;


import junit.framework.TestCase;
import org.junit.Test;

import java.nio.file.Paths;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;

public class TestTime extends TestCase {

    @Test
    public void testTime() throws ParseException {
        Date date = new java.util.Date();
        SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
        System.out.println(sdf.format(date));
        Date d = sdf.parse("12:22");
        System.out.println(d);
    }

    @Test
    public void testStartingOfDate(){
        ZoneId TIME_ZONE = ZoneId.of("Asia/Kuala_Lumpur");

        Date postedDate = Date.from(getLocalDate().atStartOfDay(TIME_ZONE).toInstant());
        System.out.println(postedDate);
        String userDir = System.getProperty("user.dir");
        System.out.println( userDir);
        String str = Paths.get(userDir, "reports").toString();
        System.out.println(str);
    }

    public static LocalDate getLocalDate() {
        return LocalDate.now().minusDays(1);
    }
}
