import json

def classifyPerformanceToConsole(path):
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

    print(f"The image prediction ran in {totalTime / 1000000} seconds")
    print(f"On average a prediction took {predictAvgTime} seconds, with")
    print(f"\tPre processing:")
    print(f"\t\ton average takes {preProcessAvgTime} seconds")
    print(f"\t\twhich is {preProcessAvgTime / predictAvgTime * 100}% of the predict time")
    print(f"\tRun Predictions:")
    print(f"\t\ton average takes {runPredictionsAvgTimes} seconds")
    print(f"\t\twhich is {runPredictionsAvgTimes / predictAvgTime * 100}% of the predict time")
    print(f"\tGet Results:")
    print(f"\t\ton average takes {getResultsAvgTimes} seconds")
    print(f"\t\twhich is {getResultsAvgTimes / predictAvgTime * 100}% of the predict time")

    # print(f"Tree Parser took {totalTime / 1000000} seconds to parse {parsePathCount} files")
    # print(f"\tparsePath function used {parsePathTotalTime / totalTime}%, but it is the top function so it makes sense")
    # print(f"\tgetFromFolderName function used {getFromFolderNameTotalTime / totalTime}% and was called {getFromFolderNameCount} times")
    # print(f"\tparseName function used {parseNameTotalTime / totalTime}% and was called {parseNameCount} times")
    # print(f"\tcleanFileName function used {cleanFileNameTotalTime / totalTime}% and was called {cleanFileNameCount} times")
    # print(f"\taddCategoryTotalTime function used {addCategoryTotalTime / totalTime}% and was called {addCategoryCount} times")