package tutorial.java.redis.security;

public class Storage {
    private static BankOperations bop;

    public static void store(BankOperations bo) {
        // Store only if it is initialized
        if (bop == null) {
            if (bo == null) {
                System.out.println("Invalid object!");
                System.exit(1);
            }
            bop = bo;
        }
    }
}
