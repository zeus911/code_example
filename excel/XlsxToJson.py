from sys import argv
import xlrd
import json


def open_excel(file_path):
    try:
        data = xlrd.open_workbook(file_path)
        return data
    except Exception, e:
        print str(e)


def get_sheet_by_name(file_path, sheet_name):
    data = open_excel(file_path)
    table = data.sheet_by_name(sheet_name)
    nrows = table.nrows
    colnames = table.row_values(0)
    result = []
    for rownums in range(1, nrows):
        row = table.row_values(rownums)
        if row:
            obj = {}
            for i in range(len(colnames)):
                # if i == 0 or i == 4:
                obj[colnames[i]] = row[i]
            result.append(obj)
    return result


def main(arg):
    try:
        print "File path: %r; Sheet name: %r" % (arg[2], arg[4])
        tables = get_sheet_by_name(arg[2], arg[4])
        # for row in tables:
        #     print row
        with open(arg[6], "w") as f:
            f.write(json.dumps(tables))
            print "Write: %r" % (arg[6])
    except IOError, e:
        print str(e)
    except AttributeError, e:
        print str(e)
    except IndexError:
        print str("Usage: python XlsxToJson.py -f <file path> -s <sheet name> -w <writing file path>")
    except Exception, e:
        print str(e)


if __name__ == '__main__':
    main(argv)
