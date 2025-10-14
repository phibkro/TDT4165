import scala.collection.mutable.ArrayBuffer

@main
def main(): Unit =
  // a)
  var nums: ArrayBuffer[Int] = ArrayBuffer() 
  for i <- 1 to 50 do nums.append(i)
  println(nums)
  println(f"Sum: ${iterative_sum(nums)}")
  println(f"Sum: ${recursive_sum(nums, 0)}")
  println(f"Fib: ${nth_fib(5)}")

// b)
def iterative_sum(iter: Iterable[Int]): Int = {
  var sum: Int = 0
  for 
    e <- iter.iterator
  do
    sum = sum + e
  sum
}

// c)
def recursive_sum(iter: Iterable[Int], acc: Int): Int = {
  try
    recursive_sum(iter.tail, acc + iter.head)
  catch
    case _ => acc
}

// d)
/* 
Difference between Int and BigInt is that
Int is a 32-bit number
BigInt is larger
 */
def nth_fib(n: Int): BigInt = {
  n match
    case 0 => 1
    case 1 => 1
    case _ => nth_fib(n - 1) + nth_fib(n - 2)
}