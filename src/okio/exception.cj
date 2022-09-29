

package okio

public class AssertionException <: Exception {
    public init(){
        this("")
    }
    public init(string: String) {
        super("AssertionException: \n${string}")
    }
}
public class ArrayIndexOutOfBoundsException <: Exception {
    public init(){
        this("")
    }
    public init(string: String) {
        super("ArrayIndexOutOfBoundsException: \n${string}")
    }
}
public class EOFException <: Exception {
    public init(){
        this("")
    }
    public init(string: String) {
        super("EOFException: \n${string}")
    }
}
public class InterruptedException <: Exception {
    public init(){
        this("")
    }
    public init(string: String) {
        super("InterruptedException: \n${string}")
    }
}
public class IllegalStateException <: Exception {
    public init(){
        this("")
    }
    public init(string: String) {
        super("IllegalStateException: \n${string}")
    }
}
public class NumberFormatException <: Exception {
    public init(){
        this("")
    }
    public init(string: String) {
        super("NumberFormatException: \n${string}")
    }
}
