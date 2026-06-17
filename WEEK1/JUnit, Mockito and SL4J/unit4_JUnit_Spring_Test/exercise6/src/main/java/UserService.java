public class UserService {

    public void deleteUser(int id) {

        if (id <= 0) {
            throw new IllegalArgumentException("Invalid User ID");
        }
    }
}