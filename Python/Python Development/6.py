class Solution():
    _newDic = {}

    def _reverse(self , file):
        for first , second in file.items():
            self._newDic[second] = first
        print(self._newDic)
if __name__ == "__main__":
    input_dict = {"A": 1, "B": 2, "C": 3}
    solution_instance = Solution()
    solution_instance._reverse(input_dict)

# Input dictionary
# input_dict = {"A": 1, "B": 2, "C": 3}

# Output dictionary
# Expected Output: {1: "A", 2: "B", 3: "C"}
