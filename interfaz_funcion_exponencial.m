function interfaz_funcion_exponencial
    % Crear ventana
    f = figure('Name', 'Función Exponencial', 'Position', [500 300 650 400]);

    % Etiquetas y campos de entrada
    uicontrol(f, 'Style', 'text', 'Position', [20 350 100 20], 'String', 'Valor de k:');
    kField = uicontrol(f, 'Style', 'edit', 'Position', [120 350 50 20]);

    uicontrol(f, 'Style', 'text', 'Position', [20 320 100 20], 'String', 'Valor de n:');
    nField = uicontrol(f, 'Style', 'edit', 'Position', [120 320 50 20]);

    uicontrol(f, 'Style', 'text', 'Position', [20 290 100 20], 'String', 'Valor de c:');
    cField = uicontrol(f, 'Style', 'edit', 'Position', [120 290 50 20]);

    % Botón para graficar
    uicontrol(f, 'Style', 'pushbutton', 'String', 'Graficar', ...
              'Position', [200 320 80 30], 'Callback', @graficar);

    % Área de resultados
    resultText = uicontrol(f, 'Style', 'text', 'Position', [20 250 600 30], ...
                          'HorizontalAlignment', 'left', 'String', '');

    % Axes para gráfica
    ax = axes(f, 'Position', [0.15 0.1 0.75 0.5]);

    % Función para graficar
    function graficar(~, ~)
        k = str2double(get(kField, 'String'));
        n = str2double(get(nField, 'String'));
        c = str2double(get(cField, 'String'));

        if isnan(k) || isnan(n) || isnan(c)
            msgbox('Por favor, ingresa valores numéricos válidos.', 'Error', 'error');
            return;
        end

        % Definir dominio y calcular función
        x = linspace(-10, 10, 500);
        y = k * x.^n + c;

        % Graficar función
        cla(ax);
        plot(ax, x, y, 'b', 'LineWidth', 2); hold(ax, 'on');

        % Graficar asíntota horizontal
        yline(ax, c, '--r', 'Asíntota: y = c');

        % Punto de corte con eje Y
        corteY = k * 0^n + c;
        plot(ax, 0, corteY, 'ko', 'MarkerSize', 8, 'DisplayName', 'Corte eje Y');

        % Buscar máximo o mínimo local (dentro del rango)
        [ymax, idxMax] = max(y);
        [ymin, idxMin] = min(y);
        plot(ax, x(idxMax), ymax, 'gd', 'MarkerSize', 8, 'DisplayName', 'Máximo');
        plot(ax, x(idxMin), ymin, 'md', 'MarkerSize', 8, 'DisplayName', 'Mínimo');

        % Mostrar etiquetas
        xlabel(ax, 'x'); ylabel(ax, 'f(x)');
        title(ax, 'Función Exponencial');
        grid(ax, 'on');

        % Mostrar ecuación en texto
        eqStr = sprintf('f(x) = %.2f·x^%.2f + %.2f | Corte Y: (0, %.2f)', ...
                         k, n, c, corteY);
        set(resultText, 'String', eqStr);

        % Mostrar ecuación en la gráfica
        text(ax, mean(x), mean(y), sprintf('f(x) = %.2f·x^{%.2f} + %.2f', k, n, c), ...
             'BackgroundColor', 'white', 'FontSize', 10);

        hold(ax, 'off');
    end
end
