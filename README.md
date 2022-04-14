checkimage is an executable that checks if a docker image exists. This is mostly a demonstration of how to debug a golang app running in docker with dlv and VSCode to illustrate a problem in VSCode.

To build a docker image that contains that executable run `make docker-build`. 

To debug that executable run `make debug`, that runs a docker container with a headless dlv debugger which listens for a client debugger. A vscode launch.json configuration is provided. 

To repro the problem, in VSCode, set a breakpoint on `[$GOPATH]/pkg/mod/github.com/google/go-containerregistry@v0.8.0/pkg/v1/remote/descriptor.go` line 106, and launch the VSCode launch configuration to debug. The breakpoint will hit, step over, VScode's debug console should show this error:
```
Unhandled error in debug adapter: TypeError: Cannot read properties of undefined (reading 'addr')
    at GoDebugSession.convertDebugVariableToProtocolVariable (/Users/mipnw/.vscode/extensions/golang.go-0.32.0/dist/debugAdapter.js:16651:25)
    at /Users/mipnw/.vscode/extensions/golang.go-0.32.0/dist/debugAdapter.js:16219:55
    at processTicksAndRejections (node:internal/process/task_queues:96:5)
    at async Promise.all (index 3)
```
and the container running the debuggee should have exited with `debug layer=debugger detaching`.