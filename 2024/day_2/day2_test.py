import itertools


def read_file(path):
    with open(path, "r") as f:
        file = f.read()

    lines = file.strip().split("\n")
    numbers = []
    for line in lines:
        numbers.append([int(x) for x in line.split(" ")])
    return numbers


def calculate_subsets(numbers):
    subsets = []
    for line in numbers:
        subsets.append([list(i) for i in itertools.combinations(line, len(line)-1)])
    return subsets


def is_safe(vec):
    diffs = []
    for i in range(len(vec)-1):
        diffs.append(vec[i+1] - vec[i])
    test_1 = [abs(i) <= 3 for i in diffs]
    test_2 = [i > 0 for i in diffs]
    test_3 = [i < 0 for i in diffs]

    return all(test_1) and (all(test_2) or all(test_3))


def run_subsets(subsets):
    acc = 0
    for sub in subsets:
        vec = []
        for line in sub:
            vec.append(is_safe(line))
        if any(vec):
            acc += 1
    return acc
print( sum([is_safe(x) for x in read_file("day2.txt")]))
print(run_subsets(calculate_subsets(read_file("day2.txt"))))
