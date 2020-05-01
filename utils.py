

def trim_file(file: str):
    with open(file, 'r') as f:
        lines = f.read().splitlines()

    trimmed = []
    for line in lines:
        if line == '':
            continue
        trimmed.append(line)

    with open(file, 'w') as f:
        f.write('\n'.join(trimmed))


if __name__ == '__main__':
    trim_file('scrape/test_ports.csv')
