main(){
    close(1); // Release fd no - 1
    open("stdout_stderr.txt", "w"); //Opens file with fd no - 1
    // Child process
    if (fork() == 0) {
        close(2); // Release fd no - 2
        dup(1); // Create fd no - 2 which is duplicate of fd no -1. Hence, we joined fd 1 and 2 (stdout and  stderr)
        exec("cmd2");
    }
}
