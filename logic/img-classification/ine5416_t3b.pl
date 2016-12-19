%% INE5416 - Paradigmas de Programação (2015/2)
%%  Gustavo Zambonin (13104307)
%%  Lucas Kramer de Sousa (13100757)
%%  Marcello da Silva Klingelfus Junior (13100764)

%% T3B

:- compile('hu.pl').
:- initialization(load).

load :-
    retractall(image(_, _, _, _, _, _, _, _)),
    open('database.pl', read, Stream),
    repeat,
        read(Stream, Data),
        (
            Data == end_of_file ->
                true;
            assert(Data),
            fail
        ),
    !,
    close(Stream).

write_database :-
    open('database.pl', write, Stream),
    telling(Screen),
    tell(Stream),
    listing(image),
    tell(Screen),
    close(Stream).

new(File) :-
    readPGM(File, Raw),
    coord(Raw, Pos),
    atom_codes(Split, File),
    atomic_list_concat(JustName, '.', Split),
    nth0(0, JustName, Name),
    hu(Pos, I1, I2, I3, I4, I5, I6, I7),
    assertz(image(Name, I1, I2, I3, I4, I5, I6, I7)),
    write_database.

new(Id, I1, I2, I3, I4, I5, I6, I7) :-
    assertz(image(Id, I1, I2, I3, I4, I5, I6, I7)),
    !.

check_database(File) :-
    readPGM(File, Raw),
    coord(Raw, M),
    hu(M, I1, I2, I3, I4, I5, I6, I7),
    findall(E, image(E, _, _, _, _, _, _, _), All),
    compare(All, I1, I2, I3, I4, I5, I6, I7, W),
    min_list(W, Min),
    nb_setval(pos, -1),
    min_pos(W, Min, Pos),
    nth0(Pos, All, Image),
    atom_concat("(y/n) Is this your image? Id: ", Image, Question),
    writeln(Question),
    read(X),
    ((X = 'n') ->
        writeln("Identify it:"),
        read(Y),
        new(Y, I1, I2, I3, I4, I5, I6, I7),
        write_database,
        writeln("Image added."),
        !;
    ((X = 'y') ->
        (Min =:= 0 ->
         writeln("No operation is needed."), !;
            new(Image, I1, I2, I3, I4, I5, I6, I7),
            write_database,
            writeln("Image added."),
            !
        )
    )).

min_pos([], _, _) :-
    !.

min_pos([L|T], Min, Pos) :-
    (
        L =:= Min ->
            nb_getval(pos, P),
            Pos is P + 1;
            nb_getval(pos, P),
            NP is P + 1,
            nb_setval(pos, NP),
            min_pos(T, Min, Pos)
    ).

compare([], _, _, _, _, _, _, _, []) :-
    !.

compare([Head|Tail], I1, I2, I3, I4, I5, I6, I7, [H|T]) :-
    image(Head, X1, X2, X3, X4, X5, X6, X7),
    distance([I1, I2, I3, I4, I5, I6, I7], [X1, X2, X3, X4, X5, X6, X7], List),
    sum_list(List, Sum),
    copy_term(Sum, H),
    compare(Tail, I1, I2, I3, I4, I5, I6, I7, T).

distance([], [], []) :-
    !.

distance([X1|D1], [X2|D2], [Input|Output]) :-
    Diff is X1 - X2,
    SqrtH is sqrt(Diff^2),
    copy_term(SqrtH, Input),
    distance(D1, D2, Output).
