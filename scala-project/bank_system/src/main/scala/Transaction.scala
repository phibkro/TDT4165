import java.util.Queue
object TransactionStatus extends Enumeration {
  val SUCCESS, PENDING, FAILED = Value
}

class TransactionPool {
    private var queue: Queue[Transaction] = new Queue()

     // Remove and the transaction from the pool
    def remove(t: Transaction): Boolean = synchronized{
      queue.remove(t)
    }

    // Return whether the queue is empty
    def isEmpty: Boolean = synchronized{
      queue.isEmpty()
      }

    // Return the size of the pool
    def size: Integer = synchronized{
      queue.size()
    }

    // Add new element to the back of the queue
    def add(t: Transaction): Boolean = synchronized{
      queue.add(t)
    }

    // Return an iterator to allow you to iterate over the queue
    def iterator : Iterator[Transaction] = synchronized{
      queue.iterator()
    }
}

class Transaction(val from: String,
                  val to: String,
                  val amount: Double,
                  val retries: Int = 3) {

  private var status: TransactionStatus.Value = TransactionStatus.PENDING
  private var attempts = 0

  def getStatus() = status

  // TODO: Implement methods that change the status of the transaction
  def fail() = {
    status = TransactionStatus.FAILED
  }

  def succeed() = {
    status = TransactionStatus.SUCCESS
  }

}
