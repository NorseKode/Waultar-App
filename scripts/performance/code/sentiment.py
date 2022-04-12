import json
import os

def sentimentReadingToConsole(path):
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

    print(f"Sentiment classification took {totalTime / 100000} seconds")
    print(f"\tWith the update of buckets repo taking {bucketRepoUpdateTime / totalTime}% of the time")
    print(f"\tWith the sentiment classification taking {sentimentClassificationTime / totalTime}% of the time")
    print("\tIn sentiment sentiment classification:")
    print(f"\t\tThe setup took {setupTime / sentimentClassificationTime}% and was called {1} times")
    print(f"\t\tThe _isOwnData taking {_isOwnDataTime / sentimentClassificationTime}% and was called {_isOwnDataCount} times")
    print(f"\t\tThe clean text taking {cleanTextTime / sentimentClassificationTime}% and was called {cleanTextCount} times")
    print(f"\t\tThe classify taking {classifyTime / sentimentClassificationTime}% and was called {classifyCount} times")