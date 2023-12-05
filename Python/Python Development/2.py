# Files Grouping
# Implemented on 29-09-2023
# Developer: Arnab Deep Nath
# Comments: Difficulty level of 5/10 in DSA


def group_by_owners(files):
    grouped_files = {}
    
    for file_name , owner in files.items():
        if owner in grouped_files:
            grouped_files[owner].append(file_name)
        else:
            grouped_files[owner] = [file_name]

    # Remove duplicates from the lists
    for owner, file_list in grouped_files.items():
        grouped_files[owner] = list(set(file_list))

    return grouped_files

if __name__ == "__main__":
    files = {
        'Input.txt': 'Randy',
        'Code.py': 'Stan',
        'Output.txt': 'Randy'
    }
    print(group_by_owners(files))
