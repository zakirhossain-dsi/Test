package exercise.java.hashmap;


import junit.framework.TestCase;
import org.apache.commons.collections4.MultiValuedMap;
import org.junit.Test;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.IntStream;

public class TestHashMap extends TestCase {

    @Test
    public void test1() throws ParseException {
     /*   Map<String, String> nameToClass = new HashMap<>();
        nameToClass.put("zakir", "10");
        var value = nameToClass.computeIfAbsent("zakir1", k -> null);
        System.out.println(value);
        System.out.println(nameToClass);*/
        IntStream.range(1, 10).forEach(i -> System.out.println(i));
    }
}
