function metodo_biseccion_gui
    f = figure('Name','Método de la Bisección','Position',[300 200 750 500]);

    % Entradas
    uicontrol(f,'Style','text','Position',[20 460 60 20],'String','f(x) =');
    fxField = uicontrol(f,'Style','edit','Position',[80 460 180 25]);

    uicontrol(f,'Style','text','Position',[270 460 30 20],'String','a:');
    aField = uicontrol(f,'Style','edit','Position',[300 460 50 25]);

    uicontrol(f,'Style','text','Position',[360 460 30 20],'String','b:');
    bField = uicontrol(f,'Style','edit','Position',[390 460 50 25]);

    uicontrol(f,'Style','text','Position',[450 460 90 20],'String','Error máx:');
    errField = uicontrol(f,'Style','edit','Position',[530 460 60 25]);

    uicontrol(f,'Style','pushbutton','String','Ejecutar',...
              'Position',[610 460 100 30],'Callback',@resolver);

    uicontrol(f,'Style','text','Position',[20 430 700 20],...
              'String','Teorema del Valor Intermedio: Si f(a)·f(b) < 0, existe al menos una raíz en [a,b].',...
              'HorizontalAlignment','left');

    tabla = uitable(f,'Position',[20 190 710 220],...
                    'ColumnName',{'#','a','b','P','f(P)','Error'},...
                    'ColumnEditable',false);

    ax = axes(f,'Position',[0.1 0.1 0.8 0.25]);

    function resolver(~,~)
        fxStr = get(fxField,'String');
        a = str2double(get(aField,'String'));
        b = str2double(get(bField,'String'));
        tol = str2double(get(errField,'String'));
        fcn = str2func(['@(x)', fxStr]);

        % Guardar intervalo original ampliado para graficar
        rango = 5;
        centro = (a + b) / 2;
        x_min = centro - rango;
        x_max = centro + rango;

        % Validar condición
        if fcn(a)*fcn(b) > 0
            msgbox('No se cumple f(a)·f(b) < 0. No se garantiza raíz en el intervalo.','Error','error');
            return;
        end

        % Inicializar
        iter = 0;
        error = inf;
        data = [];

        while error > tol
            iter = iter + 1;
            p = (a + b)/2;
            fp = fcn(p);

            if iter == 1
                error = NaN;
            else
                error = abs(p - p_ant);
            end

            data = [data; iter, a, b, p, fp, error];

            if fp == 0 || error < tol
                break;
            end

            if fcn(a)*fp < 0
                b = p;
            else
                a = p;
            end
            p_ant = p;
        end

        set(tabla, 'Data', data);

        % Gráfica
        x = linspace(x_min, x_max, 500);
        y = fcn(x);
        cla(ax);
        plot(ax, x, y, 'b', 'LineWidth', 2); hold on;
        yline(ax, 0, '--k');
        plot(ax, p, fcn(p), 'ro', 'MarkerSize', 8, 'DisplayName', 'Raíz');
        title(ax, 'Gráfica de f(x)');
        xlabel(ax, 'x'); ylabel(ax, 'f(x)');
        grid(ax, 'on');
        xlim(ax, [x_min x_max]);
        ylim(ax, [min(y)-1, max(y)+1]);
        hold(ax, 'off');
    end
end
