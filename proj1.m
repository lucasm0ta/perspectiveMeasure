% Deve usar o pacote geometry, se não tiver baixe em:
%     https://octave.sourceforge.io/geometry/index.html
% Para adicionar use o comendo: pkg install <nome do arquivo>

pkg load geometry

% Colocar o caminho para a imagem 1-2.
I = imread("~/UnB/PVC/IMGS/1-2.jpeg");
imshow(I)

% Desenhar linha dos planos para encontrar ponto de fuga e horizonte
args = {"linestyle", "-", "color", "g", "linewidth", 1.3};
line1 = createLine([0 239], [688 184]);
line2 = createLine([0 408], [680 442]);
drawLine(line1, args{:})
drawLine(line2, args{:})
% Primeiro ponto de fuga
pf1 = intersectLines(line1, line2);

args = {"linestyle", "-", "color", "b", "linewidth", 1.3};
line1 = createLine([688 184], [1107 282]);
line2 = createLine([680 442], [1104 434]);
drawLine(line1, args{:})
drawLine(line2, args{:})
% Segundo ponto de fuga
pf2 = intersectLines(line1, line2);

% Desenha linha do horizonte.
args = {"linestyle", "-", "color", "w", "linewidth", 1.3};
drawLine(createLine(pf1, pf2), args{:})

% Pontos de cada pessoa. Para cada pessoa, os pontos tem um mesmo valor na
% horizontal e diferentes na vertical
edenEdge = [57, 313, 57, 448];
lucasEdge = [497, 322, 497, 501];

% Desenha a linha de altura de cada pessoa.
args = {"linestyle", "-", "color", "r", "linewidth", 2}
drawEdge(edenEdge, args{:})
drawEdge(lucasEdge, args{:})

%
% Calcular relação entre as pessoas.
%
args = {"linestyle", "-", "color", "red", "linewidth", 0.5};
hLine = createLine([lucasEdge(3), lucasEdge(4)], [edenEdge(3), edenEdge(4)]);
drawLine(hLine, args{:});

p = intersectLines(hLine, horizonLine);
fLine = createLine(p, [edenEdge(1), edenEdge(2)])
drawLine(fLine, args{:});

edenH = intersectLines(hLine, lucasEdge)

pixHeightEden = sqrt((edenH(1) - lucasEdge(3))**2 + (edenH(2) - lucasEdge(4))**2)
pixHeightLucas = sqrt((lucasEdge(1) - lucasEdge(3))**2 + (lucasEdge(2) - lucasEdge(4))**2)
diff = (pixHeightEden/pixHeightLucas) * 1.69

