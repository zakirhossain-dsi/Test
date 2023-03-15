package tutorial.java.redis.thread;

import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

public class TestExecutorService {

    public static void main(String[] args) {

        System.out.println(Thread.currentThread().getName());

        ExecutorService executorService = Executors.newFixedThreadPool(10);
        Future<String> futureResult = executorService.submit(() -> {
            System.out.println(Thread.currentThread().getName());
            Thread.sleep(10000);
            return "Happy thread learning";
        });

        System.out.println(Thread.currentThread().getName());
        executorService.shutdown();

        try {
            System.out.println(futureResult.isDone());
            System.out.println(Thread.currentThread().getName() +"::"+ futureResult.get());
            System.out.println("last line");
        } catch (InterruptedException e) {
            e.printStackTrace();
        } catch (ExecutionException e) {
            e.printStackTrace();
        }
    }
}
