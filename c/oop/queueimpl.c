/* 数组实现 */

typedef struct {
  ItemType* data;
  int first;
  int last;
  int count;
  int size;
} QueueType;

int queue_initialize(Queue q) {
  int size = 100; /* 初始容量 */
  q->size = size;
  q->data = (ItemType*)malloc(sizeof(ItemType) * size);
  if (q->data == NULL) {
    return -1; /* 内存不足 */
  }
  
  q->first = 0;
  q->last = -1;
  q->count = 0;
  return 0;
}

void queue_finalize(Queue q) {
  free(q->data);
  q->data = NULL;
  q->first = 0;
  q->last = -1;
  q->count = 0;
}

int queue_empty(Queue q) {
  return q->count <= 0;
}

int queue_length(Queue q) {
  return q->count;
}

/* （内部函数）扩大队列容量 */
static int queue_resize(Queue q) {
  int oldSize = q->size;
  int newSize = oldSize * 2;
  int newIndex;
  int oldIndex = q->first;
  ItemType * data = (ItemType*)malloc(sizeof(ItemType) * newSize);
  
  if (data == NULL) {
    return -1; /* 内存不足 */
  }

  /* 复制到新数组 */
  for (newIndex = 0; newIndex < q->count; ++newIndex) {
    data[newIndex] = q->data[oldIndex];
    oldIndex = (oldIndex + 1) % oldSize;
  }
  
  free(q->data);
  q->data = data;
  q->first = 0;
  q->last = oldSize - 1;
  q->size = newSize;
  return 0;
}

int queue_add(Queue q, ItemType item) {
  if (q->count >= q->size) {
    if (queue_resize(q) < 0) {
      return -1; /* 内存不足  */
    }
  }
  
  q->last = (q->last + 1) % q->size;
  q->data[q->last] = item;
  ++q->count;
  return 0;
}

int queue_remove(Queue q, ItemType* item) {
  if (q->count <= 0) {
    return -1;
  }
  
  *item = q->data[q->first];
  q->first = (q->first + 1) % q->size;
  --q->count;
  return 0;
}

int queue_head(Queue q, ItemType* item) {
  if (q->count <= 0) {
    return -1;
  }

  *item = q->data[q->first];
  return 0;
}

