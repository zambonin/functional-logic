%% %%
%% INE5416 - Paradigmas de Programação (2015/2)
%% Grupo: Gustavo Zambonin (13104307)
%%        Lucas Kramer de Sousa (13100757)
%%        Marcello da Silva Klingelfus Junior (13100764)
%% %%

%% T2A
%% Usage: swipl -s programa.pl, then type `menu.` inside the interpreter.

menu :-
    write('change.'), nl,
    write('Modifica um deslocamento existente do desenho.'), nl,
    write('commit.'), nl,
    write('Grava alteracoes de todos os desenhos no banco de dados.'), nl,
    write('load.'), nl,
    write('Carrega todos os desenhos do banco de dados para a memoria.'), nl,
    write('new(Id, X, Y).'), nl,
    write('Insere um deslocamento no desenho com identificador <Id>'), nl,
    write('(se primeira insercao, trata-se de um ponto inicial).'), nl,
    write('remove.'), nl,
    write('Remove um determinado deslocamento existente do desenho.'), nl,
    write('search.'), nl,
    write('Consulta pontos do desenho.'), nl,
    write('undo.'), nl,
    write('Remove o deslocamento inserido mais recentemente.').

change :-
    write('change(Id, X, Y, Xnew, Ynew).'), nl,
    write('Altera o ponto inicial de <Id>.'), nl,
    write('changeFirst(Id, Xnew, Ynew).'), nl,
    write('Altera o ponto inicial de <Id>'), nl,
    write('changeLast(Id, Xnew, Ynew).'), nl,
    write('Altera o deslocamento final de <Id>.').

search :-
    write('searchAll(Id).'), nl,
    write('Ponto inicial e todos os deslocamentos de <Id>.'), nl,
    write('searchFirst(Id, N).'), nl,
    write('Ponto inicial e os <N-1> primeiros deslocamentos de <Id>.'), nl,
    write('searchLast(Id, N).'), nl,
    write('Lista os <N> ultimos deslocamentos de <Id>.').

commit :-
    open('desenhos.pl', write, Stream),
    telling(Screen),
    tell(Stream),
    listing(xy),
    tell(Screen),
    close(Stream).

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
    asserta(xy(Id, X, Y)),
    asserta(list(Id, X, Y)),
    !.

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
    length(All, Size),
    Init is Size - N,
    between(Init, Size, Mid),
    nth0(Mid, All, Vertex),
    write(Vertex),
    write(' '),
    false.

undo:-
    list(X, Y, Z),
    retract(list(X, Y, Z)),
    retract(xy(X, Y, Z)),
    !.
