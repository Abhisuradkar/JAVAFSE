public class MVCPatternExample {

    public static void main(String[] args) {

        Student model = new Student();
        model.setName("Suraj");
        model.setRollNo("101");

        StudentView view = new StudentView();

        StudentController controller =
                new StudentController(model, view);

        controller.updateView();

        System.out.println();

        controller.setStudentName("Rahul");
        controller.setStudentRollNo("102");

        controller.updateView();
    }
}