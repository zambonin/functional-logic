%% INE5416 - Paradigmas de Programação (2015/2)
%%  Gustavo Zambonin (13104307)
%%  Lucas Kramer de Sousa (13100757)
%%  Marcello da Silva Klingelfus Junior (13100764)
%%
%% Original code by A. G. Silva

%% T2B
%% DCG implementation showing a subset of Logo's possible commands
%% https://turtleacademy.com/playground/en

%% Understanding the DCG:
%%  pf N       move the turtle N units forwards
%%  pt N       move the turtle N units backwards
%%  gd N       turn the turtle N degrees rightwards
%%  ge N       turn the turtle N degrees leftwards
%%  repita     repeats the given command N times
%%  un         prevents drawing on the screen
%%  ul         reallows drawing on the screen
%%  tartaruga  clears drawings and moves the pencil to the center of the screen
%% Example: ?- comando([repita, '8', '[', pf, '50', gd, '45', ']'], []).

programa --> [].
programa --> comando, programa.

comando --> [pf], [N], { atom_number(N, X), parafrente(X) }.
comando --> [pt], [N], { atom_number(N, X), paratras(X) }.
comando --> [gd], [G], { atom_number(G, X), giradireita(X) }.
comando --> [ge], [G], { atom_number(G, X), giraesquerda(X) }.
comando --> [repita], [N], ['['], programa, [']'],  { atom_number(N, _) }.
comando --> [un], { usenada }.
comando --> [ul], { uselapis }.
comando --> [tartaruga], { tartaruga }.

eos([], []).

replace(_, _) --> call(eos), !.
replace(Find, Replace), Replace --> Find, !, replace(Find, Replace).
replace(Find, Replace), [C] --> [C], replace(Find, Replace).

substitute(Find, Replace, Request, Result):-
    phrase(replace(Find, Replace), Request, Result).

remove_g([], _, []):-
    !.
remove_g([X|T], X, L1) :-
    !,
    remove_g(T, X, L1).
remove_g([H|T], X, [H|L1]) :-
    remove_g(T, X, L1).

cmd(Comando) :-
    substitute("[", " [ ", Comando, R1),
    atom_codes(_, R1),
    substitute("]", " ] ", R1, R2),
    atom_codes(A2, R2),
    atomic_list_concat(L1, ' ', A2),
    remove_g(L1, '', Cmd),
    programa(Cmd, []).

%% References:
%% http://www.pathwayslms.com/swipltuts/dcg/
%% https://en.wikibooks.org/wiki/Prolog/Definite_Clause_Grammars
%% http://stackoverflow.com/q/6392725
%% https://en.wikipedia.org/wiki/Logo_(programming_language)
