import json

if __name__ == '__main__':
    with open('data/ports.json', 'r', encoding="utf8") as f:
        ports_dict = json.load(f)

    for port in ports_dict:
        # print(f"{port},{ports_dict[port]['name']},{ports_dict[port]['city']}"
        #       f",{ports_dict[port]['country']}")
        try:
            # print(f"{port}")
            # print(f"{ports_dict[port]['name']}")
            # print(f"{ports_dict[port]['city']}")
            # print(f"{ports_dict[port]['country']}")
            print(f"{ports_dict[port]['province']}")
        except KeyError:
            print("-")
