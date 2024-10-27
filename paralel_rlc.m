clear;  % Tüm değişkenleri temizler
clc;    % Komut penceresini temizler
close all;  % Tüm figür pencerelerini kapatır
% Parametrelerin tanımlanması
R = 46.807;    % Direnç (Ohm)
L = 0.00009312;   % Endüktans (H)
C = 0.000000680;  % Kapasitans (F)
I_in = 10;  % Sabit DC akım kaynağı (Amper)

% Zaman aralığı
tspan = [0 0.0003]; % 0 ile 5 saniye arasında analiz yapılacak

% Başlangıç koşulları
v0 = 0;  % Kondansatör üzerindeki gerilim başlangıçta sıfır (V)
iL0 = 0; % İndüktör akımı başlangıçta sıfır (A)

% Diferansiyel denklem fonksiyonu
% dv/dt = (1/C)*(I_in - v/R - iL)
odefun = @(t, x) [(I_in - x(1)/R - x(2))/C; (x(1))/L];

% Başlangıç koşulları: [V_C(0), i_L(0)]
x0 = [v0; iL0];

% Diferansiyel denklemi çözme
[t, x] = ode45(odefun, tspan, x0);

% Gerilim ve indüktör akımını alma
V = x(:,1);  % Düğüm gerilimi (kondansatör gerilimi)
i_L = x(:,2); % İndüktör akımı

% Rezonans frekansını hesaplama
f0 = 1 / (2 * pi * sqrt(L * C));

% Kalite faktörünü hesaplama
Q = R / sqrt(L / C);

% Sonuçların çizimi
figure;
subplot(1,1,1);
plot(t, i_L);
title('Paralel RLC Devresi - İndüktör Akımı (i_L)');
xlabel('Zaman (s)');
ylabel('Akım (A)');
text(tspan(end) * 0.7, max(i_L) * 0.9, ['f_0 = ', num2str(f0), ' Hz']);
text(tspan(end) * 0.7, max(i_L) * 0.8, ['Q = ', num2str(Q)]);