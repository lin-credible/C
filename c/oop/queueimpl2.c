/* 队列类型定义 */
typedef stuct NodeType {
  ItemType item;
  struct NodeType* next;
} NodeType;

typedef NodeType* Node;

typedef struct {
  Node head;
  Node tail;
  int count;
} QueueType;

int queue_initialize(Queue q) {
  q->head = NULL;
  q->tail = NULL;
  q->count = 0;
  return 0;
}

void queue_finalize(Queue q) {
  ItemType item;
  while (queue_remove(q, &item) >= 0);
}

int queue_empty(Queue q) {
  return q->count <= 0;
}

int queue_length(Queue q) {
  return q->count;
}

int queue_add(Queue q, ItemType item) {
  Node node = (Node)malloc(sizeof(NodeType));
  if (node == NULL) {
    return -1; /* 内存不足 */
  }
 
  node->item = item;
  node->next = NULL; 
  if (q->tail) {
    q->tail->next = node;
    q->tail = node;
  } else {
    q->head = q->tail = node;
  }
  ++q->count;
  return 0;
}

int queue_remove(Queue q, ItemType* item) {
  Node oldHead = q->head;
  if (q->count <= 0) {
    return -1;
  }
  
  *item = oldHead->item;
  q->head = oldHead->next;
  free(oldHead);
  if (--q->count == 0) {
    q->tail = NULL;
  }
  return 0;
}

int queue_head(Queue q, ItemType* item) {
  if (q->count <= 0) {
    return -1;
  }
  
  *item = q->head->item;
  return 0;
}

