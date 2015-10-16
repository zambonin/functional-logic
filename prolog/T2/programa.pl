%% %%
%% INE5416 - Paradigmas de Programação (2015/2)
%% Grupo: Gustavo Zambonin (13104307)
%%        Lucas Kramer de Sousa (13100757)
%%        Marcello da Silva Klingelfus Junior (13100764)
%% %%

%% T2A
%% Usage: swipl -qs programa.pl, then type `menu.` inside the interpreter.

:- compile('desenhos.pl').

menu :-
    writeln('change.'),
    writeln('   Modifica um deslocamento existente do desenho.'),
    writeln('commit.'),
    writeln('   Grava alteracoes de todos os desenhos no banco de dados.'),
    writeln('figura(Id, X, Y).'),
    writeln('   Desenha um tetrimino tipo Z. X = Y recomendado.'),
    writeln('load.'),
    writeln('   Carrega todos os desenhos do banco de dados para a memoria.'),
    writeln('new(Id, X, Y).'),
    writeln('   Insere um deslocamento no desenho com identificador <Id>'),
    writeln('(se primeira insercao, trata-se de um ponto inicial).'),
    writeln('quadrado(Id, X, Y, Lado).'),
    writeln('   Desenha um quadrado de lado `Lado`.'),
    writeln('remove.'),
    writeln('   Remove um determinado deslocamento existente do desenho.'),
    writeln('replica(Id, N, Dx, Dy).'),
    writeln('   Replica um desenho N vezes com deslocamentos Dx, na'),
    writeln('   horizontal, e Dy, na vertical.'),
    writeln('search.'),
    writeln('   Consulta pontos do desenho.'),
    writeln('undo.'),
    writeln('   Remove o deslocamento inserido mais recentemente.').

change :-
    writeln('change(Id, X, Y, Xnew, Ynew).'),
    writeln('   Altera qualquer ponto de <Id>.'),
    writeln('changeFirst(Id, Xnew, Ynew).'),
    writeln('   Altera o ponto inicial de <Id>'),
    writeln('changeLast(Id, Xnew, Ynew).'),
    writeln('   Altera o deslocamento final de <Id>.').

search :-
    writeln('searchAll(Id).'),
    writeln('   Ponto inicial e todos os deslocamentos de <Id>.'),
    writeln('searchFirst(Id, N).'),
    writeln('   Ponto inicial e os <N-1> primeiros deslocamentos de <Id>.'),
    writeln('searchLast(Id, N).'),
    writeln('   Lista os <N> ultimos deslocamentos de <Id>.').

change(Id, X, Y, Xnew, Ynew) :-
    (findall(V, (xy(I, A, B), append([I], [A], L), append(L, [B], V)), All),
     length(All, T),
     retractall(xy(_, _, _)),
     retractall(list(_, _, _)),
     between(0, T, K),
     nth0(K, All, P),
     nth0(0, P, IdP),
     nth0(1, P, XP),
     nth0(2, P, YP),
     (IdP = Id, XP = X, YP = Y -> new(IdP, Xnew, Ynew);
      new(IdP, XP, YP)),
     false);
    true.

changeFirst(Id, Xnew, Ynew) :-
    remove(Id, _, _),
    !,
    asserta(xy(Id, Xnew, Ynew)),
    assertz(list(Id, Xnew, Ynew)).

changeLast(Id, Xnew, Ynew) :-
    findall(V, (xy(Id, X, Y), append([Id], [X], L), append(L, [Y], V)), All),
    last(All, Last),
    nth0(0, Last, IdL),
    nth0(1, Last, XL),
    nth0(2, Last, YL),
    remove(IdL, XL, YL),
    assertz(xy(Id, Xnew, Ynew)),
    asserta(list(Id, Xnew, Ynew)),
    !.

commit :-
    open('desenhos.pl', write, Stream),
    telling(Screen),
    tell(Stream),
    listing(xy),
    tell(Screen),
    close(Stream).

figura(Id, X, Y) :-
    Right is X*2,
    BigLeft is (-2)*X,
    Left is (-1)*X,
    Up is (-1)*Y,
    new(Id, X, Y),
    new(Id, Right, 0),
    new(Id, 0, Y),
    new(Id, X, 0),
    new(Id, 0, Y),
    new(Id, BigLeft, 0),
    new(Id, 0, Up),
    new(Id, Left, 0),
    new(Id, 0, Up).

load :-
    retractall(xy(_, _, _)),
    open('desenhos.pl', read, Stream),
    repeat,
        read(Stream, Data),
        (Data == end_of_file -> true ; assert(Data), fail),
        !,
        close(Stream).

new(Id, X, Y) :-
    xy(Id, _, _),
    assertz(xy(Id, X, Y)),
    asserta(list(Id, X, Y)),
    !.

new(Id, X, Y) :-
    assertz(xy(Id, X, Y)),
    asserta(list(Id, X, Y)),
    !.

quadrado(Id, X, Y, Lado) :-
    new(Id, X, Y),
    new(Id, Lado, 0),
    new(Id, 0, Lado),
    NLado is (-1) * Lado,
    new(Id, NLado, 0).

remove(Id, X, Y) :-
    retract(xy(Id, X, Y)),
    retract(list(Id, X, Y)).

replica(Id, N, Dx, Dy) :-
    between(1, N, T),
    (findall(V, (xy(Id, X, Y), append([Id], [X], L), append(L, [Y], V)), All),
     length(All, S),
     between(0, S, K),
     nth0(K, All, M),
     nth0(0, M, IdM),
     nth0(1, M, XM),
     nth0(2, M, YM),
     atom_concat(IdM, '_r', Temp),
     atom_concat(Temp, T, NewId),
     NewX is XM + (Dx*T),
     NewY is YM + (Dy*T),
     ((K =:= 0) -> new(NewId, NewX, NewY);
       new(NewId, XM, YM))),
    false.

searchAll(Id) :-
    listing(xy(Id, _, _)).

searchFirst(Id, N) :-
    findall(V, (xy(Id, X, Y), append([Id], [X], L), append(L, [Y], V)), All),
    between(1, N, Mid),
    nth1(Mid, All, Vertex),
    write(Vertex),
    write(' '),
    false.

searchLast(Id, N) :-
    findall(V, (xy(Id, X, Y), append([Id], [X], L), append(L, [Y], V)), All),
    length(All, S),
    Init is S - N,
    between(Init, S, Mid),
    nth0(Mid, All, Vertex),
    write(Vertex),
    write(' '),
    false.

undo :-
    list(X, Y, Z),
    retract(xy(X, Y, Z)),
    retract(list(X, Y, Z)),
    !.
