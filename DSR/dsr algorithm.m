% Initialize network parameters
numNodes = 10;
txRange = 20;
speed = 1;
pauseTime = 0.1;
maxIterations = 500;

% Initialize nodes
nodes = [];
for i = 1:numNodes
    node.x = randi([0, 100]);
    node.y = randi([0, 100]);
    node.id = i;
    node.route = [];
    node.visited = [];
    nodes = [nodes, node];
end

% Plot initial node positions
figure;
for i = 1:numNodes
    plot(nodes(i).x, nodes(i).y, 'bo', 'MarkerSize', 10);
    hold on;
end
xlim([0 100]);
ylim([0 100]);
title('Initial node positions');

% Start simulation
for iter = 1:maxIterations
    % Move nodes
    for i = 1:numNodes
        nodes(i).x = nodes(i).x + speed*randn();
        nodes(i).y = nodes(i).y + speed*randn();
    end
    
    % Plot node positions
    figure(1);
    clf;
    for i = 1:numNodes
        plot(nodes(i).x, nodes(i).y, 'bo', 'MarkerSize', 10);
        hold on;
    end
    xlim([0 100]);
    ylim([0 100]);
    title(sprintf('Node positions at iteration %d', iter));
    
    % Update routes
    for i = 1:numNodes
        nodes(i).visited = [];
        nodes(i).route = [];
    end
    for i = 1:numNodes
        for j = i+1:numNodes
            dist = sqrt((nodes(i).x - nodes(j).x)^2 + (nodes(i).y - nodes(j).y)^2);
            if dist <= txRange
                nodes(i).visited = [nodes(i).visited, j];
                nodes(j).visited = [nodes(j).visited, i];
            end
        end
    end
    for i = 1:numNodes
        if isempty(nodes(i).route)
            nodes(i).route = [i];
            for j = nodes(i).visited
                if isempty(intersect(nodes(j).route, nodes(i).route))
                    nodes(i).route = [nodes(i).route, j];
                end
            end
        end
    end
    
    % Pause simulation
    pause(pauseTime);
end
