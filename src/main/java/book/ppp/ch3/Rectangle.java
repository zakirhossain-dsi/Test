package book.ppp.ch3;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class Rectangle extends Shape{
    ShapeType type;
    Point topLeft;
    double height;
    double width;

    public void draw(){
        System.out.println("Drawing a square....");
    }
}
