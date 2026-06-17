public class SMSNotifierDecorator extends NotifierDecorator {

    public SMSNotifierDecorator(Notifier notifier){
        super(notifier);
    }

    public void send(String msg){
        notifier.send(msg);
        System.out.println("SMS: "+msg);
    }
}