public class UserService {

    public String getUser(int id) {
        if (id <= 0) {
            throw new IllegalArgumentException("Invalid ID");
        }
        return "User Found";
    }
}