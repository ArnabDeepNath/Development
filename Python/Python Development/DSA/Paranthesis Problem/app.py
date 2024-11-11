class Solution():

    def parenthesis(self , s):
        pairs = {
            "{" : "}",
            "(" : ")",
            "[" : "]",
        }
        stack = []
        for char in s:
            if char in pairs:
                stack.append(char)
            
            else:
                if not stack or pairs[stack.pop()] != char:
                    return False

        return not stack



solution = Solution()

print(solution.parenthesis("{]"))