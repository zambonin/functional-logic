%% INE5416 - Paradigmas de Programação (2015/2)
%%  Gustavo Zambonin (13104307)
%%  Lucas Kramer de Sousa (13100757)
%%  Marcello da Silva Klingelfus Junior (13100764)

%% T3A

:- compile('img.pl').

%% double quotes
negativo(File) :-
    readPGM(File, Raw),
    coord(Raw, Pos),
    invert(Pos, OutInvert),
    coord2matrix(OutInvert, NewMat),
    output(File, NewMat).

invert([], []) :-
    !.

invert([(X, Y, D)|In], [NewTuple|Out]) :-
    InvDepth is 255 - D,
    copy_term((X, Y, InvDepth), NewTuple),
    invert(In, Out).

output(Oldname, Matrix) :-
    atom_codes(X, Oldname),
    atomic_list_concat(Y, '.', X),
    nth0(0, Y, Li),
    atom_concat(Li, '_neg.pgm', Newname),
    atom_concat("Output: ", Newname, Out),
    writePGM(Newname, Matrix),
    writeln(Out).
