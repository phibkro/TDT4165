% Task 3

% 3.a

local X Y=300 Z=30 in
  X = Y * Z
  {Show X}
end

% 3.b

local X Y in
  X = "This is a string"
  thread {System.showInfo Y} end
  Y = X
end

% Because Y is already known to be unified with X,
% Since X is known, and Y is unified with X, both variables (constants) point to the same thing

% This behavior can be useful if we want to solve equations, or maybe for asynchronous calculations
% In this example, we use it to write code out of order, breaking out of our imperative ways for declarativeness,
% which could help co-locate code with the same concerns that technically execute out-of-order
% This also shifts our perspective of execution from top to bottom and replace it with left to right columns of execution

% Y = X unifies the "variables" (constants kinda) Y and X, making them effectively the same

% Task 4

% 4.a

declare fun {Max X Y}
  if X > Y then
    X
  else
    Y
  end
end

{Show {Max 20 30}}
{Show {Max 30 20}}

% 4.b

declare proc {PrintGreater X Y}
  {Show {Max X Y}}
end

{PrintGreater 40 50}
{PrintGreater 60 50}

% Task 5
% TODO

declare proc {Circle R} Pi=355/113 Area Diameter Circumference 
  Pi = 355/113
  Area = Pi * R * R
  Diameter = 2 * R
  Circumference = Pi * Diameter
  {Show (Area Diameter Circumference)}
end

{Circle 1}

% Task 6

declare fun {Factorial N}
  if N < 0 then
    0 % Negative integers return 0 as error
  elseif N == 0 then
    1
  else
    N * {Factorial (N - 1)}
  end
end

{Show {Factorial 5}}
{Show {Factorial 0}}

% Task 7

% 7.a

declare fun {Length List}
  case List
  of _ | XS then
    {Length XS} + 1
  else
    0
  end
end

{Show {Length nil}}
{Show {Length [1 2 3 4]}}

% 7.b

declare fun {Take List Count}
  if Count =< 0 then nil else

  case List
  of X | XS then
    X | {Take XS (Count - 1)}
  end

  end
end

{Show {Take [1 2 3 4 5] 3}}

% 7.c

declare fun {Drop List Count}
  if Count =< 0 then List else
  
  case List
  of _ | XS then
    {Drop XS Count - 1}
  end

  end
end

{Show {Drop [1 2 3 4 5] 3}}

% 7.d

declare fun {Append List1 List2}
  case List1
  of X | XS then
    X | {Append XS List2}
  else
    List2
  end
end

{Show {Append [1 2 3] [4 5 6]}}

% 7.e

declare fun {Member List Element}
  case List
  of X | XS then
    if X == Element then
      true
    else
      {Member XS Element}
    end
  else
    false
  end
end

{Show {Member [1 2 3 4 5] 4}}
{Show {Member [1 2 3 4 5] 8}}

% 7.f

declare fun {PosIter L E I}
  case L
  of X | XS then
    if X == E then I else
      {PosIter XS E I + 1}
    end
  else
    0
  end
end

declare fun {Position List Element}
  {PosIter List Element 1}
end

{Show {Position [1 2 3 4 5] 3}}

% Task 8

% 8.a

declare fun {Push List Element}
  if List == nil then [Element] else
    Element | List
  end
end

{Show {Push nil 5}}
{Show {Push [2 3 4] 1}}

% 8.b

declare fun {Peek List}
  case List
  of X | _ then
    X
  else
    nil
  end
end

{Show {Peek nil}}
{Show {Peek [1 2 3]}}

% 8.c

declare fun {Pop List}
  case List
  of _ | XS then
    XS
  else
    nil
  end
end

{Show {Pop nil}}
{Show {Pop [1]}}
{Show {Pop [1 2 3 4 5]}}