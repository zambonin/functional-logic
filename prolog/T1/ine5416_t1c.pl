%% %%
%% INE5416 - Paradigmas de Programação (2015/2)
%% Grupo: Gustavo Zambonin (13104307)
%%        Lucas Kramer de Sousa (13100757)
%%        Marcello da Silva Klingelfus Junior (13100764)
%% %%

%% T1C

:- compile('t1a.pl').

%% questão 1
list_fase(List, F) :-
    findall(N, materia(_, N, F), List).
numero_disc_por_fase(F, L) :-
    list_fase(List, F),
    length(List, L).

%% questão 2
list_total(List) :-
    findall(X, materia(X, _, _), List).
numero_total_disc(L) :-
    list_total(List),
    length(List, L).

%% questão 3
list_tem_pre(List) :-
    setof(X, Dist^(depende(X, Dist)), List).
numero_disc_com_pre(L) :-
    list_tem_pre(List),
    length(List, L).

%% questão 4
list_sao_pre(List) :-
    setof(X, Dist^(depende(Dist, X)), List).
numero_disc_sao_pre(L) :-
    list_sao_pre(List),
    length(List, L).

%% questão 5
numero_pre_req_disc(N, L) :-
    setof(X, dep_recurs(N, X), Qnt),
    length(Qnt, L).

%% questão 6
max([R], R).
max([X|Xs], R):-
    max(Xs, T),
    (X > T -> R = X ; R = T).
most_pre_req(Y) :-
    findall(Z, numero_pre_req_disc(_, Z), QntReq),
    max(QntReq, K), numero_pre_req_disc(Y, K).

%% questão 7
list_numero_eh_determinada(List, N) :-
    findall(X, dep_recurs(X, N), List).
numero_disc_como_pre(N, L) :-
    list_numero_eh_determinada(List, N),
    length(List, L).

%% questão 8
qntPosReqDisciplina(X, Y) :-
    setof(Z, tranca_o_que(X, Z), All),
    length(All, Y).
disc_mais_importante(Y) :-
    findall(Z, qntPosReqDisciplina(_, Z), All),
    max(All, K),
    qntPosReqDisciplina(Y, K).

%% questão 9
seq(X, []) :-
    \+pre(X, _).
seq(X, [Y|L]) :-
    pre(X, Y),
    seq(Y, L).
questao9C(Y) :-
    findall(Z, (numero_pre_req_disc(_, Z)), All),
    max(All, M),
    numero_pre_req_disc(Y, M).

%% questão 10
%% * retorna a matéria com o maior número de pré-requisitos
calcular_maior_num_prereq(A, B) :-
    numero_pre_req_disc(A, Y),
    numero_pre_req_disc(B, V),
    (Y < V -> write(B); write(A)).
