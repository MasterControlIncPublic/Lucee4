package lucee.runtime.exp;

public class NotImplementedException extends RuntimeException {

    public NotImplementedException(String tag) {
        super("tag "+tag+" is not supported");
    }
}