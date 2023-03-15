package book.ppp.ch16;

import lombok.Getter;
import lombok.Setter;

public class MonoState {
    private static int x;

    public int getX() {
        return x;
    }

    public void setX(int x) {
        MonoState.x = x;
    }
}
