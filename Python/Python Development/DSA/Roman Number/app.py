class Solution:

    def roman(self , s):
        dict = {
            "I" : 1,
            "V" : 5,
            "X" : 10,
            "L" : 50,
            "C" : 100,
            "D" : 500,
            "M" : 1000
        }

        sum = 0
        for i in range(len(s) - 1):
            if dict[s[i]] < dict[s[i+1]]:

                sum = sum - dict[s[i]]
            elif dict[s[i]] >= dict[s[i]]:
       
                sum = sum + dict[s[i]]
        sum = sum + dict[s[-1]]
        # if dict[s[i]] < dict[s[i+1]] then minus
        # if dict[s[i]] > dict[s[i+1]] then plus
        # if dict[s[i]] = dict[s[i+1]] then plus
        print(sum)



solution = Solution()

solution.roman("IX")
