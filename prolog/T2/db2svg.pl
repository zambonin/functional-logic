%% INE5416 - Paradigmas de Programação (2015/2)
%%  Gustavo Zambonin (13104307)
%%  Lucas Kramer de Sousa (13100757)
%%  Marcello da Silva Klingelfus Junior (13100764)
%%
%% Original code by A. G. Silva

%% T2A
%% Usage: swipl -c db2svg.pl 2>/dev/null > picture.svg && rm a.out
%% Open the SVG file with your preferred viewer or `cat` its contents.
%% Requires consistent filenames (`desenhos.pl`)!

:- initialization(convert).

svgpath([], _).
svgpath(_, []).
svgpath([X|Lx], [Y|Ly]) :-
    write(X),
    write(','),
    write(Y),
    write(' '),
    svgpath(Lx, Ly).

svgheader :-
    writeln('<?xml version="1.0" encoding="UTF-8" standalone="no"?>'),
    write('<svg xmlns="http://www.w3.org/2000/svg" width="500.0" '),
    writeln('height="500.0" viewBox="0 0 500.0 500.0">').

svgbody([]).
svgbody([Id|T]) :-
    findall(X, xy(Id, X, _), Lx),
    findall(Y, xy(Id, _, Y), Ly),
    write('<path style="fill:none;stroke:#000000;stroke-width:1px" id="'),
    write(Id),
    write('" d="m '),
    svgpath(Lx, Ly),
    writeln('z"/>'),
    svgbody(T).

svgfooter :-
    writeln('</svg>').

convert :-
    retractall(xy(_, _, _)),
    consult('desenhos.pl'),
    findall(Id, xy(Id, _, _), L),
    list_to_set(L, Lid),
    svgheader,
    svgbody(Lid),
    svgfooter.
