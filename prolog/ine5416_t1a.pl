%% %%
%% INE5416 - Paradigmas de Programação (2015/2)
%% Grupo: Gustavo Zambonin (13104307)
%%        Lucas Kramer de Sousa (13100757)
%%        Marcello da Silva Klingelfus Junior (13100764)
%% %%

%% T1A

fase(f1).
fase(f2).
fase(f3).
fase(f4).
fase(f5).
fase(f6).
fase(f7).
fase(f8).

%% primeira fase
materia(eel5105, "Circuitos e Técnicas Digitais", f1).
materia(ine5401, "Introdução à Computação", f1).
materia(ine5402, "Programação Orientada a Objetos I", f1).
materia(ine5403, "Fundamentos de Matemática Discreta para Computação", f1).
materia(mtm5161, "Cálculo A", f1).

%% segunda fase
materia(ine5404, "Programação Orientada a Objetos II", f2).
materia(ine5405, "Probabilidade e Estatística", f2).
materia(ine5406, "Sistemas Digitais", f2).
materia(ine5407, "Ciência, Tecnologia e Sociedade", f2).
materia(mtm5512, "Geometria Analítica", f2).
materia(mtm7174, "Cálculo B para Computação", f2).

%% terceira fase
materia(ine5408, "Estruturas de Dados", f3).
materia(ine5409, "Cálculo Numérico para Computação", f3).
materia(ine5410, "Programação Concorrente", f3).
materia(ine5411, "Organização de Computadores I", f3).
materia(mtm5245, "Álgebra Linear", f3).

%% quarta fase
materia(ine5412, "Sistemas Operacionais I", f4).
materia(ine5413, "Grafos", f4).
materia(ine5414, "Redes de Computadores I", f4).
materia(ine5415, "Teoria da Computação", f4).
materia(ine5416, "Paradigmas de Programação", f4).
materia(ine5417, "Engenharia de Software I", f4).

%% quinta fase
materia(ine5418, "Computação Distribuída", f5).
materia(ine5419, "Engenharia de Software II", f5).
materia(ine5420, "Computação Gráfica", f5).
materia(ine5421, "Linguagens Formais e Compiladores", f5).
materia(ine5422, "Redes de Computadores II", f5).
materia(ine5423, "Banco de Dados I", f5).

%% sexta fase
materia(ine5424, "Sistemas Operacionais II", f6).
materia(ine5425, "Modelagem e Simulação", f6).
materia(ine5426, "Construção de Compiladores", f6).
materia(ine5427, "Planejamento e Gestão de Projetos", f6).
materia(ine5430, "Inteligência Artificial", f6).
materia(ine5453, "Introdução ao Trabalho de Conclusão de Curso", f6).

%% sétima fase
materia(ine5428, "Informática e Sociedade", f7).
materia(ine5429, "Segurança em Computação", f7).
materia(ine5431, "Sistemas Multimídia", f7).
materia(ine5432, "Banco de Dados II", f7).
materia(ine5433, "Trabalho de Conclusão de Curso I", f7).

%% oitava fase
materia(ine5434, "Trabalho de Conclusão de Curso II", f8).

%% dependências da segunda fase
depende(ine5404, ine5402).
depende(ine5405, mtm5161).
depende(ine5406, eel5105).
depende(mtm7174, mtm5161).

%% dependências da terceira fase
depende(ine5408, ine5404).
depende(ine5409, mtm5512).
depende(ine5409, mtm7174).
depende(ine5410, ine5404).
depende(ine5411, ine5406).
depende(mtm5245, mtm5512).

%% dependências da quarta fase
depende(ine5412, ine5410).
depende(ine5412, ine5411).
depende(ine5413, ine5403).
depende(ine5413, ine5408).
depende(ine5414, ine5404).
depende(ine5415, ine5403).
depende(ine5415, ine5408).
depende(ine5416, ine5408).
depende(ine5417, ine5408).

%% dependências da quinta fase
depende(ine5418, ine5412).
depende(ine5418, ine5414).
depende(ine5419, ine5417).
depende(ine5420, ine5408).
depende(ine5420, mtm5245).
depende(ine5420, mtm7174).
depende(ine5421, ine5415).
depende(ine5422, ine5414).
depende(ine5423, ine5408).

%% dependências da sexta fase
depende(ine5424, ine5412).
depende(ine5425, ine5405).
depende(ine5426, ine5421).
depende(ine5427, ine5417).
depende(ine5430, ine5405).
depende(ine5430, ine5416).
depende(ine5453, ine5417).

%% dependências da sétima fase
depende(ine5428, ine5407).
depende(ine5429, ine5403).
depende(ine5429, ine5414).
depende(ine5431, ine5414).
depende(ine5432, ine5423).
depende(ine5433, ine5427).

%% dependências da oitava fase
depende(ine5434, ine5433).
