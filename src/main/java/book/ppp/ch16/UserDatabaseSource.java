package book.ppp.ch16;

public class UserDatabaseSource implements UserDatabase{
    private static UserDatabase theInstance = new UserDatabaseSource();

    private UserDatabaseSource(){

    }
    public static UserDatabase instance(){
        return theInstance;
    }

    @Override
    public User readUser(String userName) {
        System.out.println("Reading user....");
        return null;
    }

    @Override
    public void writeUser(User user) {
        System.out.println("Writing user...");
    }
}
