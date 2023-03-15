package tutorial.java.redis.thread;

import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

public class TestScheduledExecutorService {
    public static void main(String[] args) {
        ScheduledExecutorService executorService = Executors.newScheduledThreadPool(5);

        /*
        executorService.schedule(() -> {
            System.out.println("Hello world!");
        }, 5, TimeUnit.SECONDS);
        */

        /*
        executorService.scheduleWithFixedDelay(() -> {
            System.out.println("Hello world");
        }, 0, 1, TimeUnit.SECONDS);
        */

        executorService.scheduleAtFixedRate(() -> {
            System.out.println("Hello world");
        }, 0, 500, TimeUnit.MILLISECONDS);
    }
}
