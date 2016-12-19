%% INE5416 - Paradigmas de Programação (2015/2)
%%  Gustavo Zambonin (13104307)
%%  Lucas Kramer de Sousa (13100757)
%%  Marcello da Silva Klingelfus Junior (13100764)

%% T3A

:- compile('img.pl').

negative(File) :-
    readPGM(File, Raw),
    coord(Raw, Pos),
    calc_neg(Pos, OutInvert),
    coord2matrix(OutInvert, NewMat),
    output(File, '_neg.pgm', NewMat).

calc_neg([], []) :-
    !.

calc_neg([(X, Y, D)|In], [NewTuple|Out]) :-
    InvDepth is 255 - D,
    copy_term((X, Y, InvDepth), NewTuple),
    calc_neg(In, Out).

output(OldName, Append, Matrix) :-
    atom_codes(Split, OldName),
    atomic_list_concat(JustName, '.', Split),
    nth0(0, JustName, Name),
    atom_concat(Name, Append, NewName),
    atom_concat("Output: ", NewName, Out),
    writePGM(NewName, Matrix),
    writeln(Out).


mean(File1, File2) :-
    readPGM(File1, Raw1),
    coord(Raw1, Pos1),
    readPGM(File2, Raw2),
    coord(Raw2, Pos2),
    calc_am(Pos1, Pos2, OutCalc),
    coord2matrix(OutCalc, NewMat),
    output([], 'avg.pgm', NewMat).

calc_am([], [], []) :-
    !.

calc_am([(X, Y, D1)|In1], [(_, _, D2)|In2], [NewTuple|Out]) :-
    AvgDepth is (D1 + D2)/2,
    copy_term((X, Y, AvgDepth), NewTuple),
    calc_am(In1, In2, Out).


isolated_pixel(File) :-
    readPGM(File, Raw),
    coord(Raw, Pos),
    check_isolt(Pos, Pos, [], Out),
    writeln(Out),
    !.

check_isolt(_, [], T, Output) :-
    reverse(T, Output).

check_isolt(Pos, [(X, Y, D)|In], List, Out) :-
    n4(Pos, (X, Y, D), Neighbors),
    (check_neighb(Neighbors, D) ->
        check_isolt(Pos, In, [(X, Y, D)|List], Out);
    check_isolt(Pos, In, List, Out)).

check_neighb([], _) :-
    !.

check_neighb([(_, _, D)|In], Out) :-
    Out > D,
    check_neighb(In, Out).


path_between([], _, _, []) :-
    !.

path_between(File, (X1, Y1, _), (X2, Y2, _), [H|T]) :-
    readPGM(File, Raw),
    coord(Raw, Pos),
    getPixel(Pos, (X1, Y1, D1)),
    getPixel(Pos, (X2, Y2, D2)),
    copy_term((X1, Y1), H),
    (
        equal_coord((X1, Y1, _), (X2, Y2, _)) ->
            write("Path:"),
            copy_term([], T),
            true;
        n4(Pos, (X1, Y1, D1), Neighbors),
        check_depth(Neighbors, (X1, Y1, D1), (X2, Y2, D2), Greater),
        (
            equal_pixel((X1, Y1, D1), Greater) ->
                writeln("No path found."),
                copy_term([], T);
            path_between(File, Greater, (X2, Y2, 0), T)
        )
    ).

equal_coord((X1, Y1, _), (X2, Y2, _)) :-
    X1 = X2,
    Y1 = Y2,
    true.

equal_pixel((X1, Y1, _), (X2, Y2, _)) :-
    X1 = X2,
    Y1 = Y2,
    !.

check_depth([], (X1, Y1, D1), (_, _, _), (X, Y, D)) :-
    X is X1,
    Y is Y1,
    D is D1.

check_depth([(X, Y, D)|Tail], (X1, Y1, D1), (X2, Y2, D2), Gt) :-
    (equal_pixel((X1, Y1, D1), (X2, Y2, D2)) ->
        check_depth([], (X1, Y1, D1), (X2, Y2, D2), Gt);
        (D >= D1 ->
            check_depth(Tail, (X, Y, D), (X2, Y2, D2), Gt);
        check_depth(Tail, (X1, Y1, D1), (X2, Y2, D2), Gt))).
