package book.ppp.ch3;

public class Square extends Shape{
    ShapeType type;
    double side;
    Point topLeft;

    @Override
    public void draw(){
        System.out.println("Drawing a square....");
    }
}
