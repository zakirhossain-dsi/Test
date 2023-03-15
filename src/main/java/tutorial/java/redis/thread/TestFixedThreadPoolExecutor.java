package tutorial.java.redis.thread;

import java.util.concurrent.Executors;
import java.util.concurrent.ThreadPoolExecutor;

public class TestFixedThreadPoolExecutor {
    public static void main(String[] args) {
        ThreadPoolExecutor executor = (ThreadPoolExecutor) Executors.newFixedThreadPool(2);
        executor.submit(() -> {
           Thread.sleep(1000);
           return null;
        });
        executor.submit(() -> {
           Thread.sleep(1000);
           return null;
        });
        executor.submit(() -> {
           Thread.sleep(1000);
           return null;
        });

        System.out.println("Pool size:  " + executor.getPoolSize());
        System.out.println("Queue size: " + executor.getQueue().size());

    }
}
