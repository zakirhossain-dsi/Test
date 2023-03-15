package com.cefalo.cleancode;

public class IdGenerator {
    int lastIdUsed = 93;

    public synchronized int incrementValue() {
        String threadName = Thread.currentThread().getName();
        System.out.println(String.format("%s : %d", threadName, lastIdUsed));
        return ++lastIdUsed;
    }
}
