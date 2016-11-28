#..........................................

def getGraph(connections):
    """
    Get the adjacency list (dictionary) of a graph from a list of edges
    """
    # The graph in adjacency list form
    graph = dict()
    for i, j in connections:
        # Asociate node j with node i
        if i in graph:
            graph[i].append(j)
        else:
            graph[i] = [j]
        # Associate node j with i
        if j in graph:
            graph[j].append(i)
        else:
            graph[j] = [i]
        
    return graph

#...............................................
def getComponents(graph):
    """
    Get the connected components in the graph (as dictionary).
    Each one of them is returned as a set of the vertices that it comprises.
    The components are packed and returned as a list.
    """
    seen = set()
    components = []
    for node in graph.keys():
        if node not in seen:
            component = getComponent(graph, node)
            components.append(component)
            seen = seen | component # Set union
            
    return components
        
#.................................................
def getComponent(graph, node):
    """
    Get the connected component to which the node belongs.
    The component is returned as a set of nodes in the component
    """
    component = set()
    unseen = [node]
    # Walk through the graph
    while len(unseen) != 0:
        current = unseen.pop()
        component.add(current)
        for adjacent in graph[current]:
            if adjacent not in component:
                unseen.append(adjacent)
    
    return component
                
#..................................................
def getComponentsFromConnections(connections):
    """
    Get the connected components from the given connections.
    Summary of all of the above functions.
    """ 
    return getComponents(getGraph(connections))