class MyQueue {
  // private list to store the queue
  List<int> _queue = [];

  MyQueue() {
    /* constructor */
    _queue = [];
  }

  void push(int value) {
    /* add value to the end of the queue */
    _queue.add(value);
  }

  int? pop() {
    /* remove the last element from the queue */
    if (isEmpty()) {
      return null;
    } else {
      return _queue.removeLast();
    }
  }

  int? back() {
    /* get the last element from the queue */
    if (isEmpty()) {
      return null;
    } else {
      return _queue.last;
    }
  }

  bool isEmpty() {
    /* check if the queue is empty */
    if (_queue.length == 0) {
      return true;
    } else {
      return false;
    }
  }

  @override
  String toString() {
    /* return the queue as a string */
    return "Queue: $_queue";
  }
}

void main() {
  MyQueue queue = MyQueue();
  print("Check if my queue is empty: ${queue.isEmpty()}");
  queue.push(1);
  queue.push(2);
  queue.push(3);
  print(queue);
  print("Pop: ${queue.pop()}");
  print(queue);
  print("Back: ${queue.back()}");
  print(queue);
  print("Check if my queue is empty: ${queue.isEmpty()}");
}