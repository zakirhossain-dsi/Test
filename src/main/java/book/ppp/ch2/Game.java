package book.ppp.ch2;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@NoArgsConstructor
public class Game {
    private int currentFrame = 1;
    private boolean firstThrowInFrame = true;
    private int firstThrow;
    private int secondThrow;
    private Scorer scorer = new Scorer();

    public int score(){
        return scoreForFrame(currentFrame);
    }

    public void add(int pins){
        scorer.addThrow(pins);
        adjustCurrentFrame(pins);
    }

    private void adjustCurrentFrame(int pins){
        if(lastBallInFrame(pins)){
            advanceFrame();
        }else{
            firstThrowInFrame = false;
        }
    }

    private boolean lastBallInFrame(int pins){
        return strike(pins) || !firstThrowInFrame;
    }

    private boolean strike(int pins){
        return (firstThrowInFrame && pins == 10);
    }

    private void advanceFrame(){
        currentFrame = Math.min(10, currentFrame + 1);
    }

    public int scoreForFrame(int frame){
        return scorer.getScoreForFrame(frame);
    }
}
