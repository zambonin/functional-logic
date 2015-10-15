%% %%
%% INE5416 - Paradigmas de Programação (2015/2)
%% Grupo: Gustavo Zambonin (13104307)
%%        Lucas Kramer de Sousa (13100757)
%%        Marcello da Silva Klingelfus Junior (13100764)
%% %%

%% T1B

:- compile('t1a.pl').

%% questão 1
fase_disciplina(C, F) :-
    materia(C, _, F).

%% questão 2
nome_completo(C, N) :-
    materia(C, N, _).

%% questão 3
listar_por_fase(F, C) :-
    materia(C, _, F).

%% questão 4
dep_comum(X, Y, Z) :-
    depende(X, Z),
    depende(Y, Z),
    not(X=Y).

%% questão 5
listar_dep2(X, Z) :-
    depende(X, Y),
    depende(Y, Z).

%% questão 6
listar_eh_pre_req_por_fase(F, C) :-
    materia(C, _, F),
    depende(_, C).

%% questão 7
listar_tem_pre_req_por_fase(F, C) :-
    materia(C, _, F),
    depende(C, _).

%% questão 8
tudo_igual(M, N, F) :-
    materia(M, _, F),
    depende(M, W),
    depende(N, W),
    not(M=N).

%% questão 9
pre_req_anteriores(X, Y, Z) :-
    depende(X, Y),
    depende(Y, Z).

%% questão 10
%% * lista as matérias que dependem da entrada
tranca_o_que(C, N) :-
    depende(N, C).
tranca_o_que(C, N) :-
    depende(X, C),
    tranca_o_que(X, N).

%% desafio
dep_recurs(C, N) :-
    depende(C, N).
dep_recurs(C, N) :-
    depende(C, X),
    dep_recurs(X, N).
