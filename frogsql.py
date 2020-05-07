from typing import List, Dict, TypeVar, Iterable, Tuple, Any, Sequence, TextIO, Generator


class SQLWriter:
    def __init__(self, f: TextIO, dialect: str = "SQL Server", **kwargs):
        if dialect.lower() != 'sql server':
            raise NotImplementedError
        self.dialect = dialect.lower()
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
                        if self.dialect == 'sql server':
                            value = value.replace("'", "''")
                        else:
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
                        if self.dialect == 'sql server':
                            value = value.replace("'", "''")
                        else:
                            value = value.replace("'", r"\'")
                    text = f"N'{value}'"
                else:
                    raise ValueError(f"value '{value}' of class '{value.__class__.__name__} 'is not of valid type")
                lst.append(text)
        return f"({','.join(lst)})"

    def writerow(self, row: Iterable[Any]):
        self.f.write(f"    {self.convert_row(row)},\n")

    def writerows(self, rows: Iterable[Iterable[Any]]):
        n = 0
        lst = []
        for row in rows:
            lst.append(self.convert_row(row))
            n += 1
        text = ',\n    '.join(lst)
        if n > 1000 and self.dialect == 'sql server':
            raise ValueError("The number of row value expressions in the INSERT statement exceeds the maximum allowed number of 1000 row values.")
        self.f.write(f'    {text};\n')

    def write_delete(self, table_name: str):
        self.f.write(f"IF OBJECT_ID('dbo.{table_name}', 'U') IS NOT NULL\n    DELETE FROM {table_name};\nGO\n")

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


def writetable(data: List[Dict], table_name: str, filename: str):
    with open(filename, 'w', encoding='utf-8') as file:
        writer = DictWriter(file, data[0].keys())
        writer.writer.write_delete(table_name)
        iterable = data.__iter__()
        while True:
            datab = []
            n = 0
            for row in iterable:
                n += 1
                if n == 1000:
                    break
                datab.append(row)
            if not datab:
                break
            writer.writeheader(table_name)
            writer.writerows(datab)
