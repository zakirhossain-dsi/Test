package book.ppp.ch16;

import junit.framework.TestCase;

public class TestMonoState extends TestCase {

    public TestMonoState(String name){
        super(name);
    }

    public void testInstance(){
        MonoState m = new MonoState();
        for(int x = 0; x < 10; x++){
            m.setX(x);
            assertEquals(x, m.getX());
        }
    }

    public void testInstancesBehaveAsOne(){
        MonoState m1 = new MonoState();
        MonoState m2 = new MonoState();
        for(int x = 0; x < 10; x++){
            m1.setX(x);
            assertEquals(x, m2.getX());
        }
    }
}
