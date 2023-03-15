package book.ppp.ch2;

public class Scorer {
    private int ball;
    private int[] itsThrows = new int[21];
    private int currentThrow = 0;

    public void addThrow(int pins){
        itsThrows[currentThrow++] = pins;
    }

    public int getScoreForFrame(int frame){
        int score = 0;
        ball = 0;
        for(int currentFrame = 0; currentFrame < frame; currentFrame++){
            if(strike()){
                score = 10 + nextTwoBallsForStrike();
                ball++;
            }else if (spare()) {
                score += 10 + nextBallSpare();
                ball += 2;
            }else {
                score = twoBallsInFrame();
                ball += 2;
            }
        }
        return score;
    }

    private boolean strike() {
        return itsThrows[ball] == 10;
    }

    private boolean spare(){
        return (itsThrows[ball] + itsThrows[ball + 1]) == 10;
    }

    private int nextTwoBallsForStrike() {
        return itsThrows[ball + 1] + itsThrows[ball + 2];
    }

    private int nextBallSpare(){
        return itsThrows[ball + 2];
    }

    private int twoBallsInFrame(){
        return itsThrows[ball] + itsThrows[ball + 1];
    }
}
