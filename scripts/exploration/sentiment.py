import json
import sys
from pandas import DataFrame

filePath = sys.argv[1]
jsonData = json.load(open(filePath, encoding="utf8"))
print(filePath)

x_list = []
y_list = []
count = 0
sentimentTextCount = 0

for point in jsonData:
    count = count + 1
    if "sentimentText" in point.keys() and len(point["sentimentText"]) > 0:
        sentimentTextCount = sentimentTextCount + 1
        x_list.append(count)
        y_list.append(point["sentimentText"])

print(f"##### Start of DataPoint Analysis ####")
print(f"Total amount of data points: {count}")
print(f"{sentimentTextCount} sentiment text found")
print(f"##### End of DataPoint Analysis ####")

