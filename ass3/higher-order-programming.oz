% Task 1
declare QuadraticEquation in

proc {QuadraticEquation A B C ?RealSol ?X1 ?X2} Delta X Y Z in
  X = {IntToFloat A}
  Y = {IntToFloat B}
  Z = {IntToFloat C}
  Delta = (Y * Y) - (4.0 * X * Z)

  if Delta == 0.0 then
    RealSol = true
    X1 = ~Y / (2.0 * X)
    X2 = X1
  elseif 0.0 < Delta then
    RealSol = true
    X1 = (~Y + {Sqrt Delta}) / (2.0 * X)
    X2 = (~Y - {Sqrt Delta}) / (2.0 * X)
  else
    RealSol = false
  end
end

local X1 X2 RealSol in
  {QuadraticEquation 2 1 (~1) RealSol X1 X2}
  {Show X1}
  {Show X2}
  {Show RealSol}
end

local X1 X2 RealSol in
  {QuadraticEquation 2 1 2 RealSol X1 X2}
  {Show X1}
  {Show X2}
  {Show RealSol}
end

% Task 2
declare Sum in

fun {Sum List}
  case List
  of X | XS then
    {Sum XS} + X
  else
    0
  end
end

{Show {Sum [1 2 3 4]}}

% Task 3
declare RightFold Sum Length in

fun {RightFold List Op U}
  case List
  of X | XS then
    {Op X {RightFold XS Op U}}
  else
    U
  end
end

fun {Length List}
  {RightFold List fun {$ X Acc} 1 + Acc end 0}
end

fun {Sum List}
  {RightFold List fun {$ A B} A + B end 0}
end

{Show {Length [1 2 3 4]}}  % Should output 4
{Show {Sum [1 2 3 4]}}     % Should output 10

% (d) Example of operation where LeftFold and RightFold give different results:
% Division is not associative: (8 / 4) / 2 = 1, but 8 / (4 / 2) = 4
% RightFold with subtraction: 1 - (2 - (3 - 4)) = 1 - (2 - (-1)) = 1 - 3 = -2
% LeftFold with subtraction: ((1 - 2) - 3) - 4 = ((-1) - 3) - 4 = -4 - 4 = -8

% (e) Product function using RightFold - neutral element is 1
declare Product in
fun {Product List}
  {RightFold List fun {$ A B} A * B end 1}  % U = 1 for multiplication
end

{Show {Product [2 3 4]}}  % Should output 24

% Task 4
declare Quadratic in

fun {Quadratic A B C}
  fun {$ A B C} 
  end
end

{Show {{Quadratic 3 2 1} 2}}

% Task 5
declare LazyNumberGenerator in

fun {LazyNumberGenerator}
  body
end