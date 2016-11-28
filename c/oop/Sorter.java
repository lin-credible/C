
public class Sorter {
  public static <T extends Comparable<? super T>> void qsort(T[] list) {
    qsort(list, 0, list.length - 1);
  }

  private static <T extends Comparable<? super T>> void qsort(T[] list, int low, int high) {
    if (low >= high) return;
    
    int i = low - 1, j = high + 1;
    T pivot = list[low];
    
    for (;;) {
      do {++i;} while (list[i].compareTo(pivot) < 0);
      do {--j;} while (list[j].compareTo(pivot) > 0);
      
      if (i >= j) break;
      
      T tmp = list[i]; list[i] = list[j]; list[j] = tmp;
    }

    qsort(list, low, j);
    qsort(list, j + 1, high);
  }
}
