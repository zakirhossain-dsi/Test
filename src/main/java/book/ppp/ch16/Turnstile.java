package book.ppp.ch16;

public class Turnstile {
    protected final static Turnstile LOCKED = new Locked();
    protected final static Turnstile UNLOCKED = new Unlocked();

    private static boolean isLocked = true;
    private static boolean isAlarming = false;
    private static int coins = 0;
    private static int refunds = 0;
    protected static Turnstile state = LOCKED;

    public void reset(){
        lock(true);
        alarm(false);
        coins = 0;
        refunds = 0;
        state = LOCKED;
    }

    public boolean locked(){
        return isLocked;
    }

    public boolean alarm(){
        return isAlarming;
    }

    public void coin(){
        state.coin();
    }

    public void pass(){
        state.pass();
    }

    protected void lock(boolean shouldLock){
        isLocked = shouldLock;
    }

    protected  void alarm(boolean shouldAlarm){
        isAlarming = shouldAlarm;
    }

    public int getCoins(){
        return coins;
    }

    public int getRefunds(){
        return refunds;
    }

    public void deposit(){
        coins++;
    }
    public void refund(){
        refunds++;
    }

}

class Locked extends Turnstile{

    @Override
    public void coin(){
        state = UNLOCKED;
        lock(false);
        alarm(false);
        deposit();
    }

    public void pass(){
        alarm(true);
    }

}

class Unlocked extends Turnstile{
    public void coin(){
        refund();
    }

    public void pass(){
        lock(true);
        state = LOCKED;
    }
}
