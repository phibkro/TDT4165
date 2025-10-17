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