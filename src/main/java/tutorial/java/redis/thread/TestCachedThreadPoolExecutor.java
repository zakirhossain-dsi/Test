package tutorial.java.redis.thread;

import java.util.concurrent.Executors;
import java.util.concurrent.ThreadPoolExecutor;

public class TestCachedThreadPoolExecutor {
    public static void main(String[] args) throws InterruptedException {
        ThreadPoolExecutor executor = (ThreadPoolExecutor) Executors.newCachedThreadPool();
        executor.submit(() -> {
            System.out.println("Task 1: " + Thread.currentThread().getName());
            return null;
        });
        executor.submit(() -> {
            System.out.println("Task 2: " + Thread.currentThread().getName());
           return null;
        });
        executor.submit(() -> {
            System.out.println("Task 3: " + Thread.currentThread().getName());
           return null;
        });
        executor.submit(() -> {
            System.out.println("Task 4: " + Thread.currentThread().getName());
           return null;
        });
        executor.submit(() -> {
            System.out.println("Task 5: " + Thread.currentThread().getName());
           return null;
        });
        executor.submit(() -> {
            System.out.println("Task 6: " + Thread.currentThread().getName());
           return null;
        });

        System.out.println("Pool size:  " + executor.getPoolSize());
        System.out.println("Queue size: " + executor.getQueue().size());

    }
}
