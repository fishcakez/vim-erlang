%%%%%%%%%%%%%%
% Attributes %
%%%%%%%%%%%%%%

-attr().

%%%%%%%%%%
% Tokens %
%%%%%%%%%%

f() ->
    SimpleAtom = case@case,
    SimpleVar = Var@case,
    ok.

%%%%%%%%%%
% Period %
%%%%%%%%%%

f() ->
    (
        .

f() ->
    (
        . % xx

f() ->
    (
        .% xx

f() ->
    A . B, % not valid Erlang, but why not behave nicely
    ok.

% bad
ok.
        f() ->
            ok.

f() ->
    A = #a{},

    %A#a . f1, % syntax error
    A#a .f1,   % valid Erlang

    %A#a.      % syntax error
    %f1,

    A#a
    .f1,   % valid Erlang

    _ = 1.2,   % valid Erlang
    %_ = 1 .2,  % syntax error
    %_ = 1 . 2, % syntax error
    %_ = 1. 2,  % syntax error

    _ = " .
    ", % valid Erlang

    _ = ' .
    ', % valid Erlang

    ok.

f() -> 1. f() -> 2. f() ->
    3.

%%%%%%%%%%%%
% Comments %
%%%%%%%%%%%%

% Comment
f() ->
    % Comment
    ok.
% Comment

%%%%%%%%%%%
% Strings %
%%%%%%%%%%%

% bad
f() ->
    x("foo
        bar")
        ,
        ok.

% bad
f() ->
    x("foo
        %        bar")
        ,
        ok.

%%%%%%%%%%%%%%%%%%%
% Basic functions %
%%%%%%%%%%%%%%%%%%%

f() ->
    ok.

%%%%%%%%%%%%%%%%%%%%%
% Actual parameters %
%%%%%%%%%%%%%%%%%%%%%

% bad
f() ->
    g(A,
        B,
        C).

%%%%%%%
% fun %
%%%%%%%

f() ->
    fun a/0,
    fun (A) ->
            A;
        (B) ->
            B
    end,
    ok.

%%%%%%%%%%%
% receive %
%%%%%%%%%%%

% receive -- with linebreaks
f() ->

    % receive with 0 branch
    receive end, % not valid Erlang, but why not behave nicely

% receive with 1 branch
receive
        A -> A
    end,

    receive
        A ->
            A
    end,

    % receive with 2 branches
    receive
        A -> A;
        B -> B
    end,

    receive
        A ->
            A;
        B ->
            B
    end,

    ok.

% receive + after -- with linebreaks
f() ->

    % receive with 0 branch
    receive
    after
        T -> T
    end,

    % receive with 1 branch
    receive
        A -> A
    after
        T -> T
    end,

    receive
        A ->
            A
    after
        T ->
            T
    end,

    % receive with 2 branches
    receive
        A -> A;
        B -> B
    after
        T -> T
    end,

    receive
        A ->
            A;
        B ->
            B
    after
        T -> T
    end,

    ok.

% receive -- one-liners
% bad
f() ->
    receive A -> A end,
    receive A -> A; B -> B end,

        % half-liners
        receive A -> A end, receive A -> A end,
        receive A -> A; B -> B end, receive A -> A; B -> B end,
                ok.

% receive + after -- one-liners
% bad
f() ->

    receive after T -> T end,
    receive A -> A after T -> T end,
    receive A -> A; B -> B after T -> T end, 

        % half-liners
        receive after T -> T end, receive after T -> T end,
        receive A -> A after T -> T end, receive A -> A after T -> T end,
        receive A -> A; B -> B after T -> T end, receive A -> A; B -> B after T -> T end, 
                ok.

% tricky scenarios which may catch some heuristics
f() ->
    receive
        A ->
            "receive"
    after
        T -> T
    end.

f() ->
    ok, receive
    after
        T -> T
    end.

%%%%%%%
% try %
%%%%%%%

f() ->
    try
        f()
    catch
        A ->
            B
    end,
    try
        f()
    catch
        A ->
            B
    after
        Timeout ->
            Timeout
    end.

f() ->
    try f()
    catch
        A -> B
    end,
    try f()
    catch
        A -> B
    after
        Timeout -> Timeout
    end.

f() ->
    try f() catch A -> B end,
    try f() catch A -> B after Timeout -> Timeout end,
    ok.

% bad
f() ->
    fun
        init/0,
        ok.

%%%%%%%%%%%
% Records %
%%%%%%%%%%%

f() ->
    A#rec.field,
    A#rec
    .field,
    ok.
