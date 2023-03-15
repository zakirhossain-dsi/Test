package tutorial.java.redis.thread;

import java.util.concurrent.*;

public class TestExecutor {
    public static void main(String[] args) throws ExecutionException, InterruptedException {

        Executor executor = Executors.newSingleThreadExecutor();
        executor.execute(()-> System.out.println("Happy thread learning!"));
    }
}
