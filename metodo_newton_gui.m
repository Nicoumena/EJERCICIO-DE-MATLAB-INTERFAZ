function metodo_newton_gui
    f = figure('Name','Método de Newton-Raphson','Position',[300 200 750 500]);

    % Entradas de usuario
    uicontrol(f,'Style','text','Position',[20 460 80 20],'String','f(x) =');
    fxField = uicontrol(f,'Style','edit','Position',[90 460 180 25]);

    uicontrol(f,'Style','text','Position',[280 460 80 20],'String','f''(x) =');
    dfxField = uicontrol(f,'Style','edit','Position',[360 460 180 25]);

    uicontrol(f,'Style','text','Position',[20 430 100 20],'String','x0 (inicial):');
    x0Field = uicontrol(f,'Style','edit','Position',[120 430 60 25]);

    uicontrol(f,'Style','text','Position',[200 430 100 20],'String','Error máx:');
    errField = uicontrol(f,'Style','edit','Position',[300 430 60 25]);

    uicontrol(f,'Style','pushbutton','String','Ejecutar',...
              'Position',[400 430 100 30],'Callback',@resolver);

    % Tabla
    tabla = uitable(f,'Position',[20 190 710 220],...
        'ColumnName',{'#','x','f(x)','Error'},...
        'ColumnEditable',false);

    % Área de gráfica
    ax = axes(f,'Position',[0.1 0.1 0.8 0.25]);

    function resolver(~,~)
        fxStr = get(fxField,'String');
        dfxStr = get(dfxField,'String');
        x0 = str2double(get(x0Field,'String'));
        tol = str2double(get(errField,'String'));

        fcn = str2func(['@(x)', fxStr]);
        dfcn = str2func(['@(x)', dfxStr]);

        % Inicialización
        iter = 0;
        error = inf;
        x = x0;
        data = [];

        while error > tol && iter < 100
            iter = iter + 1;
            fx = fcn(x);
            dfx = dfcn(x);

            if dfx == 0
                msgbox('La derivada es cero. No se puede continuar.','Error','error');
                return;
            end

            x_new = x - fx/dfx;

            if iter == 1
                error = NaN;
            else
                error = abs(x_new - x);
            end

            data = [data; iter, x, fx, error];
            x = x_new;
        end

        set(tabla,'Data',data);

        % Gráfica
        xg = linspace(x0 - 5, x0 + 5, 500);
        yg = fcn(xg);
        cla(ax);
        plot(ax, xg, yg, 'b', 'LineWidth', 2); hold on;
        yline(ax, 0, '--k');
        plot(ax, x, fcn(x), 'ro', 'MarkerSize', 8, 'DisplayName', 'Raíz');
        grid(ax, 'on');
        title(ax, 'Gráfica de f(x)');
        xlabel(ax, 'x'); ylabel(ax, 'f(x)');
        xlim(ax, [min(xg) max(xg)]);
        ylim(ax, [min(yg)-1 max(yg)+1]);
        hold(ax, 'off');
    end
end
