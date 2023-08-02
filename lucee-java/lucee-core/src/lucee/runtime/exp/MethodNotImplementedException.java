package lucee.runtime.exp;

public class MethodNotImplementedException extends RuntimeException {
    public MethodNotImplementedException(String className, String methodName) {
        super(methodName + ": method is not implemented for Class: " + className + ".");
    }
}