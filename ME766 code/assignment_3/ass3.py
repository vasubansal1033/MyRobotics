import matplotlib.pyplot as plt
import matplotlib.image as mpimg
import numpy as np
import matplotlib.ticker as plticker
import sys
import math
import cv2
import time

# Define starting and goal positions
startX, startY = 50,50
goalX, goalY =  90,90

# Workspace Figure settings
fig = plt.figure()                                                               
ax = fig.add_subplot(1,1,1) 

# Loading Workspace Image
workspace = cv2.imread('workspace_1.jpg',0)
_, workspace = cv2.threshold(workspace, 127, 255, cv2.THRESH_BINARY)


# workspace coordinates are flipped
workspace[90:95,80:85]=0

workspaceplot = ax.imshow(workspace)

ax.scatter(startX, startY,marker='x',color='red')
ax.scatter(goalX, goalY, marker='o', color='blue')
ax.axis([0, 100, 0, 100])


w1 = 1
w2 = 1
class node():
    def __init__(self, xnode, ynode):
        self.x, self.y = xnode, ynode
        
        # Heuristic
        self.h = math.sqrt((self.x-goalX)**2+(self.y-goalY)**2)
        self.g = 10000000000
        self.f = 10000000000
        self.parentx = 0
        self.parenty = 0
        
# Getters and setters for f, g and h values
 
    def get_h(self):
        return self.h
    
    def get_g(self):
        return self.g
    def set_g(self,gval):
        self.g = gval
    
    def get_f(self):
        self.f = w1*self.g+w2*self.h
        return self.f
    
    def get_parent(self):
        return self.parentx, self.parenty    
    def set_parent(self,parentxval,parentyval):
        self.parentx=parentxval
        self.parenty=parentyval 
        
    def isValid(self):
        if(self.x>=0 and self.x<=100 and self.y>=0 and self.y<=100):
            return True
        else:
            return False
    def isObstacle(self):
        if(workspace[self.y][self.x]==0):
            return True
        else:
            return False
    def isDestination(self):
        if(self.x==goalX and self.y==goalY):
            return True
        else:
            return False


def retrace_path(currentNode, closedList):
    path = []
    temp = currentNode
    while(not(temp.x==startX and temp.y==startY)):
        print(temp.x,temp.y, temp.get_parent())
        a,b = temp.get_parent()
        path.append((a,b))
        temp = closedList[(a,b)]
        
    return path


def dist(currentNode, neighbour):
    return math.sqrt((currentNode.x-neighbour.x)**2+(currentNode.y-neighbour.y)**2)
                                                
major_ticks = np.arange(0, 100, 1)                                              
ax.set_xticks(major_ticks)                                                       
ax.set_yticks(major_ticks) 
ax.grid('on')


def algorithm():
    
    if(not node(startX, startY).isValid()):
        print('Starting position is not valid!')
        return None;
    if(not node(goalX, goalY).isValid()):
        print('Goal position is not valid!')
        return None;
    if(node(startX, startY).isObstacle()):
        print('Starting position is in obstacle!')
        return None;
    if(node(goalX, goalY).isObstacle()):
        print('Goal position is in obstacle!')
        return None;
    
    startingNode = node(startX, startY)
    startingNode.set_parent(startingNode.x, startingNode.y)
    startingNode.set_g(0)  
    
    openList = {}
    openList[(startingNode.x,startingNode.y)] = startingNode
    closedList = {}
    currentNode = startingNode
    
    
    while(not(len(openList)==0)):
        path = []
        # Finding the node with lowest f value in openlist, this will be our currentNode
        firstKey = list(openList)[0]
        currentNode = openList[firstKey]
        
        for node_ in openList.values():
            if(currentNode.get_f()>node_.get_f()):
                currentNode = node_
        
        
        
        print('.',end='')             
        
        ax.scatter(currentNode.x,currentNode.y,color='white',marker='o')
        plt.show()
        
        # If this node is the destination, we are finished        
        if(currentNode.isDestination()):  
    
            print('Destination found!')
            path = retrace_path(currentNode, closedList)
            return path, currentNode
        
        
        
        else:            
            
            del openList[(currentNode.x,currentNode.y)]
            closedList[(currentNode.x,currentNode.y)] = currentNode
            
            # Generate neighbors of current node
#             neighbours_of_current_node = [node((currentNode.x-1),currentNode.y),node(currentNode.x,(currentNode.y-1)),
#                                           node((currentNode.x-1),(currentNode.y-1)),node((currentNode.x+1),currentNode.y),
#                                           node(currentNode.x,(currentNode.y+1)),node((currentNode.x+1),(currentNode.y+1)),
#                                           node((currentNode.x+1),(currentNode.y-1)),node((currentNode.x-1),(currentNode.y+1))]
            
            neighbours_of_current_node = [node((currentNode.x),(currentNode.y)+1), node((currentNode.x)+1,(currentNode.y)+1),
                                          node((currentNode.x)+1,(currentNode.y)), node((currentNode.x)+1,(currentNode.y)-1),
                                          node((currentNode.x),(currentNode.y)-1), node((currentNode.x)-1,(currentNode.y)-1),
                                          node((currentNode.x)-1,(currentNode.y)), node((currentNode.x)-1,(currentNode.y)+1)]
    
            # Set parents of proper neighbours not in open list and closed list
            for neighbour in neighbours_of_current_node:
                
                if(neighbour.isValid() and not(neighbour.isObstacle())):
                    
                                        
                    if(neighbour.isDestination()):  
    
                        print('Destination found!')
                        neighbour.set_parent(currentNode.x,currentNode.y)
                        path = retrace_path(neighbour, closedList)
                        return path, currentNode
                    
                    if(neighbour in closedList.values()):
                        continue

                    tentative_gScore = currentNode.get_g()+ dist(currentNode, neighbour)

                    if(tentative_gScore<neighbour.get_g()):
                        
                        if(not(neighbour in openList.values())):

                            neighbour.set_parent(currentNode.x,currentNode.y)
                            openList[(neighbour.x,neighbour.y)]= neighbour
                            
                        openList[(neighbour.x,neighbour.y)].set_parent(currentNode.x,currentNode.y)                            
                        openList[(neighbour.x,neighbour.y)].set_g(tentative_gScore)

                        

plt.show()

path, node__ = algorithm()


