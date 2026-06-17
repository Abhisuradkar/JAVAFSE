public class CustomerService {

    private CustomerRepository repository;

    // Dependency Injection through Constructor
    public CustomerService(CustomerRepository repository) {
        this.repository = repository;
    }

    public void getCustomerDetails(int id) {
        System.out.println(repository.findCustomerById(id));
    }
}