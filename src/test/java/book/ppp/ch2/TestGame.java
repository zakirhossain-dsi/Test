package book.ppp.ch2;

import junit.framework.TestCase;
import org.junit.Test;

public class TestGame extends TestCase {

    private Game game;

    public TestGame(String name){
        super(name);
    }

    public void setUp(){
        game = new Game();
    }

    @Test
    public void testTwoThrowsNoMark(){
        game.add(5);
        game.add(4);
        assertEquals(9, game.score());
    }

    @Test
    public void testFourThrowsNoMark(){
        game.add(5);
        game.add(4);
        game.add(7);
        game.add(2);
        assertEquals(18, game.score());
        assertEquals(9, game.scoreForFrame(1));
        assertEquals(18, game.scoreForFrame(2));
    }

    @Test
    public void testSimpleSpare(){
        game.add(3);
        game.add(7);
        game.add(3);
        assertEquals(13, game.scoreForFrame(1));
    }

    @Test
    public void testOneThrow(){
        game.add(5);
        assertEquals(5, game.score());
        assertEquals(1, game.getCurrentFrame());
    }

    @Test
    public void testSimpleFrameAfterSpare(){
        game.add(3);
        game.add(7);
        game.add(3);
        game.add(2);
        assertEquals(13, game.scoreForFrame(1));
        assertEquals(18, game.scoreForFrame(2));
        assertEquals(18, game.score());
    }

    @Test
    public void testSimpleStrike(){
        game.add(10);
        game.add(3);
        game.add(6);
        assertEquals(19, game.scoreForFrame(1));
        assertEquals(28, game.score());
    }

    @Test
    public void testPerfectGame(){
        for(int i = 0; i < 12; i++){
            game.add(10);
        }
        assertEquals(300, game.score());
    }

    @Test
    public void testEndOfArray(){
        for(int i = 0; i < 19; i++){
            game.add(0);
            game.add(0);
        }
        game.add(2);
        game.add(8);    // 10th frame spare.
        game.add(10);   // strike in the last position of array.
        assertEquals(20, game.score());

    }

    @Test
    public void testSampleGame(){
        game.add(1);
        game.add(4);
        game.add(4);
        game.add(5);
        game.add(6);
        game.add(4);
        game.add(5);
        game.add(5);
        game.add(10);
        game.add(0);
        game.add(1);
        game.add(7);
        game.add(3);
        game.add(6);
        game.add(4);
        game.add(10);
        game.add(2);
        game.add(8);
        game.add(6);
        assertEquals(133, game.score());
    }

    @Test
    public void testHeartBreak(){
        for( int i = 0; i < 9; i ++){
            game.add(10);
        }
        game.add(9);
        assertEquals(299, game.score());
    }

    @Test
    public void testTenthFrameSpare(){
        for( int i = 0; i<9; i++){
            game.add(10);
        }
        game.add(9);
        game.add(1);
        game.add(1);
        assertEquals(270, game.score());
    }
}
