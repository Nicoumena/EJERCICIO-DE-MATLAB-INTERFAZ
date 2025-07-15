function interfaz_funcion_lineal
    % Crear ventana
    f = figure('Name', 'Función Lineal', 'Position', [500 300 600 400]);

    % Etiquetas y campos de texto para los puntos
    uicontrol(f, 'Style', 'text', 'Position', [20 350 100 20], 'String', 'Punto 1 (x1, y1)');
    x1Field = uicontrol(f, 'Style', 'edit', 'Position', [130 350 50 20]);
    y1Field = uicontrol(f, 'Style', 'edit', 'Position', [190 350 50 20]);

    uicontrol(f, 'Style', 'text', 'Position', [20 320 100 20], 'String', 'Punto 2 (x2, y2)');
    x2Field = uicontrol(f, 'Style', 'edit', 'Position', [130 320 50 20]);
    y2Field = uicontrol(f, 'Style', 'edit', 'Position', [190 320 50 20]);

    % Botón para graficar
    uicontrol(f, 'Style', 'pushbutton', 'String', 'Graficar', ...
              'Position', [260 335 80 30], 'Callback', @graficar);

    % Axes para la gráfica
    ax = axes(f, 'Position', [0.1 0.1 0.8 0.5]);

    % Texto para mostrar ecuación
    eqText = uicontrol(f, 'Style', 'text', 'Position', [20 280 400 20], ...
                       'String', 'Ecuación: ', 'HorizontalAlignment', 'left');

    % Función callback
    function graficar(~, ~)
        % Leer valores
        x1 = str2double(get(x1Field, 'String'));
        y1 = str2double(get(y1Field, 'String'));
        x2 = str2double(get(x2Field, 'String'));
        y2 = str2double(get(y2Field, 'String'));

        % Validar datos
        if x1 == x2
            msgbox('x1 no puede ser igual a x2. La pendiente sería indefinida.', 'Error', 'error');
            return;
        end

        % Calcular pendiente y ordenada al origen
        m = (y2 - y1) / (x2 - x1);
        b = y1 - m * x1;

        % Crear vector x para graficar
        x = linspace(min(x1, x2)-2, max(x1, x2)+2, 100);
        y = m * x + b;

        % Limpiar y graficar
        cla(ax);
        plot(ax, x, y, 'b', 'LineWidth', 2); hold(ax, 'on');
        plot(ax, x1, y1, 'ro', 'MarkerSize', 8, 'DisplayName', 'Punto 1');
        plot(ax, x2, y2, 'go', 'MarkerSize', 8, 'DisplayName', 'Punto 2');
        plot(ax, 0, b, 'ks', 'MarkerSize', 8, 'DisplayName', 'Corte eje Y');
        plot(ax, -b/m, 0, 'ms', 'MarkerSize', 8, 'DisplayName', 'Corte eje X');
        grid(ax, 'on');
        xlabel(ax, 'x'); ylabel(ax, 'y');
        title(ax, 'Gráfica de la función lineal');

        % Mostrar ecuación
        eqStr = sprintf('Ecuación: f(x) = %.2fx + %.2f (pendiente = %.2f)', m, b, m);
        set(eqText, 'String', eqStr);
        
        % Agregar la ecuación como texto en la gráfica
        text(ax, mean(x), mean(y), eqStr, 'FontSize', 10, 'BackgroundColor', 'white');
        hold(ax, 'off');
    end
end
