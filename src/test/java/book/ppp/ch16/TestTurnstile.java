package book.ppp.ch16;

import junit.framework.TestCase;

public class TestTurnstile extends TestCase {
    public TestTurnstile(String name){
        super(name);
    }

    @Override
    public void setUp(){
        Turnstile t = new Turnstile();
        t.reset();
    }

    public void testInit(){
        Turnstile t = new Turnstile();
        assertTrue("locked", t.locked());
        assertTrue("Not alarming", !t.alarm());
    }

    public void testCoin(){
        Turnstile t = new Turnstile();
        t.coin();

        Turnstile t1 = new Turnstile();
        assert(!t1.locked());
        assert(!t1.alarm());
        assertEquals("coins", 1, t1.getCoins());
    }

    public void testCoinAndPass(){
        Turnstile t = new Turnstile();
        t.coin();
        t.pass();

        Turnstile t1 = new Turnstile();
        assert(t1.locked());
        assert(!t1.alarm());
        assertEquals("coins", 1, t1.getCoins());
    }

    public void testTwoCoins(){
        Turnstile t = new Turnstile();
        t.coin();
        t.coin();

        Turnstile t1 = new Turnstile();
        assert(!t1.locked());
        assertEquals("coins", 1, t1.getCoins());
        assertEquals("refunds", 1, t1.getRefunds());
        assert(!t1.alarm());
    }

    public void testPass(){
        Turnstile t = new Turnstile();
        t.pass();

        Turnstile t1 = new Turnstile();
        assertTrue("alarm", t1.alarm());
        assertTrue("locked", t1.locked());
    }

    public void testCancelAlarm(){
        Turnstile t = new Turnstile();
        t.pass();
        t.coin();

        Turnstile t1 = new Turnstile();
        assertFalse("alarm", t1.alarm());
        assertFalse("locked", t1.locked());
        assertEquals("coin", 1, t1.getCoins());
        assertEquals("refunds", 0, t1.getRefunds());
    }

    public void testTwoOperations(){
        Turnstile t = new Turnstile();
        t.coin();
        t.pass();
        t.coin();

        assertFalse("locked", t.locked());
        assertEquals("coins", 2, t.getCoins());
        t.pass();
        assertTrue("locked", t.locked());
    }
}
