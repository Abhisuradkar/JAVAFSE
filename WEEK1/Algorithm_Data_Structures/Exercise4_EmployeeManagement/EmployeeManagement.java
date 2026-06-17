class Employee {
    int employeeId;
    String name;
    String position;
    double salary;

    Employee(int id, String name, String position, double salary) {
        this.employeeId = id;
        this.name = name;
        this.position = position;
        this.salary = salary;
    }
}

public class EmployeeManagement {

    static Employee[] employees = new Employee[10];
    static int count = 0;

    static void addEmployee(Employee e) {
        employees[count++] = e;
    }

    static void searchEmployee(int id) {
        for (int i = 0; i < count; i++) {
            if (employees[i].employeeId == id) {
                System.out.println(employees[i].name);
            }
        }
    }

    static void traverse() {
        for (int i = 0; i < count; i++) {
            System.out.println(employees[i].name);
        }
    }

    public static void main(String[] args) {

        addEmployee(new Employee(1, "Abhishek", "Developer", 50000));
        addEmployee(new Employee(2, "Rahul", "Tester", 40000));

        traverse();
        searchEmployee(1);
    }
}