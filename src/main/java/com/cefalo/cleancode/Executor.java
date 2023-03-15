package com.cefalo.cleancode;

public class Executor {
    public static void main(String[] args) {
        IdGenerator generator = new IdGenerator();

        Runnable r1 = generator::incrementValue;
        Runnable r2 = generator::incrementValue;

        Thread t1 = new Thread(r1, "Thread-1");
        Thread t2 = new Thread(r2, "Thread-2");
        t1.start();
        t2.start();
    }
}
