function metodo_lagrange_gui
    f = figure('Name','Interpolación de Lagrange','Position',[300 200 700 500]);

    % Datos precargados
    datos_iniciales = [0 1; 1 3; 2 2; 3 5; 4 4];

    % Etiqueta
    uicontrol(f,'Style','text','Position',[20 460 300 20],...
        'String','Puntos de interpolación (x, y):','FontWeight','bold');

    % Tabla con datos ya cargados
    tabla = uitable(f,'Data',datos_iniciales,...
        'ColumnName',{'x','y'},...
        'ColumnEditable',[false false],...
        'Position',[20 300 200 150]);

    % Ingreso de valor x a evaluar
    uicontrol(f,'Style','text','Position',[250 400 150 20],'String','Valor de x a evaluar:');
    xEvalField = uicontrol(f,'Style','edit','Position',[400 400 80 25]);

    % Botón para procesar
    uicontrol(f,'Style','pushbutton','String','Evaluar y Graficar',...
        'Position',[500 400 150 30],'Callback',@procesar);

    % Resultado
    resultadoText = uicontrol(f,'Style','text','Position',[250 360 400 30],...
        'String','Resultado: ','FontSize',10,'HorizontalAlignment','left');

    % Área de gráfica
    ax = axes(f,'Position',[0.1 0.1 0.8 0.35]);

    function procesar(~,~)
        datos = get(tabla,'Data');
        x = datos(:,1);
        y = datos(:,2);
        n = length(x);

        % Construir polinomio de Lagrange simbólicamente
        syms X
        L = 0;
        for i = 1:n
            li = 1;
            for j = 1:n
                if j ~= i
                    li = li * (X - x(j))/(x(i) - x(j));
                end
            end
            L = L + y(i)*li;
        end

        % Convertir a función evaluable
        f_L = matlabFunction(L);

        % Evaluar x ingresado
        x_eval = str2double(get(xEvalField,'String'));
        if isnan(x_eval)
            msgbox('Ingrese un número válido.','Error','error');
            return;
        end
        y_eval = f_L(x_eval);
        set(resultadoText,'String',sprintf('Resultado: f(%.3f) = %.4f', x_eval, y_eval));

        % Graficar
        xg = linspace(min(x)-1, max(x)+1, 500);
        yg = f_L(xg);

        cla(ax);
        plot(ax, xg, yg, 'b', 'LineWidth', 2); hold on;
        plot(ax, x, y, 'ro', 'MarkerSize', 8, 'DisplayName','Datos');
        plot(ax, x_eval, y_eval, 'ks', 'MarkerSize', 8, 'DisplayName','Evaluación');
        title(ax, 'Interpolación de Lagrange');
        xlabel(ax, 'x'); ylabel(ax, 'f(x)');
        grid(ax, 'on'); legend(ax, 'show');
        hold(ax, 'off');
    end
end
