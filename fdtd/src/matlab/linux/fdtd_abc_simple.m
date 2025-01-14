%% Одномерный FDTD.
% Добавлены поглощающие граничные условия
clear

% Число Куранта
Sc = 1.0;

% Волновое сопротивление свободного пространства
W0 = 120 * pi;

% Время расчета в отсчетах
maxTime = 300;

% Размер области моделирования в отсчетах
maxSize = 200;

% Положение датчика, регистрирующего поля
probePos = 60;

% Положение источника возбуждения
sourcePos = 100;

Ez = zeros (1, maxSize);
Hy = zeros (size (Ez));

% Поле, зарегистрированное в датчике в зависимости от времени
probeTimeEz = zeros (1, maxTime);

figure

for t = 1: maxTime
    % Расчет компоненты поля H
    Hy(end) = Hy(end - 1);

    for m = 1: maxSize - 1
        % До этой строки Hy(n) хранит значение компоненты Hy
        % за предыдущий момент времени
        Hy(m) = Hy(m) + (Ez(m + 1) - Ez(m)) * Sc / W0;
    end
    
    % Расчет компоненты поля E
    Ez(1) = Ez(2);
    
    for m = 2: maxSize
        % До этой строки Ez(n) хранит значение компоненты EzS
        % за предыдущий момент времени
        Ez(m) = Ez(m) + (Hy(m) - Hy(m - 1)) * Sc * W0;
    end

    % Источник возбуждения
    Ez(sourcePos) = Ez(sourcePos) + exp (-(t - 30.0) ^ 2 / 100.0);

    % Регистрация поля в точке
    probeTimeEz(t) = Ez(probePos);
    
    plot (Ez);
    xlim ([1, maxSize]);
    ylim ([-1.1, 1.1]);
    xlabel ('x, отсчет')
    ylabel ('Ez, В/м')
    grid on
    
    % Отображение положения источника и датчика
    hold on
    plot (probePos, 0, 'xk');
    plot (sourcePos, 0, '*r');
    hold off
    pause (0.03)
end

figure
plot (probeTimeEz)
xlabel ('t, отсчет')
ylabel ('Ez, В/м')
grid on