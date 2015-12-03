main(){
    int p[2];
    pipe(p); // Creates a pipe with file descriptors Eg. input = 3 and output = 4 (Since, 0,1 and 2 are not available)

    if (fork() == 0) {
    // Child process
        close(0); // Release fd no - 0
        close(p[0]); // Close pipe fds since useful one is duplicated
        close(p[1]);
        dup(p[0]); // Create duplicate of fd - 3 (pipe read end) with fd 0.
        exec("cmd2");
    } else {
        //Parent process
        close(1); // Release fd no - 1
        close(p[0]); // Close pipe fds since useful one is duplicated
        close(p[1]);
        dup(p[1]); // Create duplicate of fd - 4 (pipe write end) with fd 1.
        exec("cmd1");
    }
}
