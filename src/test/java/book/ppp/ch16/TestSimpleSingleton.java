package book.ppp.ch16;

import junit.framework.TestCase;

import java.lang.reflect.Constructor;

public class TestSimpleSingleton extends TestCase {
    public TestSimpleSingleton(String name){
        super(name);
    }

    public void testCreateSingleton(){
        Singleton s1 = Singleton.getInstance();
        Singleton s2 = Singleton.getInstance();
        assertSame(s1, s2);
    }

    public void testNoPublicConstructor() throws ClassNotFoundException{
        Class singleton = Class.forName("book.ppp.ch16.Singleton");
        Constructor[] constructors = singleton.getConstructors();
        assertEquals("public constructors.", 0, constructors.length);
    }
}
