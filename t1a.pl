main.

fase(f1).
fase(f2).
fase(f3).
fase(f4).
fase(f5).
fase(f6).
fase(f7).
fase(f8).

% primeira fase
materia(eel5105, f1).
materia(ine5401, f1).
materia(ine5402, f1).
materia(ine5403, f1).
materia(mtm5161, f1).

% segunda fase
materia(ine5404, f2).
materia(ine5405, f2).
materia(ine5406, f2).
materia(ine5407, f2).
materia(mtm5512, f2).
materia(mtm7174, f2).

% terceira fase
materia(ine5408, f3).
materia(ine5409, f3).
materia(ine5410, f3).
materia(ine5411, f3).
materia(mtm5245, f3).

% quarta fase
materia(ine5412, f4).
materia(ine5413, f4).
materia(ine5414, f4).
materia(ine5415, f4).
materia(ine5416, f4).
materia(ine5417, f4).

% quinta fase
materia(ine5418, f5).
materia(ine5419, f5).
materia(ine5420, f5).
materia(ine5421, f5).
materia(ine5422, f5).
materia(ine5423, f5).

% sexta fase
materia(ine5424, f6).
materia(ine5425, f6).
materia(ine5426, f6).
materia(ine5427, f6).
materia(ine5430, f6).
materia(ine5453, f6).

% sétima fase
materia(ine5428, f7).
materia(ine5429, f7).
materia(ine5431, f7).
materia(ine5432, f7).
materia(ine5433, f7).

% oitava fase
materia(ine5434, f8).

depende(ine5404, ine5402).
depende(ine5405, mtm5161).
depende(ine5406, eel5105).
depende(mtm7174, mtm5161).

depende(ine5408, ine5404).
depende(ine5409, mtm5512). 
depende(ine5409, mtm7174).
depende(ine5410, ine5404).
depende(ine5411, ine5406).
depende(mtm5245, mtm5512).

depende(ine5412, ine5410).
depende(ine5412, ine5411).
depende(ine5413, ine5403).
depende(ine5413, ine5408).
depende(ine5414, ine5404).
depende(ine5415, ine5403).
depende(ine5415, ine5408).
depende(ine5416, ine5408).
depende(ine5417, ine5408).

depende(ine5418, ine5412).
depende(ine5418, ine5414).
depende(ine5419, ine5417).
depende(ine5420, ine5408).
depende(ine5420, mtm5245).
depende(ine5420, mtm7174).
depende(ine5421, ine5415).
depende(mtm5245, ine5414).
depende(ine5423, ine5408).

depende(ine5424, ine5412).
depende(ine5425, ine5405).
depende(ine5426, ine5421).
depende(ine5427, ine5417).
depende(ine5430, ine5405).
depende(ine5430, ine5416).
depende(ine5453, ine5417).

depende(ine5428, ine5407).
depende(ine5429, ine5403).
depende(ine5429, ine5414).
depende(ine5431, ine5414).
depende(ine5432, ine5423).
depende(ine5433, ine5427).

depende(ine5434, ine5433).

fase(X, Y) :- materia(X, Y).
