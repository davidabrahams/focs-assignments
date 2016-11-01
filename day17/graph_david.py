from Queue import Queue


class Graph(object):
    """
    A general representation of a graph. Supports both digraphs and
    non-directional graphs. Supports weights and no weights.
    """

    def __init__(self, nodes, edges, digraph=False, weighted=True):
        """
        Represent edges as to, from, weight tuples
        """
        self.nodes = nodes
        self.adjacency_list = {n: [] for n in nodes}
        self.weighted=weighted
        for e in edges:
            if weighted:
                self.adjacency_list[e[0]].append((e[0], e[1], e[2]))
            else:
                self.adjacency_list[e[0]].append((e[0], e[1]))
            if not digraph:
                if weighted:
                    self.adjacency_list[e[1]].append((e[1], e[0], e[2]))
                else:
                    self.adjacency_list[e[1]].append((e[1], e[0]))

    def MST(self):
        """
        Calculate the MST using Prim's algorithm
        """

        assert self.weighted

        mst_edges = []
        mst_nodes = []
        if len(self.nodes) == 0:
            return mst_nodes
        first_node = self.nodes[0]
        mst_nodes.append(first_node)
        
        # add all edges next to the starting node to the queue
        queue = [] # edges
        for e in self.adjacency_list[first_node]:
            queue.append(e)
        while len(mst_nodes) < len(self.nodes):

            # find the edge with the smallest weight
            next_edge = min(queue, key=lambda x: x[2])
            queue.remove(next_edge)

            fr, to, weight = next_edge

            # add the edge to the MST
            mst_edges.append(next_edge)
            mst_nodes.append(to)
            # add all edges with one vertex in the MST to the queue
            for e in self.adjacency_list[to]:
                # both vertices are in the MST, continue
                if e[1] in mst_nodes:
                    continue

                # if there is already an edge connecting this node
                for i in range(len(queue)):
                    if queue[i][1] == e[1]:
                        if e[2] < queue[i][2]:
                            queue[i] = e
                            break
                # that node is not in the queue
                else:
                    queue.append(e)
        return mst_edges

    def min_path(self, start):
        if not self.weighted:
            par, dis = self.bfs(start)
        else:
            par, dis = self.djikstra(start)
        return dis

    def djikstra(self, start):

        parents = {}
        distances = {n: float("inf") for n in self.nodes}
        distances[start] = 0
        parents[start] = None
        queue = {n for n in self.nodes}

        while len(queue) > 0:
            curr = min(queue, key=lambda x: distances[x])
            queue.remove(curr)
            for fr, to, weight in self.adjacency_list[curr]:
                new_dist = distances[fr] + weight
                if distances[to] > new_dist:
                    distances[to] = new_dist
                    parents[to] = fr

        return parents, distances

    def bfs(self, start):
        parents = {}
        distances = {}

        q = Queue()

        distances[start] = 0
        q.put(start)
        parents[start] = None

        while not q.empty():
            curr = q.get()
            for fr, to in self.adjacency_list[curr]:
                if to not in distances:
                    print "visiting " + to
                    distances[to] = distances[fr] + 1
                    parents[to] = fr
                    q.put(to)

        return parents, distances

g = Graph(['a', 'b', 'c', 'd', 'e'], [('a', 'b', 1), ('a', 'c', 6), ('b', 'c', 
    4), ('b', 'd', 3), ('d', 'c', 2), ('d', 'e', 6), ('c', 'e', 5)], weighted=True)

print "MST of tree: " + str(g.MST())
print "Min distance from a: " + str(g.min_path('a'))