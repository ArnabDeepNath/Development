class Solution(object):
    def addTwoNumber(self , l1 , l2):
        dummy = Node()
        current = dummy
        carry = 0
        
        while l1 or l2 or carry:
            val1 = l1.val if l1 else 0
            val2 = l2.val if l2 else 0
            total = val1 + val2 + carry


            carry = total //10
            current.next = Node(total % 10)
            current = current.next

            if l1:
                l1 = l1.next  
            if l2:
                l2 = l2.next 
        
        return dummy.next
        

# Creating Linked List 
class Node:
    def __init__(self , val=0 , next=None):
        self.val = val
        self.next = next 


class LinkedList:
    def __init__(self):
        self.head = None

    def append(self , val):
        new_node = Node(val)
        if self.head is None:
            self.head = new_node
        else:
            current = self.head
            while current.next:
                current = current.next
            current.next = new_node

    def display(self):
        current = self.head
        while current:
            print( current.val , end =" -> ")
            current = current.next 
        print("None")



# Calling the instance of linked list

ll_1 = LinkedList()
ll_2 = LinkedList()

ll_1.append(2)
ll_1.append(4)
ll_1.append(3)
ll_2.append(5)
ll_2.append(6)
ll_2.append(4)


ll_1.display()
ll_2.display()

# Calling the solution instance 
sol = Solution()

result = sol.addTwoNumber(ll_1.head , ll_2.head)

def display_result(node):
    while node:
        print(node.val , end=" -> ")
        node = node.next
    print("None")

display_result(result)