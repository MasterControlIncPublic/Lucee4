package lucee.runtime.exp;

public class TagNotImplementedException extends RuntimeException {

    public TagNotImplementedException(String tag) {
        super("tag "+tag+" is not supported");
    }
}