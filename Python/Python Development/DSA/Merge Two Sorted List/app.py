
class ListNode():

    def __init__(self , val=0 , next=None):
        self.val = val 
        self.next = next


class Solution():


    def merge(self , list1 , list2):

        dummy = ListNode(-1)
        current = dummy

        current_1 = list1
        current_2 = list2

        
        while current_1 and current_2:
            if current_1.val <= current_2.val:
                current.next = current_1
                current_1 = current_1.next
            else:
                current.next = current_2
                current_2 = current_2.next 
            current = current.next

        
        if current_1:
            current.next = current_1
        if current_2:
            current.next = current_2

        return dummy.next

# Initialize nodes
node1 = ListNode(1)
node2 = ListNode(2)
node3 = ListNode(3)
node4 = ListNode(4)

# Link the nodes for both lists
node1.next = node2  # List1: 1 -> 2
node3.next = node4  # List2: 3 -> 4

solution = Solution()
merged_head = solution.merge(node1, node3)


# Helper function to print the merged list
def print_linked_list(head):
    while head:
        print(head.val, end=" -> ")
        head = head.next
    print("None")

print_linked_list(merged_head)



# Lisk List

# class ListNode():

#     def __init__(self , val=0 , next=None):
#         self.val = val 
#         self.next = next


# node1 = ListNode(1)
# node2 = ListNode(2)

# current = node1
# node1.next = node2


# while current:
#     print(current.val)
#     current = current.next

# Basically a linked list have two things 
# Value and Node 
# The Head is determine starting positon
# The Next will determine the link of the list 
# The next of the last element will be linked to None