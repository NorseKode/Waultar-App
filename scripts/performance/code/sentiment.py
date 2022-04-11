import json
import os

def taggedImageReadingToConsole(path):
    taggedImages = json.load(open(path))

    totalTime = taggedImages["elapsedTime"]
    bucketRepoUpdateCount = 0
    bucketRepoUpdateTime = 0
    sentimentClassificationTime = taggedImages["childs"][0]["elapsedTime"]
    setupTime = 0
    _isOwnDataCount = 0
    _isOwnDataTime = 0
    cleanTextCount = 0
    cleanTextTime = 0
    classifyCount = 0
    classifyTime = 0
    repoCount = 0
    repoTime = 0
    info = taggedImages["childs"][1]["childs"]

    for point in info["childs"]:
        if point["key"] == "Setup":
            setupTime = point["elapsedTime"]
        if point["key"] == "_isOwnData":
            _isOwnDataCount = _isOwnDataCount + 1
            _isOwnDataTime = _isOwnDataTime + point["elapsedTime"]
        if point["key"] == "cleanText":
            cleanTextCount = cleanTextCount + 1
            cleanTextTime = cleanTextTime + point["elapsedTime"]
        if point["key"] == "classify":
            classifyCount = classifyCount + 1
            classifyTime = classifyTime + point["elapsedTime"]
        if point["key"] == "repo":
            repoCount = repoCount + 1
            repoTime = repoTime + point["elapsedTime"]

    print(f"Image tagging took {sentimentClassificationTime / 100000} seconds")
    print((f"\tWith the setup taking {setupTime / sentimentClassificationTime}"))
    print((f"\tWith the _isOwnData taking {_isOwnDataTime / sentimentClassificationTime}"))
    print((f"\tWith the clean text taking {cleanTextTime / sentimentClassificationTime}"))
    print((f"\tWith the classify taking {cleanTextTime / sentimentClassificationTime}"))