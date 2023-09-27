package tutorial;

import java.io.IOException;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.YearMonth;
import java.time.ZoneId;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Executor {
    public static void main(String[] args) throws IOException {

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
}
