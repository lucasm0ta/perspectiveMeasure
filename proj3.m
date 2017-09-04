% Deve usar o pacote geometry, se não tiver baixe em:
%     https://octave.sourceforge.io/geometry/index.html
% Para adicionar use o comendo: pkg install <nome do arquivo>

pkg load geometry

function [V_hat] = vec2skew(V)
%--------------------------------------------------------------------
%
% File: vec2skew.m
%
% Description:  Convert a 3x1 vector V to a 3x3 skew symmetric
% matrix V_hat such that for any 3x1 vector Y: (V x Y) = (V_hat)(Y)
%
% Inputs: 
%   V: 3x1 vector
% 
% Output:
%   V_hat: 3x3 cross product (skew symmetric) matrix
%
% Copyright (c) 2008 Jeffrey Byrne <jebyrne@gmail.com>
%
%--------------------------------------------------------------------
V_hat = [0 -V(3) V(2); V(3) 0 -V(1); -V(2) V(1) 0];
end

% Colocar o caminho para a imagem 1-2.
I = imread("~/UnB/PVC/IMGS/2-1.jpeg");
imshow(I)

%
% Desenhar linha dos planos para encontrar ponto de fuga e horizonte
%
args = {"linestyle", "-", "color", "g", "linewidth", 1.3};
line1 = createLine([655 464], [306 436]);
line2 = createLine([76 79], [422 43]);
drawLine(line1, args{:})
drawLine(line2, args{:})
% Primeiro ponto de fuga
pf1 = intersectLines(line1, line2);

args = {"linestyle", "-", "color", "yellow", "linewidth", 1.3};
line1 = createLine([427 44], [1100 172]);
line2 = createLine([17 640], [1164 408]);
drawLine(line1, args{:})
drawLine(line2, args{:})
% Segundo ponto de fuga
pf2 = intersectLines(line1, line2);

% Desenha linha do horizonte.
args = {"linestyle", "-", "color", "w", "linewidth", 1.3};
horizonLine =createLine(pf1, pf2);
drawLine(horizonLine, args{:})

% Pontos de cada pessoa. Para cada pessoa, os pontos tem um mesmo valor na
% horizontal e diferentes na vertical
edenEdge = [887, 254, 887, 459];
lucasEdge = [240, 239, 240, 590];

% Desenha a linha de altura de cada pessoa.
args = {"linestyle", "-", "color", "r", "linewidth", 2}
drawEdge(edenEdge, args{:})
drawEdge(lucasEdge, args{:})

%
% Calcular relação entre as pessoas.
%
args = {"linestyle", "--", "color", "magenta", "linewidth", 1.5};
fLine = createLine([lucasEdge(3), lucasEdge(4)], [edenEdge(3), edenEdge(4)]);
drawLine(fLine, args{:});

p = intersectLines(fLine, createLine(horizonLine));
hLine = createLine(p, [edenEdge(1), edenEdge(2)])
drawLine(hLine, args{:});

aux = createLine([lucasEdge(1), lucasEdge(2)],[lucasEdge(3), lucasEdge(4)])
edenH = intersectLines(hLine, aux)
args = {"linestyle", "-", "color", "cyan", "linewidth", 0.5};
drawEdge(edenH, [lucasEdge(3), lucasEdge(4)], args{:});

pixHeightEden = sqrt((edenH(1) - lucasEdge(3))**2 + (edenH(2) - lucasEdge(4))**2)
pixHeightLucas = sqrt((lucasEdge(1) - lucasEdge(3))**2 + (lucasEdge(2) - lucasEdge(4))**2)
edenRealH = (pixHeightEden/pixHeightLucas) * 1.69

%
% Calcular a matriz de rotação.
%
x_inf = [1 0 0 0];
y_inf = [0 1 0 0];
f = 25
K =[f 0 5.22;
    0 f 3.92;
    0 0 1];
K_1 = inv(K);

v1 = transpose([pf1 0]);
v2 = transpose([pf2 0]);
r1 = K_1*v1/norm(K_1*v1);
r2 = K_1*v2/norm(K_1*v2);
r3 = vec2skew(r1)*r2;
% hold
% plot3(r1, r2, r3)

