package okio


public class Okio {

    private init (){}


    public static func buffer(source: Source): BufferedSource {
        return RealBufferedSource(source)
    }

    // public static func buffer(sink: Sink): BufferedSink {
    //     return RealBufferedSink(sink)
    // }

}