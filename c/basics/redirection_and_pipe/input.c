main(){
    close(0);//Release fd - 0
    open("stdout.txt", "r"); //Open file with fd - 0

    //Child process
    if (fork() == 0) {
        exec("cmd3"); // By default, program reads from stdin. ie, fd - 0
    }
}
