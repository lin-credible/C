main(){
    close(1); // Release fd no - 1
    open("stdout.txt", "w"); // Open a file with fd no = 1
    // Child process
    if (fork() == 0) {

        exec("cmd1"); // By default, the program writes to stdout (fd no - 1). ie, in this case, the file
    }
}
