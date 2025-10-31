enum QuadraticSolution:
  case OneSolution(solution_exists: true, x1: Double, x2: Null)
  case TwoSolutions(solution_exists: true, x1: Double, x2: Double)
  case NoSolution(solution_exists: false, x1: Null, x2: Null)

// a)
def quadratic_equation(a: Double, b: Double, c: Double): QuadraticSolution = {
  val discriminant = b * b - (4 * a * c)

  if discriminant < 0 then
    QuadraticSolution.NoSolution(false, null, null)
  else if (0 < discriminant) then 
    QuadraticSolution.TwoSolutions(true,
      -b + math.sqrt(discriminant) / 2 * a,
      -b - math.sqrt(discriminant) / 2 * a)
  else
    QuadraticSolution.OneSolution(true, -b / 2 * a, null)
}

// b)
def quadratic(a: Double, b: Double, c: Double): (x: Double) => Double = {
  (x: Double) => a * x * x + b * x + c
}

@main
def task2(): Unit = {
  val q = quadratic(3, 2, 1)
  println(f"${q(2)} should be 17")
}