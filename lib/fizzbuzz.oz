declare proc {Main}
  for I in 1..100 do
    {Show {FizzBuzz I}}
  end
end
{Main}

declare fun {Tail List}
  case List
  of X | XS then
    if XS == nil then X else
      {List XS}
    end
  end
end

declare fun {FizzBuzz N} Message in
  {Fizz N Message}
  {Delay 1}
  {Buzz N Message}
  {Delay 1}
  case Message
  of X | XS then
    body
  end
end

declare proc {Fizz N Log}
  if N mod 3 == 0 then
    Log#'Fizz'
  end
end

declare proc {Buzz N Log}
  if N mod 5 == 0 then
    Log#'Buzz'
  end
end
