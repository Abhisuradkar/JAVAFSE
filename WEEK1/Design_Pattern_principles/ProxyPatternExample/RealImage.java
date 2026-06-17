public class RealImage implements Image {

    private String fileName;

    public RealImage(String fileName){
        this.fileName=fileName;
        System.out.println("Loading "+fileName);
    }

    public void display(){
        System.out.println("Displaying "+fileName);
    }
}