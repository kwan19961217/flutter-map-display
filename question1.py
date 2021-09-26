nodes = {"a": {"b", "d", "h"},
		"b": {"a", "c", "d"},
		"c": {"b", "d", "f"},
		"d": {"a", "b", "c","e"},
		"e": {"d","f","h"},
		"f": {"c","e","g"},
		"g": {"f","h"},
		"h": {"a","g"}
		}

class Graph:

	def __init__(self, nodes = {}):
		self._nodes = nodes

	def getNodes(self):
		return self._nodes

	#question a
	def getRoutes(self, start_node, end_node, route = []):
		route = route + [start_node]

		if start_node == end_node:
			return [route]
		
		#deadend handling
		elif start_node not in self._nodes:
			return None

		routes = []

		for next_node in self._nodes[start_node]:

			#no repetition of same node
			if next_node not in route:

				#recursively finding routes
				routes.extend(self.getRoutes(next_node, end_node, route))

		return routes

	#question b
	def shortestRoutes(self, start_node, end_node):
		routes = self.getRoutes(start_node, end_node)
		return min(map(len, routes)) - 1

if __name__ == "__main__":
	g = Graph(nodes)
	[print(route) for route in g.getRoutes("a","h")]
	print(g.shortestRoutes("a","h"))