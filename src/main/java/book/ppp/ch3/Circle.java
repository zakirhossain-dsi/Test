package book.ppp.ch3;

public class Circle extends Shape{
    ShapeType type;
    double radius;
    Point center;

    @Override
    public void draw(){
        System.out.println("Drawing a circle....");
    }
}
