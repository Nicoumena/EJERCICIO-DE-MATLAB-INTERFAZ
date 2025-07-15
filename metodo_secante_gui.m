function metodo_secante_gui
    f = figure('Name','Método de la Secante','Position',[300 200 750 500]);

    % Entradas
    uicontrol(f,'Style','text','Position',[20 460 80 20],'String','f(x) =');
    fxField = uicontrol(f,'Style','edit','Position',[90 460 200 25]);

    uicontrol(f,'Style','text','Position',[310 460 80 20],'String','x0:');
    x0Field = uicontrol(f,'Style','edit','Position',[350 460 60 25]);

    uicontrol(f,'Style','text','Position',[420 460 80 20],'String','x1:');
    x1Field = uicontrol(f,'Style','edit','Position',[460 460 60 25]);

    uicontrol(f,'Style','text','Position',[530 460 90 20],'String','Error máx:');
    errField = uicontrol(f,'Style','edit','Position',[610 460 60 25]);

    uicontrol(f,'Style','pushbutton','String','Ejecutar',...
              'Position',[300 420 120 30],'Callback',@resolver);

    % Tabla de resultados
    tabla = uitable(f,'Position',[20 190 710 220],...
        'ColumnName',{'#','x_{n-1}','x_n','f(x_n)','Error'},...
        'ColumnEditable',false);

    % Área para la gráfica
    ax = axes(f,'Position',[0.1 0.1 0.8 0.25]);

    function resolver(~,~)
        % Leer datos
        fxStr = get(fxField,'String');
        x0 = str2double(get(x0Field,'String'));
        x1 = str2double(get(x1Field,'String'));
        tol = str2double(get(errField,'String'));
        fcn = str2func(['@(x)', fxStr]);

        iter = 0;
        error = inf;
        data = [];

        while error > tol && iter < 100
            iter = iter + 1;
            fx0 = fcn(x0);
            fx1 = fcn(x1);

            if fx1 - fx0 == 0
                msgbox('División por cero en iteración. Método detenido.','Error','error');
                return;
            end

            x2 = x1 - fx1 * (x1 - x0) / (fx1 - fx0);
            fx2 = fcn(x2);

            if iter == 1
                error = NaN;
            else
                error = abs(x2 - x1);
            end

            data = [data; iter, x0, x1, fx1, error];

            % Actualizar valores
            x0 = x1;
            x1 = x2;
        end

        set(tabla,'Data',data);

        % Graficar función
        xg = linspace(min(data(:,2))-2, max(data(:,3))+2, 500);
        yg = fcn(xg);
        cla(ax);
        plot(ax, xg, yg, 'b', 'LineWidth', 2); hold on;
        yline(ax, 0, '--k');
        plot(ax, x2, fx2, 'ro', 'MarkerSize', 8, 'DisplayName', 'Raíz');
        grid(ax, 'on');
        title(ax, 'Gráfica de f(x)');
        xlabel(ax, 'x'); ylabel(ax, 'f(x)');
        hold(ax, 'off');
    end
end
