main(){
    close(2); // Release fd no - 2
    open("stderr.txt", "w"); // Opens file with fd no - 2
    // Child process
    if (fork() == 0) {
        exec("cmd1"); // Writes to stderr (fd no 2)
    }
}
