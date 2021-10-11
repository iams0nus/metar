class ArrayUtils {
  List<List<String>> chunk(List<String> list, int chunkSize) {
    List<List<String>> chunks = [];
    int len = list.length;
    for (var i = 0; i < len; i += chunkSize) {
      int size = i + chunkSize;
      chunks.add(list.sublist(i, size > len ? len : size));
    }
    return chunks;
  }
}
