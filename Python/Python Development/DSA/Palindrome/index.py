class Solution(object):

    def palindrome(self , x):

        conv = str(x)
        length = len(conv)

        print(length)
        if length < 2:
            print('False')
            return False
        elif length > 0:
            new_x = conv[::-1]
            if new_x == conv:
                print('True')
                return True
            elif x == 0:
                print("True")
                return True
            else:
                print('False')
                return False
        else:
            print('False')
            return False

solution = Solution()

solution.palindrome(0)


