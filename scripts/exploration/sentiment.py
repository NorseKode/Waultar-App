import json
import sys
from pandas import DataFrame
import matplotlib.pyplot as plt
from sklearn.cluster import KMeans
# from datasketch import MinHash, MinHashLSH

plt.rcParams["figure.figsize"] = [20, 10]

pathToFile = "C:\\Users\\lukas\\Documents\\waultar\\performance\\"
fileName = "dataPoints.json"
# jsonData = json.load(open("C:\\Users\\lukas\\Documents\\Waultar\\performance\\dataPoints.json", encoding="utf8"))
jsonData = json.load(open(pathToFile + fileName, encoding="utf8"))

x_list = []
y_list = []
similar_values = []
count = 0
sentimentTextCount = 0
sentimentTextList = []

# m1 = MinHash(num_perm=128)

for point in jsonData:
    count = count + 1
    if point["sentimentScore"] != None and point["sentimentText"]:
        sentimentTextCount = sentimentTextCount + 1
        sentimentTextList.append(point["sentimentText"])
        x_list.append(count)
        y_list.append(point["sentimentScore"])
        if point["sentimentScore"] < 0.48 and point["sentimentScore"] > 0.44:
            similar_values.append((point["sentimentText"], point["sentimentScore"]))

print(f"##### Start of DataPoint Analysis ####")
print(f"Total amount of data points: {count}")
print(f"{sentimentTextCount} sentiment text found")
print(f"##### End of DataPoint Analysis ####")

rawData = {'x': x_list, 'y': y_list}
df = DataFrame(rawData, columns=['x','y'])

kmeans = KMeans(n_clusters=3).fit(df)
centroids = kmeans.cluster_centers_
# print(centroids)

plt.scatter(df['x'], df['y'], c= kmeans.labels_.astype(float), s=50, alpha=0.5)
plt.scatter(centroids[:, 0], centroids[:, 1], c='red', s=50)
plotPath = pathToFile + "scatterPlot.pdf"
plt.savefig(plotPath)

# saveFilePath = pathToFile + "similar_values.json"
# print(f"Writing a json file of similar values at: {saveFilePath}")
# saveFile = open(saveFilePath, 'w', encoding="utf8")
# json.dump(similar_values, saveFile, ensure_ascii=False)
