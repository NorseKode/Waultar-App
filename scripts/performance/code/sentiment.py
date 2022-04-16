import json
import os
from .diagram_creator import *

def sentimentReadingToConsole(path, savePath):
    taggedImages = json.load(open(path))

    totalTime = taggedImages["elapsedTime"]
    childs = taggedImages["childs"]
    bucketRepoUpdateCount = 1
    bucketRepoUpdateTime = childs[0]["elapsedTime"]
    sentimentClassificationTime = childs[1]["elapsedTime"]
    setupTime = 0
    _isOwnDataCount = 0
    _isOwnDataTime = 0
    cleanTextCount = 0
    cleanTextTime = 0
    classifyCount = 0
    classifyTime = 0
    repoCount = 0
    repoTime = 0
    translateCount = 0
    translateTime = 0
    childs = taggedImages["childs"][1]["childs"]

    for point in childs:
        if point["key"] == "Setup":
            setupTime = point["elapsedTime"]
        if point["key"] == "_isOwnData":
            _isOwnDataCount = _isOwnDataCount + 1
            _isOwnDataTime = _isOwnDataTime + point["elapsedTime"]
        if point["key"] == "clean text":
            cleanTextCount = cleanTextCount + 1
            cleanTextTime = cleanTextTime + point["elapsedTime"]
        if point["key"] == "classify":
            classifyCount = classifyCount + 1
            classifyTime = classifyTime + point["elapsedTime"]
        if point["key"] == "repo":
            repoCount = repoCount + 1
            repoTime = repoTime + point["elapsedTime"]
        if point["key"] == "translate":
            translateCount = translateCount + 1
            translateTime = translateTime + point["elapsedTime"]

    # Setup percentage should probably be removed
    setupPercentage = setupTime / sentimentClassificationTime * 100
    _isOwnDataPercentage = _isOwnDataTime / sentimentClassificationTime * 100
    cleanTextPercentage = cleanTextTime / sentimentClassificationTime * 100
    classifyPercentage = classifyTime / sentimentClassificationTime * 100
    repoPercentage = repoTime / sentimentClassificationTime * 100
    translatePercentage = translateTime / sentimentClassificationTime * 100 if translateCount > 0 else 0
    other = 100 - setupPercentage - _isOwnDataPercentage - cleanTextPercentage - classifyPercentage - repoPercentage
    percentageData = [setupPercentage, _isOwnDataPercentage, cleanTextPercentage, classifyPercentage, repoPercentage, other]
    percentageLabel = ["Setup", "isOwnData", "Clean Text", "Classify", "Repository Calls", "Other"]
    createPieChart(percentageData, percentageLabel, "% Time Used in Sentiment Classifier", savePath)

    print(f"Sentiment classification took {totalTime / 1000000} seconds")
    print(f"\tWith the update of buckets repo taking {bucketRepoUpdateTime / totalTime * 100}% of the time")
    print(f"\tWith the sentiment classification taking {sentimentClassificationTime / totalTime * 100}% of the time")
    print("\tIn sentiment sentiment classification:")
    print(f"\t\tSetup")
    print(f"\t\t\tTook {setupPercentage}% of the time")
    print(f"\t\t\tand took {setupTime / 1000000} seconds")
    print(f"\t\t\tWas called {1} time")
    print(f"\t\t_isOwnData")
    print(f"\t\t\tTook {_isOwnDataPercentage}% of the time")
    print(f"\t\t\tand took {_isOwnDataTime / 1000000} seconds")
    print(f"\t\t\tWas called {_isOwnDataCount} time")
    print(f"\t\tClean Text")
    print(f"\t\t\tTook {cleanTextPercentage}% of the time")
    print(f"\t\t\tand took {cleanTextTime / 1000000} seconds")
    print(f"\t\t\tWas called {cleanTextCount} time")
    print(f"\t\tClassify")
    print(f"\t\t\tTook {classifyPercentage}% of the time")
    print(f"\t\t\tand took {classifyTime / 1000000} seconds")
    print(f"\t\t\tWas called {classifyCount} time")
    print(f"\t\tRepository calls")
    print(f"\t\t\tTook {repoPercentage}% of the time")
    print(f"\t\t\tand took {repoTime / 1000000} seconds")
    print(f"\t\t\tWas called {repoCount} time")
    if (translateCount > 0):
        print(f"\t\tTranslate")
        print(f"\t\t\tTook {classifyPercentage}% of the time")
        print(f"\t\t\tand took {classifyTime / 1000000} seconds")
        print(f"\t\t\tWas called {classifyCount} time")