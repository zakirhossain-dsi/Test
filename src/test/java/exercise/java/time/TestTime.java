package exercise.java.time;


import junit.framework.TestCase;
import org.junit.Test;

import java.nio.file.Paths;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

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

    @Test
    public void testExtractDatePattern(){
        String originalString = "reportSpId MLFF Daily Toll Transactions Details Report - MM-yyyy.xlxs";

        Pattern fileNamePattern = Pattern.compile("(reportSpId)?.+ ((dd-)?MM-yyyy)?");
        Matcher matcher = fileNamePattern.matcher(originalString);

        matcher.find();
        System.out.println(matcher.group(1));
        System.out.println(matcher.group(2));

        Date currentDate = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat(matcher.group(2));

        String modifiedString = originalString.replace(matcher.group(1), "123");
        modifiedString = modifiedString.replace(matcher.group(2), dateFormat.format(currentDate));

        System.out.println(modifiedString);
    }

    @Test
    public void testDateFormat(){
        Date currentDate = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss");
        String formattedDate = sdf.format(currentDate);
        System.out.println("Formatted Date: " + formattedDate);
    }

}
