import json
from .diagram_creator import *

def classifyPerformanceToConsole(path, savePath):
    data = json.load(open(path))

    totalTime = data["elapsedTime"]
    predictTimes = 0
    predictCounts = 0
    preProcessTimes = 0
    runPredictionsTimes = 0
    getResultsTimes = 0
    childs = data["childs"]

    for point in childs:
        if point["key"] == "Predict All":
            predictCounts = predictCounts + 1
            predictTimes = predictTimes + point["elapsedTime"]
            for reading in point["childs"]:
                if reading["key"] == "Pre process":
                    preProcessTimes = preProcessTimes + reading["elapsedTime"]
                if reading["key"] == "Run prediction":
                    runPredictionsTimes = runPredictionsTimes + reading["elapsedTime"]
                if reading["key"] == "Get results":
                    getResultsTimes = getResultsTimes + reading["elapsedTime"]

    predictAvgTime = predictTimes / predictCounts / 1000000
    preProcessAvgTime = preProcessTimes / predictCounts / 1000000
    runPredictionsAvgTimes = runPredictionsTimes / predictCounts / 1000000
    getResultsAvgTimes = getResultsTimes / predictCounts / 1000000
    preProcessPercentage = preProcessAvgTime / predictAvgTime * 100
    runPredictionPercentage = runPredictionsAvgTimes / predictAvgTime * 100
    getResultPercentage = getResultsAvgTimes / predictAvgTime * 100
    other = 100 - preProcessPercentage - runPredictionPercentage - getResultPercentage 
    percentageData = [preProcessPercentage, runPredictionPercentage, getResultPercentage, other]
    percentageLabel = ["Pre Process", "Run Predictions", "Get Results", "Other"]
    createPieChart(percentageData, percentageLabel, "Percentage of time used in predictions", savePath)

    print(f"The image prediction ran in {totalTime / 1000000} seconds")
    print(f"On average a prediction took {predictAvgTime} seconds, with")
    print(f"\tPre processing:")
    print(f"\t\ton average takes {preProcessAvgTime} seconds")
    print(f"\t\twhich is {preProcessPercentage}% of the predict time")
    print(f"\tRun Predictions:")
    print(f"\t\ton average takes {runPredictionsAvgTimes} seconds")
    print(f"\t\twhich is {runPredictionPercentage}% of the predict time")
    print(f"\tGet Results:")
    print(f"\t\ton average takes {getResultsAvgTimes} seconds")
    print(f"\t\twhich is {getResultPercentage}% of the predict time")
