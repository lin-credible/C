typedef char ItemType;

typedef QueueType* Queue;

int queue_initialize(Queue);

void queue_finalize(Queue);

int queue_add(Queue, ItemType);

int queue_remove(Queue, ItemType*);

int queue_empty(Queue);

int queue_length(Queue);

int queue_head(Queue, ItemType*);
