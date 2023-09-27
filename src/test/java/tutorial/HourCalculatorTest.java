package tutorial;

import org.junit.Test;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class HourCalculatorTest {

    @Test
    public void testdate(){

        // Define the original string with a date pattern
        String originalString = "reportSpId MLFF Daily Toll Transactions Details Report - DD-MM-YYYY";

        // Create a regular expression pattern to match the date pattern 'DD-MM-YYYY'
        Pattern datePattern = Pattern.compile("DD-MM-YYYY");

        // Get the current system date
        Date currentDate = new Date();

        // Create a date formatter for 'DD-MM-YYYY'
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");

        // Use a matcher to find and replace the date pattern in the original string
        Matcher matcher = datePattern.matcher(originalString);
        String modifiedString = matcher.replaceAll(dateFormat.format(currentDate));

        // Print the modified string
        System.out.println("Modified String: " + modifiedString);
    }
}
