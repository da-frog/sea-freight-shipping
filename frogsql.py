from typing import List, Dict, TypeVar, Iterable, Tuple, Any, Sequence, TextIO, Generator


class SQLWriter:
    def __init__(self, f: TextIO, dialect: str = "SQL Server", **kwargs):
        if dialect.lower() != 'sql server':
            raise NotImplementedError
        self.fieldtypes: List[str] = kwargs.pop('fieldtypes', None)
        self.check: List[str] = kwargs.pop('check', True)
        self.f = f

    def convert_row(self, row: Iterable[Any]) -> str:
        lst = []

        if self.fieldtypes is not None and self.check:
            for datatype, value in zip(self.fieldtypes, row):
                if value is None:
                    text = 'NULL'
                elif isinstance(value, int):
                    if datatype.lower() not in ('tinyint', 'smallint', 'int', 'bigint'):
                        raise ValueError(f"datatype '{datatype}' does not match value '{value}' of class {value.__class__.__name__}")
                    text = str(value)
                elif isinstance(value, float):
                    if datatype.lower() not in ('decimal', 'float'):
                        raise ValueError(f"datatype '{datatype}' does not match value '{value}' of class {value.__class__.__name__}")
                    text = str(value)
                elif isinstance(value, str):
                    if str == '':
                        text = 'NULL'
                        lst.append(text)
                        continue
                    # escape single quotes
                    if "'" in value:
                        value = value.replace("'", r"\'")

                    if datatype.startswith('varchar'):
                        text = f"'{value}'"
                    elif datatype.startswith('nvarchar'):
                        text = f"N'{value}'"
                    else:
                        raise ValueError(f"datatype '{datatype}' does not match value '{value}' of class {value.__class__.__name__}")
                else:
                    raise ValueError(f"value '{value}' of class '{value.__class__.__name__} 'is not of valid type")
                lst.append(text)
        else:
            for i, value in enumerate(row):
                if value is None:
                    text = 'NULL'
                elif isinstance(value, int):
                    text = str(value)
                elif isinstance(value, float):
                    text = str(value)
                elif isinstance(value, str):
                    if value == '':
                        text = 'NULL'
                        lst.append(text)
                        continue
                    # escape single quotes
                    if "'" in value:
                        value = value.replace("'", r"\'")
                    text = f"N'{value}'"
                else:
                    raise ValueError(f"value '{value}' of class '{value.__class__.__name__} 'is not of valid type")
                lst.append(text)
        return f"({','.join(lst)})"

    def writerow(self, row: Iterable[Any]):
        self.f.write(f"    {self.convert_row(row)},\n")

    def writerows(self, rows: Iterable[Iterable[Any]]):
        lst = []
        for row in rows:
            lst.append(self.convert_row(row))
        text = ',\n    '.join(lst)
        self.f.write(f'    {text};\n')

    def writeheader(self, table_name: str):
        self.f.write(f'INSERT INTO {table_name} VALUES\n')


class DictWriter:
    def __init__(self, f, fieldnames: Iterable[str], *, extrasaction: str = "raise",
                 dialect: str = "SQL Server", **kwargs):
        self.fieldnames = fieldnames    # list of keys for the dict
        if extrasaction.lower() not in ("raise", "ignore"):
            raise ValueError("extrasaction (%s) must be 'raise' or 'ignore'"
                             % extrasaction)
        self.extrasaction = extrasaction.lower()
        self.writer = SQLWriter(f, dialect)

    def _dict_to_list(self, rowdict) -> Generator:
        if self.extrasaction == "raise":
            wrong_fields = rowdict.keys() - self.fieldnames
            if wrong_fields:
                raise ValueError("dict contains fields not in fieldnames: "
                                 + ", ".join([repr(x) for x in wrong_fields]))
        return (rowdict.get(key, 'NULL') for key in self.fieldnames)

    def writeheader(self, table_name: str):
        self.writer.writeheader(table_name)

    def writerow(self, rowdict):
        return self.writer.writerow(self._dict_to_list(rowdict))

    def writerows(self, rowdicts):
        return self.writer.writerows(map(self._dict_to_list, rowdicts))


def writetable(filename: str, table_name: str, data: List[Dict]):
    with open(filename, 'w', encoding='utf-8') as csvfile:
        writer = DictWriter(csvfile, data[0].keys())
        writer.writeheader(table_name)
        writer.writerows(data)
