QueueType queue;
Queue q = &queue;
char item;
int i;

queue_initialize(q);

/* 将26个字母加入队列 */
for (i = 0; i < 26; ++i) {
  queue_add(q, 'a' + i);
}

printf("Queue is %s\n", queue_empty(q) ? "empty": "nonempty");
printf("Queue length = %d\n", queue_length(q));

while (queue_remove(q, &item) == 0) {
  printf("removing queue item:[%c].\n", item);
}

printf("Queue is %s\n", queue_empty(q) ? "empty": "nonempty");
queue_finalize(q);

