class Task {
    int taskId;
    String taskName;
    String status;
    Task next;

    Task(int id, String name, String status) {
        taskId = id;
        taskName = name;
        this.status = status;
    }
}

public class TaskManagement {

    Task head;

    void addTask(int id, String name, String status) {
        Task newTask = new Task(id, name, status);

        if (head == null) {
            head = newTask;
            return;
        }

        Task temp = head;

        while (temp.next != null)
            temp = temp.next;

        temp.next = newTask;
    }

    void traverse() {
        Task temp = head;

        while (temp != null) {
            System.out.println(temp.taskName);
            temp = temp.next;
        }
    }

    public static void main(String[] args) {

        TaskManagement tm = new TaskManagement();

        tm.addTask(1, "Coding", "Pending");
        tm.addTask(2, "Testing", "Completed");

        tm.traverse();
    }
}