package tutorial.java.redis.security;

public class BankOperations {
    public BankOperations() {
        if (!performSSNVerification()) {
            throw new SecurityException("Access Denied!");
        }
    }

    private boolean performSSNVerification() {
        return false; // Returns true if data entered is valid, else false
        // Assume that the attacker always enters an invalid SSN
    }

    public void greet() {
        System.out.println("Welcome user! You may now use all the features.");
    }
}
