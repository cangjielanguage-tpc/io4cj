import std.process.*
import std.fs.*

func stagePostBuild(): Int64 {
    // protoc-gen-cj无法直接作为编译输出名称 手动拷贝
    copy("crypto4cj/lib/libcrypto.so", to: "target/release/crypto4cj/libcrypto.so", overwrite: true)
    copy("crypto4cj/lib/libcrypto.dll", to: "target/release/crypto4cj/libcrypto.dll", overwrite: true)
    0
}
main(): Int64 {
    match (Process.current.arguments[0]) {
        // Add operation here with format: "pre-"/"post-" + optionName
        // case "pre-build" => stagePreBuild()
        case "post-build" => stagePostBuild()
        // case "pre-clean" => stagePreClean()
        // case "post-clean" => stagePostClean()
        case _ => 0
    }
}