// a)
def init_thread(arg: () => Unit): Thread = {
  new Thread {
    override def run(): Unit = arg()
  }
}
// b)
/* What is this code supposed to do?
It is supposed to spin up 2 threads which move values from 1 to 2

No

The threads reads and writes are overlapping

Yes, if we use memory cells instead of idiomatic Oz dataflow variables + message passing


 */
// c)
/* 
We can achieve thread-safety using two techniques.
Use AtomicInteger instead of mutable Ints
or use synchronized{...} code blocks
 */
import java.util.concurrent.atomic.AtomicInteger
object AtomicSolution {
  private var value1 = new AtomicInteger(1000)
  private var value2 = new AtomicInteger(0)
  private var sum: Int = 0

  def moveOneUnit(): Unit = {
    value1.getAndDecrement()
    value2.getAndIncrement()
    if(value1.get() == 0) {
      value1.set(1000)
      value2.set(0)
    }
  }

  def updateSum(): Unit = {
    sum = value1.get() + value2.get()
  }
  
  def execute(): Unit = {
    while(true) {
      moveOneUnit()
      updateSum()
      Thread.sleep(50)
    }
  }

  // This is the "main" method, the entry point of execution.
  // It could have been placed in a different file.
  def main(args: Array[String]): Unit = {
    for (i <- 1 to 2) {
      val thread = new Thread {
        override def run = execute()
      }
      thread.start()
    }
    
    while(true) {
      updateSum()
      println(sum + " [" + value1.get() + " " + value2.get() + "]")
      Thread.sleep(100)
    }
  }
}

object SynchronizedSolution {
  private var value1 = 1000
  private var value2 = 0
  private var sum: Int = 0

  def moveOneUnit(): Unit = synchronized{
    value1 -= 1
    value2 += 1
    if(value1 == 0) {
      value1 = 1000
      value2 = 0
    }
  }

  def updateSum(): Unit = {
    sum = value1 + value2
  }
  
  def execute(): Unit = {
    while(true) {
      moveOneUnit()
      updateSum()
      Thread.sleep(50)
    }
  }

  def main(args: Array[String]): Unit = {
    for (i <- 1 to 2) {
      val thread = new Thread {
        override def run = execute()
      }
      thread.start()
    }
    
    while(true) {
      updateSum()
      println(sum + " [" + value1 + " " + value2 + "]")
      Thread.sleep(100)
    }
  }
}